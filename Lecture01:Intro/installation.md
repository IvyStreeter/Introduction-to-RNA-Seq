install 

R
RStudio
Sublime Text editor
VSCode
Conda


In RStudio, install bioconductor and update to all
```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.16")
```

[Conda installation instructions](https://protocols.hostmicrobe.org/conda)