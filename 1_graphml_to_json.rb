require 'fileutils'
require File.expand_path('../knowledge_xml_parser', __FILE__)

input_file_path = ARGV[0]
output_file_path = ARGV[1]

if !File.exists?(input_file_path)
  raise "#{input_file_path} is not exists!"
end

if File.exists?(output_file_path)
  raise "#{output_file_path} is exists!"
end

KnowledgeXmlParser.new(input_file_path).output(output_file_path)
p "create #{output_file_path} success"