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

def symlink(source, dest)
  if File.exists?(dest)
    puts "WARNING: #{dest} already exists."
  else
    ln_sf(source, dest)
  end
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

symlink("#{EVIL_HOME}/dotfiles/screenrc", "#{TARGET}/.screenrc")
symlink("#{EVIL_HOME}/dotfiles/vimrc", "#{TARGET}/.tvnamer.json")
symlink("#{EVIL_HOME}/dotfiles/tvnamer.json", "#{TARGET}/.tvnamer.json")
symlink("#{EVIL_HOME}/dotfiles/brackup.conf", "#{TARGET}/.brackup.conf")

if is_mac?
  symlink("/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl",
        "#{EVIL_HOME}/bin/subl") if is_mac?
  symlink("#{EVIL_HOME}/dotfiles/sublime/mac",
          "#{TARGET}/Library/Application Support/Sublime Text 2/Packages/User")
else
  symlink("#{EVIL_HOME}/dotfiles/sublime/linux",
        "#{TARGET}/.config/sublime-text-2/Packages/User")
end

if File.exists?(EVIL_WORK)
  mkdir_p("#{TARGET}/.getmail")
  symlink("#{EVIL_WORK}/backup/getmailrc", "#{TARGET}/.getmail/getmailrc")
  symlink("#{EVIL_WORK}/TODO", "#{TARGET}/TODO")
end
