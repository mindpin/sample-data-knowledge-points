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
      "name" : stringxxx
    },
    ...
  ],
  "links" : [
    {
      "parent_id" : knowledge_point.id,
      "child_id"  : knowledge_point.id
    },
    ...
  ]
}
```
