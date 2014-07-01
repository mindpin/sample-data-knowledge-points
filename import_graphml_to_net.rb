
input_file_path = ARGV[0]

json_file_path = `ruby _import_graphml_to_json.rb #{input_file_path}`

net_name = File.basename(input_file_path,".graphml")
net_desc = net_name

net = KnowledgeNetStore::Net.where(:name => net_name).first
if !net.blank?
  net.destroy
end

json = IO.read(File.expand_path(json_file_path, __FILE__))
KnowledgeNetStore::Net.from_json(net_name, net_desc, json)
p "import success!!"