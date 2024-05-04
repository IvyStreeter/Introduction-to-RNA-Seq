# Introduction-to-RNA-Seq
## Objective
This is the basics to RNA-Seq. I am utilizing multiple resources to go through the basics and hope to analyze data from papers and datasets in the future.

# DIY transcriptomics Overview
This course is by Daniel Beiting from UPenn. All [lecture material](https://diytranscriptomics.com/) and resources linked on his website. Some notes provided may stem from personal professional experience.

## Course objective
- To analyze your own bulk RNA-Seq or scRNA-Seq data
- To make a lightweight and reusable pipeline for different datas and potentially other types of assays such as ATAC-Seq
- To learn best practices for working in R/bioconductor
- To become a better data scientist
- To learn basic building blocks to create publication quality graphics
- To learn to report the owrk in a transparent and reproducible fashion

## The approach
- Open-source material (free!)
- Modular learning
- Using your personal laptop as the workstation
- RNA-Seq focused, but applicable to other genomic sequencing data
- Multiple 'on-ramps' to wrangling data into your pipeline or analysis
- Virtual lectures that are accessible at your own pace and hands-on labs to develop skills

## General steps of analysis
1. Data import
2. Data wrangling
3. Data exploration
4. Accessing public data
5. Feature Selection
6. Finding modules
7. Funcitonal enrichment analysis
8. Dynamic Reports

# Lecture 1. Introduction to RNA-Seq technology and data
## Learning objectives
- Get familiar with terminology of RNASeq/HTS (paired-end, single-end, cluster density, FastQ, index, etc).
- Understand Illumina's "Sequencing by synthesis" (SBS) technology.
- Set priorities when planning a sequencing experiment.
- Understand the basics of library prep for HTS.

## Reading Material
### Here are some basics on [NGS technology and file formats](https://learn.gencore.bio.nyu.edu/ngs-file-formats/)
![File format flow chart](./Relative%20links/FileFormatFlowChart.png)

**Definitions:**
**read:** a single sequence produced from a sequencer
**library:** a collection of DNA fragments that have been prepared for sequencing. This generally refers to individual samples
**flowcell:** a chip on which DNA is loaded and provided to the sequencer
**lane:** one portion of a flow cell. Usually used for technical replicates or different samples
**run:** an entire sequencing reaction from start to finish
**NGS:** Next-generation sequencing refers to second generation sequencing where fragments of DNA are sequenced in parallel and reconstructed for the final sequence information

#### General Sequencing steps in NGS:
1. Sample collection and preparation
2. Amplification
3. BaseCalling

####**1. Sample Collection and Preparation**
DNA from your sample of interested is isolated and purified. This DNA is then sheared to a certain size, the product of interest is amplified and processed, then sequencing adaptors are ligated (small fragments of DNA that are used to bind the molecules of interest on to the flowcell).

####**2. Amplification**
The sample can be amplified in either single-end or paired-end sequencing. 

[Here is Ilumina's table on the difference between these sequencing choices](https://www.illumina.com/science/technology/next-generation-sequencing/plan-experiments/paired-end-vs-single-read.html)

**Paired-end sequencing:**
**Simple paired-end libraries:** Simple workflow allows generation of unique ranges of insert sizes
**Efficient sample use:** Requires the same amount of DNA as single-read genomic DNA or cDNA sequencing
**Broad range of applications:** Does not require methylation of DNA or restriction digestion; can be used for bisulfite sequencing
**Simple data analysis:** Enables high-quality sequence assemblies with short-insert libraries. A simple modification to the standard single-read library preparation process facilitates reading both the forward and reverse template strands of each cluster during one paired-end read. Both reads contain long-range positional information, allowing for highly precise alignment of reads

**Single-read sequencing:**
**Cost-effective uses:** This solution delivers large volumes of high-quality data, rapidly and economically
**Specific applications:** Single-read sequencing can be a good choice for certain methods such as small RNA-Seq or chromatin immunoprecipitation sequencing (ChIP-Seq)

Sequencing kits are getting cheaper by the decade, the generall consensus seems to always go with paired-end sequencing with genomic assays if in the budget due to higher quality data.

