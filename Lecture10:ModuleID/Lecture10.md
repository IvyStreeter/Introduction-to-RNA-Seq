# Lecture notes
## Learning objectives
- Be able to interpret and construct heatmaps
- Understand color choice in R
- Understand how clustering methods are used to identify coordinately expressed genes (a.k.a modules)
- Learn to use the command-line clust program

Spearman may be better to use for clustering than Pearson due to Spearman rank ordering that is less sensitive to the magnitude of change which is important if you don't want highly expressed genes to skew the clustering of the samples. 

Scaling for none emphasis the comparison between genes compared to scaling by row which puts emphasis on comparing samples. Therefore, if you scale by none, you tend to see trends of highly expressed genes vs lowly expressed genes.

Unsupervised clustering
- blind to group assignments
- hierarchial (*what was demonstrated)
- K-means
- SOM
- WGCNA

these assign all genes to clusters, binary (gene can only belong to one module)

Supervised clustering
- group aware
- random forest
- dirichlet-multinomial
- neural network


# Code notes

[Previous Topic](../Lecture09:Differential/Lecture09.md)
[Next Lecture Topic](../Lecture11:Enrichment/Lecture11.md)