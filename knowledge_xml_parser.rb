require 'rubygems'
require 'nokogiri'
require 'json'

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
        desc_dom = node_dom.at_css('data[key=d5]')
        desc = desc_dom.blank? ? "" : desc_dom.text
        {
          :id => node_dom["id"], 
          :name => node_dom.at_css('y|NodeLabel').children.first,
          :desc => desc
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