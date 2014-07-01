input_file_path = ARGV[0]
net_name = ARGV[1]
net_desc = net_name

net = KnowledgeNetStore::Net.where(:name => net_name).first
if !net.blank?
  net.destroy
end

json = IO.read(input_file_path)
KnowledgeNetStore::Net.from_json(net_name, net_desc, json)
p "import success!!"