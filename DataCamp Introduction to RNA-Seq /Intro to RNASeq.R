# Questions of RNA-Seq
# Which genes are differentially expressed between sample groups?
# Are there any trends in gene expression over time or across conditions?
# Which groups of genes change similarly over time or across conditions?
# What processes of pathways are important for my condition of interest?

# install.packages("pheatmap")
# Set home directory
home = "~/Desktop/VSCode_Env/GitHub/Introduction to RNA-Seq/DataCamp Introduction to RNA-Seq "
setwd(home)
getwd()

yes# Load library for DESeq2
library(DESeq2)

# Load library for RColorBrewer
library(RColorBrewer)

# Load library for pheatmap
library(pheatmap)

# Load library for tidyverse
library(tidyverse)

# Steps RNA-Seq Experimental Design
## Replicates/Batch effects/confounding
## Biological replicates are more important than technical replicates, at least 3 preferred
smoc2_rawcounts <- read.csv('fibrosis_smoc2_rawcounts.csv', check.names = FALSE)
head(smoc2_rawcounts)
# Explore the first six observations of smoc2_rawcounts
head(smoc2_rawcounts)

# Explore the structure of smoc2_rawcounts
str(smoc2_rawcounts)

library(ggplot2)

# Sum the counts across all samples for a general visualization
col_names = c('smoc2_fibrosis1', 'smoc2_fibrosis4', 'smoc2_normal1', 'smoc2_normal3', 'smoc2_fibrosis3', 'smoc2_normal4', 'smoc2_fibrosis2')

col_names = c(smoc2_fibrosis1, smoc2_fibrosis4, smoc2_normal1, smoc2_normal3, smoc2_fibrosis3, smoc2_normal4, smoc2_fibrosis2)
smoc2_rawcounts

raw_counts <- smoc2_rawcounts %>%
  mutate(sum_counts = rowSums(.[,2:6]))

raw_counts
  
ggplot(raw_counts) + 
  geom_histogram(aes(x=smoc2_normal1), stat = "bin", bins = 200) + 
  xlab("Raw expression counts") + 
  ylab("Number of genes")

# Prepping data to obtain counts
smoc2_rawcounts <- read.csv('fibrosis_smoc2_rawcounts.csv', row.names=1)

# Create genotype vector
genotype <- c("smoc2_oe", "smoc2_oe", "smoc2_oe","smoc2_oe","smoc2_oe","smoc2_oe","smoc2_oe")

# Create condition vector
condition <- c("fibrosis", "fibrosis", "fibrosis", "fibrosis", "normal", "normal", "normal")

# Create data frame
smoc2_metadata <- data.frame(genotype,condition)

# Assign the row names of the data frame
rownames(smoc2_metadata) <- c("smoc2_fibrosis1", "smoc2_fibrosis2", "smoc2_fibrosis3", "smoc2_fibrosis4", "smoc2_normal1", "smoc2_normal3","smoc2_normal4")

# Ensure the data is in the same order
idx <- intersect(colnames(smoc2_rawcounts), rownames(smoc2_metadata))
reordered_metadata <- smoc2_metadata[idx, ]
view(reordered_metadata)

# Checking row names
all(rownames(reordered_metadata) == colnames(smoc2_rawcounts))
colnames(smoc2_rawcounts)
rownames(reordered_metadata)

# Create DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = smoc2_rawcounts,
                              colData = reordered_metadata,
                              design = ~ condition)


# Normalization calculation
dds <- estimateSizeFactors(dds) 

# View calculations
sizeFactors(dds)

# Extraction
normalized_counts <- counts(dds, normalized = T)
View(normalized_counts)

# Compare counts to samples

# Unsupervised clustering analysis: log transform
vsd <- vst(dds, blind=T)

# Extract matrix
vsd_mat <- assay(vsd)

# Compute pairwise correlation
vsd_cor <- cor(vsd_mat)
view(vsd_cor)

# Create a heatmap
library(pheatmap)
pheatmap(vsd_cor, annotation = select(smoc2_metadata, condition))

# Principal component analysis to emphasize variation in the data
png('PCA.png')
plotPCA(vsd, intgroup="condition")
dev.off()

# Differential expression with DESeq2
# raw counts -> binomial model > shrinkin to log2 > exploration

# Run the DESeq2 analysis 
dds_data <- DESeq(dds)

# How well did the data fit the model?
# apply(data, rows/columns, fuction_to_apply)

# Calculating the mean for each gene (each row)
mean_counts <- apply(smoc2_rawcounts[, 1:3], 1, mean)

# Calculating variance for each gene (each row)
variance_counts <- apply(smoc2_rawcounts[, 1:3], 1, var)

# Creating data frame with mean and variance for every gene
df <- data.frame(mean_counts, variance_counts)

# Plot
ggplot(df) + 
  geom_point(aes(x=mean_counts, y=variance_counts)) +
  scale_y_log10() +
  scale_x_log10() +
  xlab("Mean counts per gene") +
  ylab("Variance per gene")
ggsave("MeanVsVariance.png", width = 7, height = 7)

# Seeing variance increase with mean is expected.
# The range of variance is greater for lower mean counts than higher mean counts.
# Dispersion is used to assess variability in expression when modeling counts.
png('dispersion.png')
plotDispEsts((dds_data))
dev.off()

# Poor data looks more cloud-like with decreasing mean
# May indicate sample outliers or contamination

# DESeq2 model - contrasts
de_results <- results(dds_data, 
        contrast = c("condition", "fibrosis",
                     "normal"),
        alpha = 0.05)

# Visualize DE
plotMA(de_results, ylim = c(-8,8))

# Relevel 
dds$condition
dds$condition <- relevel(dds$condition, ref = "fibrosis")
dds <- estimateSizeFactors(dds)
dds <- estimateDispersions(dds)
dds <- nbinomWaldTest(dds)
resultsNames(dds)


# Shrink to get accurate fold levels
de_results <- lfcShrink(dds =dds_data,coef = 2, type = "apeglm")
de_results <- lfcShrink(dds =dds_data,coef = 2, type = "ashr")
png('apeglm.png')
plotMA(de_results, ylim = c(-8,8))
dev.off()

# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("ashr")


mcols(de_results)
summary(de_results)

de_results <- results(dds_data, 
                      contrast = c("condition", "fibrosis",
                                   "normal"),
                      alpha = 0.05)


de_results <- lfcShrink(dds = dds_data,coef = 2, type = "apeglm")
summary(de_results)

install.packages("devtools")
devtools::install_github("stephenturner/annotables")

library(annotables)
