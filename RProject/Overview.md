# Step 0 - alignment
- Run FastQC to check data quality
- Create an index with Kallisto
- Align reads with Kallisto to obtain counts

# Step 1 - counts
- Read in study design
- get annotations using organism-specific package
- import Kallisto transcript counts into R using Tximport

# Step 2 - data wrangle
- Examine the data
- Generate summary stats
- Create plots to view data and evaluate transformations
- Generate DGElist from counts and plot
- Determine cutoffs, filter, and plot data
- Normalize data and plot

# Step 3 - multivariate
- Identify variables of interest in the study design
- prep data
- perform hierarchial clustering
- PCA
- visualize PCR
- Create small multiples charts
- modify and plot tables of interest
- modify and plot data of interest

# Step 4 - public data: working with ARCHS4
- load ARCHS4
- query ARCHS4
- extract, filter, normalize
- extract metadata
- PCA
- small multiples plot
- visualizations 

# Step 5 - differential genes
- set up design matrix
- model mean-variance trend and fit linear model to data
- contrast matrix
- extract linear model fit
- toptable to view DEGs
- Volcano plot
- Pull DEG and make Venns
- retrieve expression data from DEGs
- create interactive tables to display DEG

# Step 6 - Modules
- color pallettes 
- data
- cluster DEGs
- produce static heatmaps
- produce interactive heatmaps
- modules of co-regulated genes
- export modules for downstream analysis

# Step 7 - Functional enrichment
- GO enrichment with gProfiler2
- GSEA with clusterprofiler
- competitive GSEA with CAMEREA
- Single sample GSEA with GSVA

