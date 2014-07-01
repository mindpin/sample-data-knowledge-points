require 'fileutils'
require './knowledge_xml_parser'



p "1 js"
p "2 art"

argv_is_correct = false
while !argv_is_correct
  p "select(1/2):"
  index = gets.sub("\n","")
  argv_is_correct = true if ["1","2"].include?(index)
end

if index == "1"
  input_file_path = "js.graphml"
  output_file_path = "js/js.json"
  FileUtils.mkdir("js") if !File.exists?("js")
elsif index == "2"
  input_file_path = "art.graphml"
  output_file_path = "art/art.json"
  FileUtils.mkdir("art") if !File.exists?("art")
end

KnowledgeXmlParser.new(input_file_path).output(output_file_path)