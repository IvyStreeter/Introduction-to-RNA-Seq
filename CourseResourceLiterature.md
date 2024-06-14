Protocols website: protocols/SOPs for RNAseq library preparation, as well as bioinformatics workflows.
- https://protocols.hostmicrobe.org/

# Precourse Lecture
File formats produced by sequencing
- https://learn.gencore.bio.nyu.edu/ngs-file-formats/

RNA-seqlopedia - Created by the Univ. of Orgeon, this is a great resource for understanding the entire RNAseq workflow.
- http://rnaseq.uoregon.edu/

The year of sequencing 
- https://www.nature.com/articles/nmeth1154

The transcriptional landscape of yeast genome defined by RNA Sequencing 
- https://pubmed.ncbi.nlm.nih.gov/18451266/


Solid phase DNA amplification: a simple Monte Carlo Lattice model
- https://pubmed.ncbi.nlm.nih.gov/14507676/

Solid Phase DNA Amplification: A Brownian Dynamics Study of Crowding Effects
- https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1366531/

RNA-seq differential expression studies: more sequence or more replication?
- https://pubmed.ncbi.nlm.nih.gov/24319002/#:~:text=Our%20analysis%20showed%20that%20sequencing,design%20of%20RNA%2Dseq%20studies.

Chapter Sixteen - Considerations for RNA-seq Analysis of Circadian Rhythms
Sequencing depth, sequencing replicates for DE, how many replicates
- https://www.sciencedirect.com/science/article/abs/pii/S0076687914000214

The impact of read length on quantification of differentially expressed genes and splice junction detection
- https://genomebiology.biomedcentral.com/articles/10.1186/s13059-015-0697-y

# Lecture 1
Mistaken Identifiers: Gene name errors can be introduced inadvertently when using Excel in bioinformatics
- https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-5-80

Gene name errors are widespread in the scientific literature
- https://genomebiology.biomedcentral.com/articles/10.1186/s13059-016-1044-7

Orchestrating high-throughput genomic analysis with Bioconductor
- https://www.nature.com/articles/nmeth.3252


# Lecture 2
Kallisto
- https://pachterlab.github.io/kallisto/about

2016 Nature Biotech paper from Lior Pachter’s lab describing Kallisto
- http://diytranscriptomics.github.io/Reading/files/Kallisto.pdf

2017 Nature Methods paper from Lior Pachter’s lab describing Sleuth
- http://diytranscriptomics.github.io/Reading/files/sleuth.pdf

Lior Pachter’s lab post on Kallisto
- https://liorpachter.wordpress.com/2015/05/10/near-optimal-rna-seq-quantification-with-kallisto/

lab post on pseudoalignments - helps understand how Kallisto maps reads to transcripts
- http://tinyheero.github.io/2015/09/02/pseudoalignments-kallisto.html

Did you notice that Kallisto is using ‘Expectation Maximization (EM)’ during the alignment? You can read more about what this is here
- http://diytranscriptomics.github.io/Reading/files/EM.pdf

Kallisto discussions/questions
- https://groups.google.com/forum/#!forum/kallisto-sleuth-users

Kallisto announcements are available on Google groups
- https://groups.google.com/forum/#!forum/kallisto-sleuth-announcements

## General info about ultra lightweight methods for transcript quantification
2014 Nature Biotech paper - describes Sailfish, which implimented the first lightweight method for quantifying transcript expression.
- http://diytranscriptomics.github.io/Reading/files/Sailfish.pdf

Not quite alignments - Rob Patro, the first author of the Sailfish paper, wrote a nice lab post comparing and contrasting alignment-free methods used by Sailfish, Salmon and Kallisto.
- http://robpatro.com/lab/?p=248

2018 Nature Methods paper describing Salmon - A lightweight aligment tool from Rob Patro and Carl Kinsford. Check out the website too.
- https://www.nature.com/articles/nmeth.4197
- https://combine-lab.github.io/salmon/

2011 Nature Biotechnology - Great primer to better understand what de Bruijn graph is.
- http://diytranscriptomics.github.io/Reading/files/deBruijn.pdf

Greg Grant’s recent paper comparing different aligners. This should be a helpful guide in choosing alignment software outside of what we used in class.
- http://diytranscriptomics.github.io/Reading/files/gregGrant_aligners_natMeth.pdf

## Videos
RNA-Seq methods and algorithms
- https://youtu.be/b4tVokh6Law

Liar CSHL talk
- https://youtu.be/5NiFibnbE8o

# Lecture 3
Fast and accurate short read alignment with Burrows-Wheeler transform
- https://pubmed.ncbi.nlm.nih.gov/19451168/

Ultrafast and memory-efficient alignment of short DNA sequences to the human genome
- https://genomebiology.biomedcentral.com/articles/10.1186/gb-2009-10-3-r25

