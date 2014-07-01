require 'fileutils'
require File.expand_path('../knowledge_xml_parser', __FILE__)

input_file_path = ARGV[0]

if !File.exists?(input_file_path)
  raise "#{input_file_path} is not exists!"
end

output_file_path = File.expand_path("temp.json", __FILE__)
KnowledgeXmlParser.new(input_file_path).output(output_file_path)
p output_file_path