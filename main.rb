require 'rubygems'
require 'srt'
require 'neo4j'
require 'neo4j-core'

session = Neo4j::Session.open(:server_db)

# subtitle_label = Neo4j::Label.create(:Subtitle)
# subtitle_label.create_index(:text)

files = ["Africa.S01E01.srt", "Africa.S01E02.srt"]

files.each { |file|

  file_name = file
  video = Neo4j::Node.create({name: file_name}, :Video)
  video[:production] = "BBC"
  video[:created_by] = "David Attenborough"

  file = SRT::File.parse(File.new(file_name))
  file.lines.each do |line|
    subtitle = Neo4j::Node.create({text: line.text[0], start_time: line.start_time, end_time:line.end_time}, :Subtitle)
    Neo4j::Relationship.create(:contains, video, subtitle)
  end

}

# Search any subtitles for 'meerkats'
# MATCH (n:Subtitle) WHERE n.text =~ '.*meerkats.*' RETURN n, n.text;

# Delete all nodes and relationships
# START n = node(*)
# OPTIONAL MATCH n-[r]-()
# WHERE (ID(n)>0 AND ID(n)<10000)
# DELETE n, r;