library(ggplot2)
data =read.table("pie.txt",header=T)
data
#在标签上显示百分比
lab1 =as.vector(data$class)
lab1 =paste(lab1, "(", round(data$module/sum(data$module)*100, 2), "%)",sep = "")
lab1
#仅有百分比，将数值小于5%的设为‘空’
lab2<-round(data$module/sum(data$module)*100,1)
n<-length(lab2)
n
for(i in 1:n){
  if(as.numeric(lab2[i])<5)
    lab2[i]<-""
  else
    lab2[i]<-paste(lab2[i],"%",sep= "")
}
lab2

#堆叠条形图，设置条形图的边框为白色
p1<-ggplot(data=data,aes(x="",y=data$module,fill=(data$class)))+geom_bar(stat="identity",width=0.4,color="white",linetype=1,size=1)
p1
#添加百分比标签
p2<-p1+geom_text(aes(x=1,label=lab2),position= position_stack(reverse =F,vjust=0.5),size=6)
p2
# coord_polar()将直角坐标系转为极坐标系
p3<-ggplot(data=data,aes(x="",y=data$module,fill=data$class))+ geom_bar(stat="identity",width=1,color="white",linetype=1,size=1)+coord_polar(theta="y") +labs(x="",y="",title="")
p3<-p3+geom_text(aes(x=1.25,label=lab2),position= position_stack(reverse =F,vjust=0.5),size=4)
#vjust的值取 0位于底部，0.5中间， 1 (the default) 在上部
p3
# 更改图表的主题，去掉横纵坐标标题，添加图片标题，将背景改为白色，图列位置（这里仍保持右侧）
p4<-p3+theme_bw() + theme(axis.text=element_blank(),panel.border=element_blank(),axis.ticks=element_blank(), panel.grid=element_blank(),legend.title= element_blank(), legend.position = "right") +scale_fill_discrete(breaks= data$class, labels = lab1)
p4
