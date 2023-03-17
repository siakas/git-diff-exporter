#!/usr/bin/env ruby

require 'optparse'
require 'fileutils'

options = {
  output: nil,
  format: nil
}

OptionParser.new do |opts|
  opts.banner = "Usage: git-export-diff.rb [options] commit1 commit2"

  opts.on("-oOUTPUT", "--output=OUTPUT", "Output path") do |output|
    options[:output] = output
  end

  opts.on("-fFORMAT", "--format=FORMAT", "Output name format (ex. OUTPUT-%Y%m%d)") do |format|
    options[:format] = format
  end
end.parse!

if ARGV.size != 2
  puts "Please provide two commit hashes"
  exit 1
end

commit1, commit2 = ARGV

diff_files = `git diff --name-only #{commit1} #{commit2}`.strip.split("\n")

if diff_files.empty?
  puts "No files to export"
  exit 0
end

output_name = options[:format] ? Time.now.strftime(options[:format]) : "diff-#{commit1[0, 7]}-#{commit2[0, 7]}"
output_path = File.expand_path(options[:output] || "..")

FileUtils.mkdir_p(output_path) unless Dir.exist?(output_path)

diff_files.each do |file|
  source_path = File.join(Dir.pwd, file)
  target_path = File.join(output_path, output_name, file)

  if File.exist?(source_path)
    FileUtils.mkdir_p(File.dirname(target_path))
    FileUtils.cp(source_path, target_path)
    puts "Copied: #{source_path} -> #{target_path}"
  end
end

puts "Exported diff to #{File.join(output_path, output_name)}"