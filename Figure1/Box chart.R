setwd("C:/Users/23196/OneDrive/Desktop/属水平多样性")  ##  设置工作目录为C盘mywd文件夹
getwd()  ##  进入工作目录
getwd()
# Libraries
library(tidyverse)
library(hrbrthemes)
library(viridisLite)
library(viridis)
library(ggplot2)
# create a dataset
data <- read.table("Richness.txt", head=T, row.names=1)

# Plot

  ggplot(data, aes(x=group, y=richness, fill=group)) +
  geom_boxplot() +
  scale_fill_viridis(discrete = TRUE, alpha=0.6) +
  geom_jitter(color="black", size=0.9, alpha=0.9) +
  stat_summary(fun.y=mean, geom="point", shape=20, size=1, color="red", fill="red") +
  theme_bw()+
  ggtitle("A boxplot with jitter") +
  xlab("")

# Violin basic
data %>%
  ggplot( aes(x=group, y=shannon, fill=group)) +
  geom_violin() +
  scale_fill_viridis(discrete = TRUE, alpha=0.6, option="D") +
  #geom_jitter(color="black", size=1, alpha=0.9) +
  stat_summary(fun.y=mean, geom="point", shape=20, size=10, color="red", fill="red") +
  theme_bw()+
  ggtitle("Violin chart") +
  xlab("")

#输出保存
ggsave('shannon.png', plot, width = 6, height = 5)

