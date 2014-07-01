require 'fileutils'
require File.expand_path('../knowledge_xml_parser', __FILE__)

input_file_path = ARGV[0]

if !File.exists?(input_file_path)
  raise "#{input_file_path} is not exists!"
end

output_file_path = File.expand_path("temp.json", __FILE__)
KnowledgeXmlParser.new(input_file_path).output(output_file_path)


net_name = File.basename(input_file_path,".graphml")
net_desc = net_name

net = KnowledgeNetStore::Net.where(:name => net_name).first
if !net.blank?
  net.destroy
end

json = IO.read(File.expand_path(output_file_path, __FILE__))
KnowledgeNetStore::Net.from_json(net_name, net_desc, json)
p "import success!!"