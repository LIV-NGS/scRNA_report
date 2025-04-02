[![R](https://ziadoua.github.io/m3-Markdown-Badges/badges/R/r1.svg)](https://www.r-project.org/)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/LIV-NGS/RNA-seq-Report/graphs/commit-activity)

# scRNA-seq-Report

R markdown document to create html reports for scRNA-seq quantification using 10x cellranger and Seurat. 
Following are the steps to use the R markdown script.

The script used salmon quantification using gencode transcripts (download from here: https://www.gencodegenes.org/). 

After quantificaton:


1. Change directory to local directory containing all quantification files for each sample.

2. run sc_report_html.mrd script for generating html report show QC, UMAP and cluster markers:
```
rmarkdown::render("PATH-to-the-rmd-script",output_dir = "full_path_to_output_dir")
```

3. For marker gene expression scRNA_report_shiny.rmd file runs a shiny app to plot marker gene expression (provide full path to shiny/app.R):


```
rmarkdown::render("PATH-to-the-rmd-script",output_dir = "full_path_to_output_dir")
```
