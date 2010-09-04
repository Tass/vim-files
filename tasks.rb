#!/usr/bin/env nake

PLUGINS_PATH = File.expand_path("~/.vim-plugins")

task(:plugins) do
  unless Dir.exists?(PLUGINS_PATH)
    Dir.mkdir(PLUGINS_PATH)
  end
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

task(:install, :symlinks, :plugins)
