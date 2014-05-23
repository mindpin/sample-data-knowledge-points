p "which import"
p "1 js"
p "2 art"

argv_is_correct = false
while !argv_is_correct
  p "select(1/2):"
  index = gets.sub("\n","")
  argv_is_correct = true if ["1","2"].include?(index)
end

if index == "1"
  input_file_path = "js/js.json"
  net_name = "Javascript"
  net_desc = "Javascript 的基础知识"
elsif index == "2"
  input_file_path = "art/art.json"
  net_name = "绘画"
  net_desc = "绘画的基础知识"
end

net = KnowledgeNetStore::Net.where(:name => net_name).first
if !net.blank?
  net.destroy
end

json = IO.read(input_file_path)
KnowledgeNetStore::Net.from_json(net_name, net_desc, json)
p "import success!!"