# Lecture notes
## Learning objectives
- Carry out Gene Ontology (GO) enrichment analysis using modules identified in the previous script
- Carry out a Gene Set Enrichment Analysis (GSEA) using our full dataset
- Understand the differences between GO and GSEA
- Understand the MSigDB resource and how to access signature collections

One of the goals of RMA-Seq is to determine the function of the differential genes. Two main approaches to functional enrichment analysis are Gene Ontology (GO) analysis or Gene Set Enrichment Analysis (GSEA). 

### Gene Ontology (GO)
- required arbitrary selection of genes
- does not require any data
- species specific
- user does not control vocabulary

### Gene Set Enrichment Analysis (GSEA)
- no need to pre-select genes
- requires both identifiers and data
- not species specific
- user can control vocabulary

Some differ in statistical methods, but often not clear
ORA approach (over enrichment analysis) is based off hypergeometric or Fisher's exact test

Gene Set Enrichment analysis comes in two main flavors
- Self-contained; Are any of the genes in my set differentially expressed? Does not consider genes outside of your set
- Competitive (most popular approach); Are genes in my set more commonly differentially expressed than genes outside the set? Considers genes outside your set



# Code notes

[Previous Topic](../Lecture10:ModuleID/Lecture10.md)
[Next Lecture Topic](../Lecture12:RMarkdown/Lecture12.md)