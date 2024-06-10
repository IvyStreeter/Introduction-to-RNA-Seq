# Some notes while following the DataCamp course

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

library(magrittr)
library(dplyr)

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

# Check out the reference genome annotations
library(annotables)

# View reference annotations
grcm38 

# Extract results table
res_all <- data.frame(de_results) %>%
  rownames_to_column(var = "ensgene") %>%
  left_join(x = res_all,
            y = grcm38[, c("ensgene", "symbol", "description")],
            by = "ensgene")

View(res_all)

# Find significant genes
sig_res <- subset(res_all, padj < 0.05)

sig_res <- sig_res %>%
  arrange(padj)

View(sig_res)

# Visualization of results

# Expression heatmap (normalized counts)
# Subset only DE genes
sig_norm_counts <- normalized_counts[sig_res$ensgene, ]

  # Subset normalized counts to significant genes
  sig_norm_counts_smoc2 <- normalized_counts_smoc2[rownames(smoc2_res_sig), ]


# Color
# display.brewer.all()
heat_colors <- brewer.pal(6, "PiYG")

my_heatmap <- pheatmap(sig_norm_counts,
         color = heat_colors,
         cluster_rows = T,
         show_rownames = F,
         annotation = select(smoc2_metadata, condition),
         scale = "row")

save_pheatmap_png <- function(x, filename, width=1200, height=1000, res = 150) {
  png(filename, width = width, height = height, res = res)
  grid::grid.newpage()
  grid::grid.draw(x$gtable)
  dev.off()
}
save_pheatmap_png(my_heatmap, "my_heatmap.png")

# Volcano plot
library(ggplot2)
res_all <- res_all %>%
  rownames_to_column(var = "gene") %>%
  mutate(threshold = padj < 0.05)

ggplot(res_all) +
  geom_point(aes(x = log2FoldChange, y = -log10(padj),
                 color = threshold)) + 
  xlab("log2 fold change") +
  ylab("-log10 adjusted p-value") +
#  ylim(0, 10) +
  theme(legend.position = "none",
        plot.title = element_text(size = rel(1.5), hjust = 0.5),
        axis.title = element_text(size = rel(1.25)))
ggsave("Volcanoplot.png", width = 7, height = 7)

# Expression plot
top_20 <- data.frame(sig_norm_counts)[1:20,] %>%
  rownames_to_column(var = "ensgene")

top_20 <- gather(top_20, key = "samplename", value = "normalized_counts", 2:8)

top_20 <- inner_join(top_20,
                    rownames_to_column(smoc2_metadata, var = "samplename"),
                    by = "samplename")
ggplot(top_20) + 
  geom_point(aes(x = ensgene, y = normalized_counts, color = condition)) +
  scale_y_log10() + 
  xlab("Genes") + 
  ylab("Normalized Counts") + 
  ggtitle("Top 20 Significant DE Genes") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(plot.title = element_text(hjust = 0.5))
ggsave("ExpressionPlot.png", width = 7, height = 7)


######################
# Code bits
# Check that all of the samples are in the same order in the metadata and count data
all(rownames(all_metadata) %in% colnames(all_rawcounts))

# DESeq object to test for the effect of fibrosis regardless of genotype
dds_all <- DESeqDataSetFromMatrix(countData = all_rawcounts,
                                  colData = all_metadata,
                                  design = ~ genotype + condition)

# DESeq object to test for the effect of genotype on the effect of fibrosis                        
dds_complex <- DESeqDataSetFromMatrix(countData = all_rawcounts,
                                      colData = all_metadata,
                                      design = ~ genotype + condition + genotype:condition)


# Select significant genese with padj < 0.05
smoc2_sig <- subset(res_all, padj < 0.05) %>%
  data.frame() %>%
  rownames_to_column(var = "geneID")

# Extract the top 6 genes with padj values
smoc2_sig %>%
  arrange(padj) %>%
  select(geneID, padj) %>%
  

  head()