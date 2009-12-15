#!/usr/bin/env ruby
p "Changing to downloads folder..."
require 'FileUtils'

# get current user
username = `whoami`.gsub("\n", "")

# set the download dir
download_dir = "/Users/" +  username + "/Downloads"

#change to download dir
Dir.chdir(download_dir)

# array of folders
folders = []
files = []

#list download contents
Dir.foreach(".") do |entry|
   files << entry unless entry =~ /archive/
   folders << File::mtime(entry).strftime("%m-%y archive")
end

folders = folders.uniq

# make directories
folders.each do |f|
  p "[Creating " + f + "]"
  Dir.mkdir(f) rescue Errno::EEXIST
end

files.each do |f|
  arch_fold = File::mtime(f).strftime("%m-%y archive").to_s
  p "[Moving " + f + " to " + arch_fold + "]"
  
  
  FileUtils.move f, arch_fold + "/", :force => true


end

p "Done"