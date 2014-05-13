sample-data-knowledge-points
============================

用于学科知识数据库（KnowledgeCamp）演示需求的示例知识点结构数据，以及示例知识点内容信息。

## 知识点网络结构

json 数据结构如下
```javascript
{
  "knowledge_points" : [
    {
      "id" : randstr,
      "name" : stringxxx,
      "desc" : stringxxx
    },
    ...
  ],
  "links" : [
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
