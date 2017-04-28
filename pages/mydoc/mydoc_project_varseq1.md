---
title: VAR-Seq1 - Functional Prediction of Variants
sidebar: mydoc_sidebar
permalink: mydoc_project_varseq1.html 
---

## VAR-Seq Workflow  

+ Read preprocessing
    + Quality filtering (trimming)
    + FASTQ quality report
+ Alignments
+ Alignment statistics
+ Variant calling
+ Variant filtering
+ Variant annotation
+ Combine results from many samples
+ Summary statistics of samples

## Challenge Project: Comparison of functional prediction methods of variants

+ Run workflow from start to finish (steps 1-8) on data set from Lu et al (2012)
+ Challenge project tasks
    + Compare the performance of the 3 functional prediction tools from Shihab et al. (2015), Kumar et al. (2009) and Adzhubei et al. (2013) for at least 10 of the highest ranking non-synonymous variants identified. Consider in your comparisons the following analysis/visualization steps:
        + Report unique and common functional variants identified by the three functional prediction tools.
        + Plot the results as venn diagrams or similar
        + Plot the performance of the three methods in form of ROC plots. As true result set one can use the union of the functional variants identified by all three methods. 
        + Optional: add any additional annotations such as proximity of functional variants to Pfam domains or Prosite motifs.


## References

+ Lu P, Han X, Qi J, Yang J, Wijeratne AJ, Li T, Ma H (2012) Analysis of Arabidopsis genome-wide variations before and after meiosis and meiotic recombination by resequencing Landsberg erecta and all four products of a single meiosis. Genome Res 22: 508–518 [PubMed](http://www.ncbi.nlm.nih.gov/pubmed/22106370)
+ Shihab HA, Rogers MF, Gough J, Mort M, Cooper DN, Day INM, Gaunt TR, Campbell C (2015) An integrative approach to predicting the functional effects of non-coding and coding sequence variation. Bioinformatics 31: 1536–1543 [PubMed](http://www.ncbi.nlm.nih.gov/pubmed/25583119)
+ Kumar P, Henikoff S, Ng PC (2009) Predicting the effects of coding non-synonymous variants on protein function using the SIFT algorithm. Nat Protoc 4: 1073–1081 [PubMed](http://www.ncbi.nlm.nih.gov/pubmed/19561590)
+ Adzhubei I, Jordan DM, Sunyaev SR (2013) Predicting functional effect of human missense mutations using PolyPhen-2. Curr Protoc Hum Genet Chapter 7: Unit7.20 [PubMed](http://www.ncbi.nlm.nih.gov/pubmed/23315928)



