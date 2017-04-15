require 'curses'
require 'rspec/its'
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

ARGV.clear # ARGV is used in a feature to load files
paths_to_load = ['../shared_examples/**/*.rb', '../../lib/**/*.rb']
paths_to_load.each do |path|
  Dir.glob(File.expand_path(path, __FILE__)).each do |file|
    next if file.match?(/features/)
    require file
  end
end

RSpec.configure do |c|
  c.before(:example) do
    window = instance_double('Curses::Window')
    class_double('Curses', stdscr: window).as_stubbed_const(transfer_nested_constants: true)
    class_double('Curses::Window').as_stubbed_const(transfer_nested_constants: true)

    allow(Curses).to receive(:color_pairs).and_return(256 * 256)
    allow(Curses).to receive(:init_pair)
    allow(Curses).to receive(:color_pair)
    allow(Curses).to receive(:init_screen)
    allow(Curses).to receive(:curs_set)
    allow(Curses).to receive(:raw)
    allow(Curses).to receive(:noecho)
    allow(Curses).to receive(:start_color)
    allow(Curses).to receive(:ESCDELAY=)
    allow(window).to receive(:subwin).and_return(window)
    allow(window).to receive(:maxx).and_return(100)
    allow(window).to receive(:maxy).and_return(100)
    allow(window).to receive(:erase)
    allow(window).to receive(:scrollok)
    allow(window).to receive(:<<)
    allow(window).to receive(:attron)
    allow(window).to receive(:attroff)
    allow(window).to receive(:refresh)
    allow(window).to receive(:keypad=)
  end
end