install:

- R
- RStudio
- Sublime Text editor
- VSCode
- Conda


In RStudio, install bioconductor and update all
```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.16")
```

[Conda installation instructions](https://protocols.hostmicrobe.org/conda)
<br>  

install:
- kallisto
- kb-python
- fastqc
- multiqc
- sourmash
- centrifuge

[Previous Topic](Lecture01.md.md)
[Next Lecture Topic](../Lecture02:SettingUp/Lecture02.md)