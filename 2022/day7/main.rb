#!/usr/bin/env ruby
require 'set'

input = File.read("input.txt")
terminal_output = input.split("\n")

class Directory
  attr_accessor :name, :path, :fileSizes, :childDirs

  def initialize(name, path)
    @name = name
    @path = path
    @fileSizes = []
    @childDirs = []
  end

  def find_dir (name, path)
    if @name == name && @path == path then
      true
    elsif childDirs.length == 0
       false
    else
      childDirs.map { |dir| dir.find_dir(name, path) }.reduce(:|)
    end
  end

  def get_dir (name, path)
    if @name == name && path == @path then
      self
    else
      childDirs.map { |dir| dir.get_dir(name, path) }.filter { |dir| dir != nil }.pop()
    end
  end

  def sum
    if childDirs.length == 0 then
      fileSizes.sum
    else
      fileSizes.sum + childDirs.map { |dir| dir.sum() }.sum
    end
  end
end

dir_stack = []
all_dirs = Set.new()
rootDir = Directory.new("/", "")

terminal_output.each { |line|
  if line.index("$ cd") == 0 then
    dir = line.split(" ")[2]
    if dir == "/" then
      dir_stack = []
      next
    end
    if dir == ".." then
      dir_stack.pop()
    else

      unless (rootDir.find_dir(dir, dir_stack.join("/"))) then
        parent_dir_name = if dir_stack.length == 0 then "/" else dir_stack[-1] end
        parent_dir = rootDir.get_dir(parent_dir_name, dir_stack.join("/"))
        dir_stack.push(dir)
        parent_dir.childDirs << Directory.new(dir, dir_stack.join("/"))
      end
      all_dirs << {dir => dir_stack.join("/")}
    end
  else
    current_dir = if dir_stack.length == 0 then "/" else dir_stack[-1] end
    unless line.index("dir") || line.index("$ ls") == 0 then
      file_size = line.split(" ")[0].to_i
      dir = rootDir.get_dir(current_dir, dir_stack.join("/"))
      dir.fileSizes << file_size
    end
  end
}

sums_under_100000 = 0
root_dir_sum = rootDir.sum
free_space_needed = 30000000 - (70000000 - root_dir_sum)
sums_to_free_space = []

all_dirs.each do |pair|
  dir = pair.keys[0]
  path = pair.values[0]
  sum = rootDir.get_dir(dir, path).sum
  if sum <= 100000 then
    sums_under_100000 += sum
  elsif sum >= free_space_needed
    sums_to_free_space << sum
  end
end

puts "Part 1: %s" % [sums_under_100000]
puts "Part 2: %s" % [sums_to_free_space.min]
