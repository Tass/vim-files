#!/usr/bin/env nake

exp = File.method(:expand_path)

task(:symlinks) do
  ["gvimrc", "vimrc"].each do |rc|
    if File.exists?(exp.call("~/.#{rc}"))
      puts "~./#{rc} exists."
    else
      File.symlink(exp.call(rc), exp.call("~/.#{rc}"))
    end
  end
  if File.exists?(exp.call("~/.vim"))
    puts "~/.vim exists"
  else
    File.symlink(exp.call("."), exp.call("~/.vim"))
  end
end

task(:submodules) do
  system "git submodule init"
  system "git submodule update"
end

task(:command_t) do
  Dir.chdir("bundle/command-t/ruby/command-t") do
    system "rm *.o"
    system "ruby extconf.rb"
    system "make"
  end
end

task(:install, :symlinks, :submodules, :command_t)
