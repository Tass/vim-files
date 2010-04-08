#!/usr/bin/env nake

exp = File.method(:expand_path)

task(:symlinks) do
  File.symlink(exp.call("vimrc"), exp.call("~/.vimrc")) unless File.exists?(exp.call("~/.vimrc"))
  File.symlink(exp.call("."), exp.call("~/.vim")) unless File.exists?(exp.call("~/.vim"))
end

task(:submodules) do
  system "git submodule init"
  system "git submodule update"
end

task(:command_t) do
  Dir.chdir("bundle/command-t/ruby/command-t") do
    system "ruby extconf.rb"
    system "make"
  end
end

task(:install, :symlinks, :submodules, :command_t)
