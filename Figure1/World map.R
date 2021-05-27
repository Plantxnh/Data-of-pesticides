mydata<-read.table("data.csv",header=TRUE,sep=",")  #导入自己的名字为“demo.csv”文件
visit.x<-mydata$longitude
visit.y<-mydata$latitude #数据准备
library(ggplot2)
library(ggmap)
library(sp)
library(maptools)
library(maps)
library(mapdata)
mp<-NULL #定义一个空的地图
mapworld<-borders("china",colour = "gray",fill="white") #绘制基本地图
mp<-ggplot()+mapworld+ylim(-60,90)
mp#利用ggplot呈现，同时地图纵坐标范围从-60到90
mp2<-mp+geom_point(aes(x=visit.x,y=visit.y,size=mydata$number),color="#8BB6D6",alpha=0.9)+scale_size(range=c(3,10))
#绘制带点的地图，geom_point是在地图上绘制点，x轴为经度信息，y轴为纬度信息，size是将点的大小按照收集的个数确定，color为暗桔色，scale_size是将点变大一些
mp2
mp3<-mp2+theme(legend.position = "none") #将图例去掉
mp3#将地图呈现出来

#####中国地图
data<-read.table("China.csv",header=TRUE,sep=",")
visit.x<-mydata$longitude
visit.y<-mydata$latitude #数据准备
mp<-NULL #定义一个空的地图
mapworld<-borders("china",colour = "gray50",fill="white")
mapworld
mp<-ggplot()+mapworld#利用ggplot呈现，同时地图纵坐标范围从-60到90
mp
mp2<-mp+geom_point(aes(x=visit.x,y=visit.y,size=data$number),color="#8BB6D6",alpha=0.9)+scale_size(range=c(5,5))
#绘制带点的地图，geom_point是在地图上绘制点，x轴为经度信息，y轴为纬度信息，size是将点的大小按照收集的个数确定，color为暗桔色，scale_size是将点变大一些
mp2
mp3<-mp2+theme(legend.position = "none") #将图例去掉
mp3