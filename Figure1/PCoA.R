wd<- "D:/OneDrive/数据分析byzzy/数据分析zzy第一弹/PCoA"
setwd(wd)

#导入数据。我们可选导入原始的OTU丰度表格文件，也可使用已经计算好的样本距离矩阵文件，同时导入样本分组文件。
#OTU丰度表
otu <- read.delim('Fotu-P.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE)
otu <- data.frame(t(otu))

#样本分组文件
group <- read.delim('Fgroup-P.txt', sep = '\t', stringsAsFactors = FALSE)

#加载vegan包，并进行PCoA分析。
library(vegan)

#排序（基于 OTU 丰度表）
distance <- vegdist(otu, method = 'gower') #这边方法与上面pcoa一样，用的BC，这个代码是vegan包的函数，所以不能计算unifrac距离，因此才会有下文基于现有距离矩阵计算pcoa，也就是说你要做UNifrac距离的pcoa图，得先自己算好距离，再把距离矩阵输入到下面基于距离矩阵的代码
pcoa <- cmdscale(distance, k = (nrow(otu) - 1), eig = TRUE)


#提取坐标轴解释量（前两轴）
pcoa_eig <- (pcoa$eig)[1:2] / sum(pcoa$eig)

#提取样本点坐标（前两轴,我们只做两维的）
sample_site <- data.frame({pcoa$point})[1:2]
sample_site$names <- rownames(sample_site)
names(sample_site)[1:2] <- c('PCoA1', 'PCoA2')
#sample_site$names指的是sample_site这个表格中的names列

#为样本点坐标添加分组信息，根据names来进行识别并匹配两个表格,你输入的group文件中第一列就是names，当然你还可以设置成别的，只要统一就好
sample_site <- merge(sample_site, group,by ='names', all.x = TRUE)

#使用ggplot2进行PCoA排序图绘制。
library(ggplot2)

pcoa_plot <- ggplot(sample_site, aes(PCoA1, PCoA2, group = groups)) +
  theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), legend.key = element_rect(fill = 'transparent')) + #输入绘图的要素，其实pcoa图就是xy点图，prism应该也可以做，但是颜色设置略麻烦，这边pcoa1就是x轴，pcoa2是y轴，genotype作为分组，即点的形状颜色依据。后面的是ggplot2基本主题设置，ggplot2高度可玩，可以百度搜索各种教程，这边想要罗列完是不现实的
  geom_vline(xintercept = 0, color = 'gray', size = 0.3) + #添加pco1=0的线
  geom_hline(yintercept = 0, color = 'gray', size = 0.3) + #添加pco2=0的线
  geom_point(aes(color =groups, shape =groups), size = 3, alpha = 0.8) + #可在这里修改点的透明度、大小
  scale_shape_manual(values = c(17,19,15)) + #可在这里修改点的形状
  scale_color_manual(values = c('grey', 'blue','green')) + #可在这里修改点的颜色，以此对应过去的
  labs(x = paste('PCoA axis1: ', round(100 * pcoa_eig[1], 2), '%'), y = paste('PCoA axis2: ', round(100 * pcoa_eig[2], 2), '%')) 
 
#查看图
pcoa_plot

#输出保存
ggsave('PCoA.png', pcoa_plot, width = 6, height = 5)

#有时候pcoa坐标的数据公司会给的，比如demo中的“PCoA.csv”,那可以直接用excel以这边sample_site为模版创建你自己的表格，然后直接用ggplot2画图，前面计算过程直接跳过

adonis_resul

#以上是作图的内容，那有时候还要进行显著性检验是否显著分离，对应于pcoa是用adonis方法，杨老师isme文献中用的是nmds，其实跟pcoa差不多，它对应的检验方法是anosim，下面都做一下展示

#adonis
#如果最开始输入的是otu表格的话
adonis_result_otu <- adonis(otu~groups, group, permutations = 999, distance = 'gower')  #这边方法与上面pcoa一样，用的BC
#查看数值
adonis_result_otu #下面显示的R2就是分散程度，pr就是p值

#如果最开始输入距离的话
adonis_result_dis <- adonis(dis~genotype, group, permutations = 999) #意思是根据 group文件中genotype 这一列作为分组信息进行 PERMANOVA 分析，随机置换检验 999 次
adonis_result_dis

#anosim
#如果最开始输入的是otu表格的话
adonis_result_otu <- anosim(otu, group$groups, permutations = 999, distance = 'gower')  #这边方法与上面pcoa一样，用的BC
#查看数值
adonis_result_otu #下面显示的R就是分散程度，Significance就是p值

#如果最开始输入距离矩阵的话
adonis_result_dis <- anosim(dis,group$genotype,permutations = 999) #意思是根据 group文件中genotype 这一列作为分组信息进行分析，随机置换检验 999 次
adonis_result_dis