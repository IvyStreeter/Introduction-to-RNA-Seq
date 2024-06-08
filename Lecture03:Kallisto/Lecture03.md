# Lecture notes
Burrows-Wheeler Transform (BWT)
[Wiki page](https://en.wikipedia.org/wiki/Burrows%E2%80%93Wheeler_transform)

[Youtube video explaining BWT](https://www.youtube.com/watch?v=4n7NPk5lwbI)

Originally designed for compression in 1994 by Michael Burrows and David Wheeler. The BWT is a reversible permutation used for characters of a string.

The permutation goes like this:
1. Make a rotation
2. Sort them alphabetically starting with $
3. Take the last column and join them

Characters of the BWT are sorted by their right-context. Upon observations it appears that it brings like characters together and often vowels are the final character. This final column with runs of the same character is why this BWT is more compressible.

The suffix array is the same as the Burrows-Wheeler matrix without anything after the $. This is because the expected order after the $ is known and therefore, it is unnecessary to store.

So how do you get from the BWT(T) back to T? Through a process called LF mapping. To LF map. For each character in a BWT(T), annotate them with a ranking (T-ranking) of 0. If a letter repeats in a BWT(T), rank them dependent on the when they appeared in the first BWT(T). 

If you look down F (first) or L (last) columns of a BWM, the order of the ranking repeats the same way. This is due to the sorted list of rotations. The sort makes locating the correct row easy as long as the structure is known. This is how LF mapping works and how you can reconstruct T.

## Different aligners have different methods

Methods:
- Brute force: match a nucleotide and extend from each position. This is computationally slow.
- Seed and extend: take a stretch of nucleotides of size k and extend. Less extensions, less matches than in the first method. This is faster. An example is RSubread aligner. Take a read, take a subread, align to the reference and gain a vote if a match is found. The most votes becomes the alignment.
- Psuedoaligners: This addresses the idea of length and exact matches. Extending is where computation slows down. Example Sailfish that removes approximate alignment and only works with exact alignments of short k-mers.
- Removing alignment altogether: Kallisto
[Youtube video about psuedoalignment](https://www.youtube.com/watch?v=94wphB3GKBM)
<br>
[A video regaarding aligners](https://youtu.be/b4tVokh6Law)

advantages:
- faster
- bootstrapping -> technical replicates -> uncertainty estimates
- laptop workstation

disadvantges:
- cannot look at SNPs
- cannot look at splice junctions


# Code notes
Running fastqc on fastq files

```
conda activate rnaseq
fastqc *.gz -t 16
```

fastqc html files are attached

Human reference genome release information
Index of /pub/release-112/fasta/homo_sapiens/cdna

kallisto mapping:

```
kallisto quant \
-i Human112cDNA.index \
-o SRR8668769_001-test \
-t 8 \
--single -l 250 -s 30 \
SRR8668769.fastq-001.gz 
```
you can push the details into a log
```
kallisto quant \
-i Human112cDNA.index \
-o SRR8668769_001-test \
-t 8 \
--single -l 250 -s 30 \
SRR8668769.fastq-001.gz \
&> test.log 
```

run the readmapping.sh script
```
sh readmapping.sh
```

ran into error with multiqc. 
# Troublshooting multiqc

```
$ multiqc -d .

Traceback (most recent call last):
  File "/Users/ivy/miniconda/envs/rnaseq/bin/multiqc", line 4, in <module>
    __import__('pkg_resources').run_script('multiqc==1.0.dev0', 'multiqc')
  File "/Users/ivy/miniconda/envs/rnaseq/lib/python3.6/site-packages/pkg_resources/__init__.py", line 3242, in <module>
    @_call_aside
  File "/Users/ivy/miniconda/envs/rnaseq/lib/python3.6/site-packages/pkg_resources/__init__.py", line 3226, in _call_aside
    f(*args, **kwargs)
  File "/Users/ivy/miniconda/envs/rnaseq/lib/python3.6/site-packages/pkg_resources/__init__.py", line 3255, in _initialize_master_working_set
    working_set = WorkingSet._build_master()
  File "/Users/ivy/miniconda/envs/rnaseq/lib/python3.6/site-packages/pkg_resources/__init__.py", line 568, in _build_master
    ws.require(__requires__)
  File "/Users/ivy/miniconda/envs/rnaseq/lib/python3.6/site-packages/pkg_resources/__init__.py", line 886, in require
    needed = self.resolve(parse_requirements(requirements))
  File "/Users/ivy/miniconda/envs/rnaseq/lib/python3.6/site-packages/pkg_resources/__init__.py", line 772, in resolve
    raise DistributionNotFound(req, requirers)
pkg_resources.DistributionNotFound: The 'importlib-metadata' distribution was not found and is required by click
```

Appears to be related to setuptools as described in this [thread](https://github.com/pypa/twine/issues/724#issuecomment-753503728). I also upgraded pip
```
pip install -U setuptools
pip install --upgrade setuptools pip
```

Issue not resolved, downloaded multiqc via [condaforge](https://stackoverflow.com/questions/74146947/error-installing-multiqc-from-conda-importlib-metadata)
```
conda install -c bioconda -c conda-forge multiqc
```

Appears to be a python version issue as it could not import a [function](https://stackoverflow.com/questions/52889746/cant-import-annotations-from-future) . Running 3.6.13 and need to update >3.7. If enviornment has conflicts, can always create a new one.
```
conda update python
```
After python was upgraded to the latest version 3.11.9, multiqc was able to work

# R
load a new project
set repos to all
the lecture focused on loading packages

[Previous Topic](../Lecture02:SettingUp/Lecture2.md)
[Next Lecture Topic](../Lecture04:RNAseqCount/Lecture04.md)
