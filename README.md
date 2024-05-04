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

##### **1. Sample Collection and Preparation**
DNA from your sample of interested is isolated and purified. This DNA is then sheared to a certain size, the product of interest is amplified and processed, then sequencing adaptors are ligated (small fragments of DNA that are used to bind the molecules of interest on to the flowcell).

##### **2. Amplification**
The sample can be amplified in either single-end or paired-end sequencing. 

[Here is Ilumina's table on the difference between these sequencing choices](https://www.illumina.com/science/technology/next-generation-sequencing/plan-experiments/paired-end-vs-single-read.html)

<br>  **Paired-end sequencing:** <br>  
**Simple paired-end libraries:** Simple workflow allows generation of unique ranges of insert sizes
**Efficient sample use:** Requires the same amount of DNA as single-read genomic DNA or cDNA sequencing
**Broad range of applications:** Does not require methylation of DNA or restriction digestion; can be used for bisulfite sequencing
**Simple data analysis:** Enables high-quality sequence assemblies with short-insert libraries. A simple modification to the standard single-read library preparation process facilitates reading both the forward and reverse template strands of each cluster during one paired-end read. Both reads contain long-range positional information, allowing for highly precise alignment of reads

<br>  **Single-read sequencing:**  <br>  

**Cost-effective uses:** This solution delivers large volumes of high-quality data, rapidly and economically
**Specific applications:** Single-read sequencing can be a good choice for certain methods such as small RNA-Seq or chromatin immunoprecipitation sequencing (ChIP-Seq)

<br>  
Sequencing kits are getting cheaper by the decade, the general consensus seems to always go with paired-end sequencing with genomic assays if in the budget due to higher quality data. <br>  
  
##### **3. Sequencing**
[Illumina Sequencing by Synthesis (SBS) Workflow](https://www.youtube.com/watch?v=fCd6B5HRaZ8)
  
Sometimes you will hear people state that a sample occupies 2 lanes, this means that for an 8 lane flowcell, the remaining 6 will be utilized by other samples submitted by otheres. This is a way to drive down sequencing costs. This may be older terminology as I no longer hear lanes being referred. This may be due to sequencing studies needing need high read counts and the [capacity of each sequencing lane](https://online.stat.psu.edu/stat555/node/13/#:~:text=The%20basic%20sequencing%20unit%20is,the%20amount%20of%20sequencing%20done.)
  
>The basic sequencing unit is a "lane" which essentially holds one sequencing sample.  A set of lanes which are processed together is often called a "plate". A single RNA sample may be split across multiple lanes to increase the amount of sequencing done.  This is uncommon in current RNA-seq studies, because each lane can now sequence 100's of millions of RNA fragments, which is more than sufficient for RNA-seq, but it may be done in studies that need very high read counts.  
>...
> **From Lanes to Samples**
>Our units of analysis are features and RNA samples.  In many studies, sequencing lanes and samples are not the same.  Mapping identifies the features.  We also need to summarize by sample. In some studies, the RNA samples are split across several lanes.  It turns out that the error structure is preserved if we simply sum up the reads from each sample to obtain the total reads for each feature in the sample. In some studies, the RNA samples are barcoded and multiplexed so that several samples are sequenced together.  As the reads are mapped to the reference, the bar codes need to be read so that they can also be assigned to samples.


[Here is a forum link discussingg lanes](https://www.biostars.org/p/48906/)
[Here is a seconday link discussing lanes](https://bioinformatics.stackexchange.com/questions/4564/relationship-between-sequencing-lane-and-ngs-dataset)
  <br>
Other context regarding lane
A flow cell contains 8 lanes
Each lane contains 2 columns
Each column contains up to 50 tiles
Each tile is imaged 4 times per cycle, one image per base
Each image is 2.5-3.0 Mb, and ~115,000 images are produced per 36 cycles

#### File formats
##### **FastA**
- This is the most basic format for reporting a sequence and is accepted by all sequence analysis programs.
- Contains 2 lines:
1. Sequence header which always starts with a '>'. This is followed by a sequence identifier, whitespace, then a sequence description
2. The sequence
  <br>  
**Softwares that use FastA** <br>  
- Reference genome
- DB query tools like BLAST and multiple-sequence alignment algorithms

<br>  **File generation**  <br>  
- Some NGS sequencers report in FastA
- Sanger Sequencers
- Most sequence databases store in FastA and is made availalble for downnload in this format
- Can be generated from FastQ files
![This is what FastA looks like](./Relative%20links/fastaPic.png)

<br>  
##### **FastQ**  <br>  
The most widely used sequence format in sequence analysis and is generally delivered by sequencers in this format. Many analysis tools require this format because it contains more information than FastA.


![This is an image of what FastQ looks like](./Relative%20links/fastqPic.png)
