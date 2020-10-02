# ---------------------------------------------------------------
# Author.... Merritt Burch
# Contact... mbb262@cornell.edu
# Date...... 2020-10-01
#
# Description
#   - Exploring maize TE annotations from Stitzer 2019
# ---------------------------------------------------------------

# ------------
# Setup
# ------------

# load packages
library(dplyr)
library(ggplot2)
library(patchwork)
library(data.table)

# Load data
te1 <- data.table::fread("git_projects/te_regulation/data/stitzer_figshare/B73.LTRAGE.allDescriptors.2019-01-31.txt")
closest_gene <- data.table::fread("git_projects/te_regulation/data/stitzer_figshare/B73_closest_gene.2019-10-21.txt")

# Intersect-Join te info with gene information
data.table::setkey(te1, TEID)
data.table::setkey(closest_gene, TEID)
closest_te1 <- te1[closest_gene, nomatch = 0]


# -------------
# Analysis
#--------------

# Look at relationship between B73 mature leaf expression and
#     all TEs genome wide + their distance away from genes
model_dist_sup <- lm(log10(gene_Mature_Leaf_8+1) ~ closest+ sup, data = te1)
summary(model_dist_sup)

# Plot this model
ggplot(te1, aes(x = closest, y = log10(gene_Mature_Leaf_8+1), color = sup))+
  geom_point()+
  geom_smooth(method = "lm")  +
  ylab("log10(B73 Mature Leaf Expression)") +
  ggtitle("B73 Leaf Expression ~ Distance from gene + all TE superfamilies")


# See how number of TE families changes the further you get away from genes
# WARNING: THIS IS UGLY CODE

# Density plots of number of TE familes away from genes
temp0 <- te1 %>% select(TEID, fam, sup, closest) %>% filter(closest <= 500000, closest >= 1) %>% group_by(fam) %>% mutate(count = n()) %>% distinct(fam, .keep_all = TRUE)
temp1 <- te1 %>% select(TEID, fam, sup, closest) %>% filter(closest <= 100000, closest >= 1) %>% group_by(fam) %>% mutate(count = n()) %>% distinct(fam, .keep_all = TRUE)
temp2 <- te1 %>% select(TEID, fam, sup, closest) %>% filter(closest <= 50000, closest >= 1) %>% group_by(fam) %>% mutate(count = n()) %>% distinct(fam, .keep_all = TRUE)
temp3 <- te1 %>% select(TEID, fam, sup, closest) %>% filter(closest <= 30000, closest >= 1) %>% group_by(fam) %>% mutate(count = n()) %>% distinct(fam, .keep_all = TRUE)
temp4 <- te1 %>% select(TEID, fam, sup, closest) %>% filter(closest <= 20000, closest >= 1) %>% group_by(fam) %>% mutate(count = n()) %>% distinct(fam, .keep_all = TRUE)
temp5 <- te1 %>% select(TEID, fam, sup, closest) %>% filter(closest <= 10000, closest >= 1) %>% group_by(fam) %>% mutate(count = n()) %>% distinct(fam, .keep_all = TRUE)
temp6 <- te1 %>% select(TEID, fam, sup, closest) %>% filter(closest <= 3000, closest >= 1) %>% group_by(fam) %>% mutate(count = n()) %>% distinct(fam, .keep_all = TRUE)

# add names
temp0$distance <- rep(500000, nrow(temp0))
temp1$distance <- rep(100000, nrow(temp1))
temp2$distance <- rep(50000, nrow(temp2))
temp3$distance <- rep(30000, nrow(temp3))
temp4$distance <- rep(20000, nrow(temp4))
temp5$distance <- rep(10000, nrow(temp5))
temp6$distance <- rep(3000, nrow(temp6))

# Rbind all together and filter
together <- rbind(temp0, temp1, temp2, temp3, temp4, temp5, temp6) %>% filter(count >20)

# Plot across all superfamilies
ggplot(together, aes(x=as.factor(distance), y=log10(count))) +
  geom_boxplot() +
  xlab("Distance away from closest gene")

# Color by superfamily
ggplot(together, aes(x=as.factor(distance), y=log10(count), fill = sup)) +
  geom_boxplot() +
  xlab("Distance away from closest gene")
