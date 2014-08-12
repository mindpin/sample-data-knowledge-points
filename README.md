sample-data-knowledge-points
============================

用于学科知识数据库（KnowledgeCamp）演示需求的示例知识点结构数据，以及示例知识点内容信息。

## 知识点网络结构

json 数据结构如下
```javascript
{
  "points" : [
    {
      "id" : randstr,
      "name" : stringxxx,
      "desc" : stringxxx
    },
    ...
  ],
  "edges" : [
    {
      "parent" : knowledge_point.id,
      "child"  : knowledge_point.id
    },
    ...
  ]
}
```

## 数据生成方式

js.graphml 是 yed 工具编辑的文件

生成数据的步骤<br>
1 把用 yed 编辑好的 js.graphml 放到工程目录<br>
2 运行
```
  ruby build_json.rb
  #"1 js"
  #"2 art"
  #"select(1/2):"
  #1
  #会生成 js/js.json 文件
```


## 把数据导入到使用了 mongoid 的 rails 工程

### rails 工程引入 gem

在 Gemfile 中增加引用
```
gem 'knowledge-net-store',
    :git => 'git://github.com/mindpin/knowledge-net-store.git',
    :tag => '0.0.5'
```

然后命令行运行
```
bundle
```

### 把 sample-data-knowledge-points 工程放入 rails 工程的 sample-data

这里推荐使用 gitmodules，下面是具体操作步骤

在 rails 工程根目录运行
```
git submodule add git://github.com/mindpin/sample-data-knowledge-points.git sample-data/knowledge-points
```

### 导入数据

rails 工程根目录运行
```
rails r sample-data/knowledge-points/import_json_to_net.rb 
```

运行后的输出
```
  #"1 js"
  #"2 art"
  #"select(1/2):"
  #选择1会把 js/js.json 的数据导入到 mongoid 数据库
  #选择2会把 art/art.json 的数据导入到 mongoid 数据库
```

### 导入临时测试数据
通过以下两个脚本可以导入测试数据，以下分别说明其作用：

脚本一：将 yed 软件生成的 graphml 文件转换成特定格式的 json 文件
```
ruby sample-data/knowledge-points/1_graphml_to_json.rb <graphml_file_path> <json_file_path>
```

`graphml_file_path`: 要转换的 graphml 文件的路径<br/>
`json_file_path`: 转换结果输出到的 json 文件的路径



脚本二：将特定格式的 json 文件导入到工程的数据库中，创建出 Net 和 Point 对象。
```
rails r sample-data/knowledge-points/2_json_to_net.rb <json_file_path> <net_name>
```

`json_file_path`: 要导入的 json 文件的路径<br/>
`net_name`: 导入后，Net 对象的 name 值