Seed and extend
- https://blog.sbgenomics.com/short-read-alignment-seeding/

The R package Rsubread is easier, faster, cheaper and better for alignment and quantification of RNA sequencing reads 
- https://academic.oup.com/nar/article/47/8/e47/5345150

Sailfish enables alignment-free isoform quantification from RNA-seq reads using lightweight algorithms
- https://pubmed.ncbi.nlm.nih.gov/24752080/

Near-optimal probabilistic RNA-seq quantification
- https://www.nature.com/articles/nbt.3519

# Lecture 4
Original paper describing Sleuth
Differential analysis of RNA-seq incorporating quantification uncertainty. Nature Methods, June, 2017
- http://diytranscriptomics.github.io/Reading/files/sleuth.pdf

Lior Pachter’s lab post on Sleuth
- https://liorpachter.wordpress.com/2015/08/17/a-sleuth-for-rna-seq/

vignette for the Tximport package - the R package we’ll use to read the Kallisto mapping results into R.
- https://bioconductor.org/packages/devel/bioc/vignettes/tximport/inst/doc/tximport.html

Differential analyses for RNA-seq: transcript-level estimates improve gene-level inferences* F1000Research, Dec 2015. This paper describes the Tximport package and its application for handling transcript-level expression measurments from lightweight aligners (Salmon, Sailfish, Kallisto)
- http://f1000research.com/articles/4-1521/v2

# Lecture 5
original TMM normalization manuscript.
- https://genomebiology.biomedcentral.com/articles/10.1186/gb-2010-11-3-r25

Tidy Data - Hadley Wickham (author of Tidyverse packages and Chief Scientist at RStudio) describes the philosophy of tidy data in this paper.
- http://vita.had.co.nz/papers/tidy-data.pdf

Grammar of graphics - Another paper by Hadley Wickham. This one explains the rationale behind ggplot2.
- http://diytranscriptomics.github.io/Reading/files/layered-grammar.pdf

ggplot2 cheatsheet – a very helpful guide as we continue to use ggplot2 for all of our plotting needs.
- http://diytranscriptomics.github.io/Reading/files/ggplot2-cheatsheet.pdf

catalog of R graphs - Take a look at some of the various ways to graph your data and the underlying R code in this
- http://shiny.stat.ubc.ca/r-graph-catalog/

R Graphics Cookbook - If you end up using R to make a lot of graphs, you will find the to be an important reference. It’s available free to UPenn folks as an Ebook.

# Lecture 6
Ten quick tips for effective dimensionality reduction - a absolute must-read for understanding data exploration methods.
- https://doi.org/10.1371/journal.pcbi.1006907

lab post describing T-SNE - I mentioned various unsupervised linear methods for dimensional reduction of your data (PCA, MDS). T-SNE and UMAP are non-linear unsupervised methods that have become popular for representing single-cell RNAseq data and flow cytometry data.
- http://distill.pub/2016/misread-tsne/

Original T-SNE paper.
- http://diytranscriptomics.github.io/Reading/files/TSNE.pdf

UMAP paper - A new algorithm, called uniform manifold approximation and projection (UMAP) has been recently published and is gaining popularity in single cell RNAseq and flow cytometry analysis. UMAP is proposed to preserve as much of the local and more of the global data structure than t-SNE, with a shorter run time.
- https://www.nature.com/articles/nbt.4314

Ten quick tips for effective dimensionality reduction
- https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1006907

Comparison of the transcriptional landscapes between human and mouse tissues
- https://pubmed.ncbi.nlm.nih.gov/25413365/

A reanalysis of mouse ENCODE comparative gene expression data
- https://pubmed.ncbi.nlm.nih.gov/26236466/

Notice of Retraction. Aboumatar et al. Effect of a Program Combining Transitional Care and Long-term Self-management Support on Outcomes of Hospitalized Patients With Chronic Obstructive Pulmonary Disease: A Randomized Clinical Trial. JAMA. 2018;320(22):2335-2343.
- https://jamanetwork.com/journals/jama/fullarticle/2752474

PCA video
- https://youtu.be/FgakZw6K1QQ

# Lecture 7
ReCount: A multi-experiment resource of analysis-ready RNA-seq gene count datasets
- https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-12-449

Reproducible RNA-seq analysis using recount2
- https://www.nature.com/articles/nbt.3838

Massive mining of publicly available RNA-seq data from human and mouse
- https://www.nature.com/articles/s41467-018-03751-6

Digital expression explorer 2: a repository of uniformly processed RNA sequencing data
- https://pubmed.ncbi.nlm.nih.gov/30942868/

Activity of Uncleaved Caspase-8 Controls Anti-bacterial Immune Defense and TLR-Induced Cytokine Production Independent of Cell Death
- https://pubmed.ncbi.nlm.nih.gov/27737018/

