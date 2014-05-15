require 'rubygems'
require 'nokogiri'
require 'json'
require 'fileutils'

class KnowledgeXmlParser

  def initialize(file_path)
    str = File.new(file_path).read

    @file_xml = Nokogiri::XML str
  end

  def nodes
    @file_xml.css('graphml > graph > node')
  end

  def edges
    @file_xml.css('graphml > graph > edge')
  end

  def output(output_file_path)
    hash = _build_hash
    json = JSON.generate(hash)
    IO.write(output_file_path, json)
  end

  private
    def _build_hash
      points_arr = nodes.map do |node_dom|
        {
          :id => node_dom["id"], 
          :name => node_dom.at_css('y|NodeLabel').children.first,
          :desc => node_dom.at_css('data[key=d5]').text
        }
      end

      edges_arr = edges.map do |link|
        {
          :parent => link["source"],
          :child  => link["target"]
        }
      end

      {
        :points => points_arr,
        :edges => edges_arr
      }
    end

    # 产生一个随机字符串
    def randstr(length = 6)
      base = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      size = base.size
      re = '' << base[rand(size-10)]
      (length - 1).times {
        re << base[rand(size)]
      }
      re
    end

end

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