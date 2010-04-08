#!/usr/bin/env nake

exp = File.method(:expand_path)

task(:symlinks) do
  File.symlink(exp.call("vimrc"), exp.call("~/.vimrc"))
  File.symlink(exp.call("."), exp.call("~/.vim")) unless File.exists?(exp.call("~/.vim"))
end

task(:submodules) do
  system "git submodule init"
  system "git submodule update"
end

task(:install, :symlinks, :submodules)
