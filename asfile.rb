#!/usr/bin/ruby

temp_filename = 'output.temp'

file_opener = ARGV[0]
command = ARGV[1]

keep = ARGV[2..-1].any? { |parameter| parameter.include? '--keep' } if ARGV.size > 2

if ARGV.size < 2
  puts "usage: asfile \"command to open file\" \"command to generate output\" [--keep]"
  puts "--keep output file will be kept"
  exit
end

puts "redirecting output of \"#{command}\" to \"#{temp_filename}\""

output = %x(#{command})

File.open temp_filename, 'w' do |file|
  file.write(output)
end

open_command = file_opener + ' ' + temp_filename

puts "opening output with \"#{open_command}\""

system(open_command)

if keep
  puts "keeping file #{temp_filename}"
else
  File.delete(temp_filename)
end
