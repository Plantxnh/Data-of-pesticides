wd<- "D:/OneDrive/生物钟/微生物组/微生物群落相关性网络图/矫正p值的点文件边文件"
setwd(wd)

#加载包
library(igraph)
# 读取节点文件
nodes <- read.csv("cca点文件.csv")
# 读取边文件
links <- read.csv("cca边文件.csv")
# 创建netwok（计算需要，图就不必画了，已经用gephi画好了）
net <- graph_from_data_frame(
  d = links, #边文件创建network，点文件自动识别
  vertices = NULL, #如果vertices没有指定（NULL），默认将数据框d的前两列作为边序列，其他列作为边的属性，节点的名称name按照边序列来确定
  directed = FALSE) #有向图（TRUE）还是无向图（FALSE）,默认TRUE,与gephi统一

#点度中心度，杨老师文章图3b那样的
degree <- degree(net,mode="total") #mode=in点入度；out=点出度；total点度中心度，三者统称绝对点中心度
degreenor <- degree(net,mode="total",normalized = T) #相对点中心度=绝对点中心度/最大度数（可以作为不同网络结构的比较，相对数与绝对数的区别）,比方说教程中讲的三个基因型的中心度要比较的话就得选这个代码


#betweenness中心度，杨老师文章图3c那样的
betweenness <- betweenness(net,normalized = F)
#normalized = T代表相对数，默认值为F为绝对值

#点的特征向量中心度，杨老师文章图3d那样的
evcent <- evcent(net,scale = F)$vector  #scale=F没有归一化，T代表输出数据进行标准化

#点的closeness接近中心度，杨老师文章图3e那样的
closeness <- closeness(net,normalized = F)  #设置normalized = T为相对接近中心度

#输出各个值
write.csv(degree,file="ccadegree.csv") 
write.csv(betweenness,file="ccabetweenness.csv") 
write.csv(evcent,file="ccaevcent.csv") 
write.csv(closeness,file="ccacloseness.csv") 

#备注：以上是所有点的中心度的统计


#其他能够表征网络整体复杂水平的参数（上面中心度是评价一个点的价值或者重要性）：
#网络聚类系数——transitivity，可以衡量网络中关联性如何，值越大代表交互关系越大。说明网络越复杂，越能放在一块儿，聚类。
transitivity(net)

#网络密度——graph.density
#跟网路聚类系数差不多，也是用来形容网络的结构复杂程度。越大，说明网络越复杂，说明网络越能够放在一块。
graph.density(net)
