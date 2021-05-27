#read data
genus <- read.delim('Table_genus.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE)
genus <- t(genus)

library(vegan)
library(picante)

#Richness
richness <- rowSums(genus > 0)

#Shannon
shannon_index <- diversity(genus, index = 'shannon', base = exp(1))

#export
write.csv(richness, 'richness.csv', quote = FALSE)
write.csv(shannon_index, 'shannon_index.csv', quote = FALSE)

