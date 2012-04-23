#!/usr/bin/ruby -w

# Create symlinks in home directory.
#
# This script will do nothing unless -f is passed to it.

require 'fileutils'
require 'rbconfig'

HOME = ENV["HOME"]
EVIL_HOME = "#{HOME}/c"
EVIL_WORK = "#{HOME}/w"
TARGET = HOME
OS = Config::CONFIG['host_os']

def is_mac?
  return OS =~ /^darwin/
end

if ARGV.include?("-f")
  puts "Actually doing stuff."
  include FileUtils::Verbose
  puts
else
  puts "Dry run only. Set -f to force."
  include FileUtils::DryRun
  puts
end

ln_sf("#{EVIL_HOME}/dotfiles/screenrc", "#{TARGET}/.screenrc")
ln_sf("#{EVIL_HOME}/dotfiles/vimrc", "#{TARGET}/.tvnamer.json")
ln_sf("#{EVIL_HOME}/dotfiles/tvnamer.json", "#{TARGET}/.tvnamer.json")
ln_sf("#{EVIL_HOME}/dotfiles/brackup.conf", "#{TARGET}/.brackup.conf")

if File.exists?(EVIL_WORK)
  mkdir_p("#{TARGET}/.getmail")
  ln_sf("#{EVIL_WORK}/backup/getmailrc", "#{TARGET}/.getmail/getmailrc")
end

# Link binaries
ln_sf("/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl",
      "#{EVIL_HOME}/bin/subl") if is_mac?