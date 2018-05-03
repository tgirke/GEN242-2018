---
title: HW7 - RNA-Seq Analysis
sidebar: mydoc_sidebar
permalink: mydoc_homework_07.html 
---

## A. Unstranded and strand-specific read counting

- __Task 1__: Rerun the [RNA-Seq workflow](http://girke.bioinformatics.ucr.edu/GEN242/mydoc_systemPipeRNAseq_01.html) with the toy data sets to the read quantification step [here](http://girke.bioinformatics.ucr.edu/GEN242/mydoc_systemPipeRNAseq_05.html). In the read quantification step with `summarizeOverlaps` generate count tables for the following three strand modes:

   1. Unstranded 
   2. Strand-specific for positive (sense) strand
   3. Strand-specific for negative (antisense) strand
   
The solution for generating the unstranded read counts is given below.

{% highlight r %}
summarizeOverlaps(eByg, x, mode="Union", 
					ignore.strand=TRUE, 
                                        # preprocess.reads=invertStrand,
					inter.feature=FALSE, 
                                        singleEnd=TRUE)

{% endhighlight %}

Before attempting to solve this homework section please read the vignette _Counting reads with `summarizeOverlaps`_ ([here](http://bioconductor.org/packages/release/bioc/html/GenomicAlignments.html)) from the `GenomicAlignments` package that defines the `summarizeOverlap` function .

- __Task 2__: Provide R code that demonstrates that the two strand-specific count tables sum up to the values of the unstranded count table. 

- __Task 3__: Explain the utility (biological relevance) of the different counting modes used under Task 1. Include your explanation as comment text in your homework script (see `HW7.R` below). 

## B. Read counting for different feature types
- __Task 4__: Compute strand-specific count tables for the positive (sense) strand of the following feature types: 

   1. Genes
   2. Exons
   3. Exons by genes 
   4. Introns by genes
   5. 5'-UTRs

## Homework submission

Assemble the code from the homework assignments A-B in a single R script (`HW7.R`) and upload it to your private GitHub repository under `Homework/HW7/HW7.R`. Please do not upload any data such as count tables with your homework.

## Due date

This homework is due in one week on Thu, May 10th at 6:00 PM.
