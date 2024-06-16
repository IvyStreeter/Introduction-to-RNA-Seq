# Lecture notes
## Learning objectives
- Learn about fasterq_dump
- Learn about HDF5 file format
- Explore ARCHS4 database programatically
- Start and finish the Step 4 script

GEO>EMBL-EBI>SRA

Where do we get data? 
- NCBI
- EMBL-EBI
- GEO
- SRA
- ENA
- TCGA
- GTEx
- gnomAD
- CRISPRme
- ENCODE
- All of Us

What do we do with data?
1st thing to consider is the data format. Different file type require different workflows.

2 aligners that are SRA aware are hisat2 and bowtie2, you do not need to download these files. This is possible because of NCBI's NGS toolkit.

SRA tools is a command line tool called fastq-dump/fasterq-dump to download data

though you will not get the metadata, and often the problem
grabseqs

lightweight data is a challenge -> GTEx is a community based resource to link genotype with tissue expression


# Code notes

[Previous Topic](../Lecture07:PublicData/Lecture07.md)
[Next Lecture Topic](../Lecture09:Differential/Lecture09.md)