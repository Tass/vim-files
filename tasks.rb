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

PLUGINS_PATH = "~/.vim-plugins"

task(:plugins) do
  Dir.mkdir(PLUGINS_PATH)
  Dir.chdir(PLUGINS_PATH) do
    system "git clone git://github.com/MarcWeber/vim-addon-manager.git"
  end
end

task(:command_t) do
  Dir.chdir(PLUGINS_PATH + "/Command-T/ruby/command-t") do
    system "rm *.o"
    system "ruby extconf.rb"
    system "make"
  end
end

task(:install, :symlinks, :plugins, :command_t)
