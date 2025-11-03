# frozen_string_literal: true

require 'shellwords'

module Ffwd
  module FFmpeg
    FREEZE_START_PATTERN = /freeze_start:\s*([\d.]+)/
    FREEZE_END_PATTERN = /freeze_end:\s*([\d.]+)/

    def self.parse_duration(output)
      output.strip.to_f
    end

    def self.parse_freezes(output)
      regions = []
      freeze_start = nil

      output.each_line do |line|
        if line =~ FREEZE_START_PATTERN
          freeze_start = ::Regexp.last_match(1).to_f
        elsif line =~ FREEZE_END_PATTERN && freeze_start
          freeze_end = ::Regexp.last_match(1).to_f
          regions << [freeze_start, freeze_end]
          freeze_start = nil
        end
      end

      regions
    end

    def self.get_duration(file_path)
      raise ArgumentError, "File not found: #{file_path}" unless File.exist?(file_path)

      cmd = [
        'ffprobe',
        '-v', 'error',
        '-show_entries', 'format=duration',
        '-of', 'default=noprint_wrappers=1:nokey=1',
        file_path
      ].shelljoin

      output = `#{cmd}`
      parse_duration(output)
    end

    def self.detect_freezes(file_path, noise_threshold: -70, min_duration: 1.0)
      raise ArgumentError, "File not found: #{file_path}" unless File.exist?(file_path)

      cmd = [
        'ffmpeg',
        '-i', file_path,
        '-vf', "freezedetect=n=#{noise_threshold}dB:d=#{min_duration}",
        '-f', 'null',
        '-'
      ].shelljoin

      output = `#{cmd} 2>&1`
      parse_freezes(output)
    end
  end
end
