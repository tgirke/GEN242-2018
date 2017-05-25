---
title: 6. Specialty Graphics
last_updated: Wed May 24 17:53:09 2017
sidebar: mydoc_sidebar
permalink: mydoc_Rgraphics_6.html
---

## Venn Diagrams 


```r
library(systemPipeR)
setlist5 <- list(A=sample(letters, 18), B=sample(letters, 16), C=sample(letters, 20), D=sample(letters, 22), E=sample(letters, 18))
OLlist5 <- overLapper(setlist=setlist5, sep="_", type="vennsets")
vennPlot(OLlist5, mymain="", mysub="", colmode=2, ccol=c("blue", "red"))
```

<img src="./pages/mydoc/Rgraphics_files/specgraph_venn-1.png" width="672" />

## Compound Structures 

Plots depictions of small molecules with `ChemmineR` package


```r
library(ChemmineR)
data(sdfsample)
plot(sdfsample[1], print=FALSE)
```

<img src="./pages/mydoc/Rgraphics_files/specgraph_structure-1.png" width="672" />

## ROC Plots

A variety of libraries are available for plotting receiver operating characteristic (ROC) curves in R:

+ [ROCR](http://rocr.bioinf.mpi-sb.mpg.de/)
+ [ROC](http://bioconductor.org/packages/release/bioc/html/ROC.html)
+ [pROC](http://web.expasy.org/pROC/)
+ [ggplot2](http://largedata.blogspot.com/2011/07/plotting-roc-curves-in-ggplot2.html)

## Trees 

The [`ape`](http://ape-package.ird.fr/ape_screenshots.html) package provides many useful utilities for phylogenetic analysis and tree plotting. Another useful package for 
plotting trees is [`ggtree`](http://bioconductor.org/packages/release/bioc/html/ggtree.html). The following example plots two trees face to face with links to identical
leaf labels.


```r
library(ape)
tree1 <- rtree(40)
tree2 <- rtree(20)
association <- cbind(tree2$tip.label, tree2$tip.label)
cophyloplot(tree1, tree2, assoc = association,
            length.line = 4, space = 28, gap = 3)
```

<img src="./pages/mydoc/Rgraphics_files/trees_ape1-1.png" width="672" />



<br><br><center><a href="mydoc_Rgraphics_5.html"><img src="images/left_arrow.png" alt="Previous page."></a>Previous Page &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Next Page
<a href="mydoc_Rgraphics_7.html"><img src="images/right_arrow.png" alt="Next page."></a></center>
