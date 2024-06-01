Running fastqc on fastq files

```
conda activate rnaseq
fastqc *.gz -t 16
```

fastqc html files are attached

Human reference genome release information
Index of /pub/release-112/fasta/homo_sapiens/cdna

kalliso mapping:

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
#Troublshooting multiqc

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

Appears to be a python version issue. Running 3.6.13 and need to update >3.7. If enviornment has conflicts, can always create a new one.
```
conda update python
```



[Previous Topic](../Lecture02:SettingUp/Lecture2.md)
[Next Lecture Topic](../Lecture04:RNAseqCount/Lecture04.md)
