# -*- coding: utf-8 -*-

path = File.dirname(File.expand_path __FILE__)
command = "ruby #{path}/y11bot.rb < #{path}/token.txt"

puts command if true
exec command
