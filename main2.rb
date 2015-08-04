require 'rubygems'
require 'srt'
require 'neo4j'
require 'neo4j-core'

file_name = "Africa.S01E01.srt"


file = SRT::File.parse(File.new(file_name))

file.lines.each_slice(10){ |batch|
    batch_start_time = batch.first.start_time.to_s
    batch_end_time = batch.last.end_time.to_s
    batch.each { |line|
      batch_line = line.text.join(" ")
      print batch_line
    }
    puts " "
    puts batch_start_time + " to " + batch_end_time
    puts " "
}

