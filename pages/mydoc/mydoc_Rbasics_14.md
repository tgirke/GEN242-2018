---
title: 14. Analysis Routine
last_updated: Sun Apr  9 18:17:50 2017
sidebar: mydoc_sidebar
permalink: mydoc_Rbasics_14.html
---

## Overview

The following exercise introduces a variety of useful data analysis utilities in R. 

## Analysis Routine: Data Import

- __Step 1__: To get started with this exercise, direct your R session to a dedicated workshop directory and download into this directory the following sample tables. Then import the files into Excel and save them as tab delimited text files.

    - [MolecularWeight_tair7.xls](http://faculty.ucr.edu/~tgirke/Documents/R_BioCond/Samples/MolecularWeight_tair7.xls)
    - [TargetP_analysis_tair7.xls](http://faculty.ucr.edu/~tgirke/Documents/R_BioCond/Samples/TargetP_analysis_tair7.xls)

__Import the tables into R__

Import molecular weight table


{% highlight r %}
my_mw <- read.delim(file="MolecularWeight_tair7.xls", header=T, sep="\t") 
my_mw[1:2,]
{% endhighlight %}

Import subcelluar targeting table

{% highlight r %}
my_target <- read.delim(file="TargetP_analysis_tair7.xls", header=T, sep="\t") 
my_target[1:2,]
{% endhighlight %}

Online import of molecular weight table

{% highlight r %}
my_mw <- read.delim(file="http://faculty.ucr.edu/~tgirke/Documents/R_BioCond/Samples/MolecularWeight_tair7.xls", header=T, sep="\t") 
my_mw[1:2,]
{% endhighlight %}

{% highlight txt %}
##   Sequence.id Molecular.Weight.Da. Residues
## 1 AT1G08520.1                83285      760
## 2 AT1G08530.1                27015      257
{% endhighlight %}

Online import of subcelluar targeting table

{% highlight r %}
my_target <- read.delim(file="http://faculty.ucr.edu/~tgirke/Documents/R_BioCond/Samples/TargetP_analysis_tair7.xls", header=T, sep="\t") 
my_target[1:2,]
{% endhighlight %}

{% highlight txt %}
##      GeneName Loc   cTP   mTP    SP other
## 1 AT1G08520.1   C 0.822 0.137 0.029 0.039
## 2 AT1G08530.1   C 0.817 0.058 0.010 0.100
{% endhighlight %}

## Merging Data Frames

- __Step 2__: Assign uniform gene ID column titles


{% highlight r %}
colnames(my_target)[1] <- "ID"
colnames(my_mw)[1] <- "ID" 
{% endhighlight %}

- __Step 3__: Merge the two tables based on common ID field


{% highlight r %}
my_mw_target <- merge(my_mw, my_target, by.x="ID", by.y="ID", all.x=T)
{% endhighlight %}

- __Step 4__: Shorten one table before the merge and then remove the non-matching rows (NAs) in the merged file


{% highlight r %}
my_mw_target2a <- merge(my_mw, my_target[1:40,], by.x="ID", by.y="ID", all.x=T)  # To remove non-matching rows, use the argument setting 'all=F'.
my_mw_target2 <- na.omit(my_mw_target2a) # Removes rows containing "NAs" (non-matching rows).
{% endhighlight %}

- __Homework 3D__: How can the merge function in the previous step be executed so that only the common rows among the two data frames are returned? Prove that both methods - the two step version with `na.omit` and your method - return identical results. 
- __Homework 3E__: Replace all `NAs` in the data frame `my_mw_target2a` with zeros.



## Filtering Data

- __Step 5__: Retrieve all records with a value of greater than 100,000 in 'MW' column and 'C' value in 'Loc' column (targeted to chloroplast).


{% highlight r %}
query <- my_mw_target[my_mw_target[, 2] > 100000 & my_mw_target[, 4] == "C", ] 
query[1:4, ]
{% endhighlight %}

{% highlight txt %}
##               ID Molecular.Weight.Da. Residues  Loc   cTP   mTP    SP other
## NA          <NA>                   NA       NA <NA>    NA    NA    NA    NA
## NA.1        <NA>                   NA       NA <NA>    NA    NA    NA    NA
## NA.2        <NA>                   NA       NA <NA>    NA    NA    NA    NA
## 219  AT1G02730.1               132588     1181    C 0.972 0.038 0.008 0.045
{% endhighlight %}

{% highlight r %}
dim(query)
{% endhighlight %}

{% highlight txt %}
## [1] 1092    8
{% endhighlight %}

- __Homework 3F__: How many protein entries in the `my`_mw`_target` data frame have a MW of greater then 4,000 and less then 5,000. Subset the data frame accordingly and sort it by MW to check that your result is correct.


## String Substitutions

- __Step 6__: Use a regular expression in a substitute function to generate a separate ID column that lacks the gene model extensions.
<<label=Exercise 4.7, eval=TRUE, echo=TRUE, keep.source=TRUE>>=


{% highlight r %}
my_mw_target3 <- data.frame(loci=gsub("\\..*", "", as.character(my_mw_target[,1]), perl = TRUE), my_mw_target)
my_mw_target3[1:3,1:8]
{% endhighlight %}

{% highlight txt %}
##        loci          ID Molecular.Weight.Da. Residues  Loc cTP mTP SP
## 1 AT1G01010 AT1G01010.1                49426      429 <NA>  NA  NA NA
## 2 AT1G01020 AT1G01020.1                28092      245 <NA>  NA  NA NA
## 3 AT1G01020 AT1G01020.2                21711      191 <NA>  NA  NA NA
{% endhighlight %}

- __Homework 3G__: Retrieve those rows in `my_mw_target3` where the second column contains the following identifiers: `c("AT5G52930.1", "AT4G18950.1", "AT1G15385.1", "AT4G36500.1", "AT1G67530.1")`. Use the `%in%` function for this query. As an alternative approach, assign the second column to the row index of the data frame and then perform the same query again using the row index. Explain the difference of the two methods.

## Calculations on Data Frames

- __Step 7__: Count the number of duplicates in the loci column with the `table` function and append the result to the data frame with the `cbind` function.


{% highlight r %}
mycounts <- table(my_mw_target3[,1])[my_mw_target3[,1]]
my_mw_target4 <- cbind(my_mw_target3, Freq=mycounts[as.character(my_mw_target3[,1])]) 
{% endhighlight %}

- __Step 8__: Perform a vectorized devision of columns 3 and 4 (average AA weight per protein)


{% highlight r %}
data.frame(my_mw_target4, avg_AA_WT=(my_mw_target4[,3] / my_mw_target4[,4]))[1:2,5:11] 
{% endhighlight %}

{% highlight txt %}
##    Loc cTP mTP SP other Freq.Var1 Freq.Freq
## 1 <NA>  NA  NA NA    NA AT1G01010         1
## 2 <NA>  NA  NA NA    NA AT1G01020         2
{% endhighlight %}

- __Step 9__: Calculate for each row the mean and standard deviation across several columns


{% highlight r %}
mymean <- apply(my_mw_target4[,6:9], 1, mean)
mystdev <- apply(my_mw_target4[,6:9], 1, sd, na.rm=TRUE)
data.frame(my_mw_target4, mean=mymean, stdev=mystdev)[1:2,5:12] 
{% endhighlight %}

{% highlight txt %}
##    Loc cTP mTP SP other Freq.Var1 Freq.Freq mean
## 1 <NA>  NA  NA NA    NA AT1G01010         1   NA
## 2 <NA>  NA  NA NA    NA AT1G01020         2   NA
{% endhighlight %}

## Plotting Example

- __Step 10__: Generate scatter plot columns: 'MW' and 'Residues' 


{% highlight r %}
plot(my_mw_target4[1:500,3:4], col="red")
{% endhighlight %}

![](./pages/mydoc/Rbasics_files/plot_example-1.pdf )

## Export Results and Run Entire Exercise as Script

- __Step 11__: Write the data frame `my_mw_target4` into a tab-delimited text file and inspect it in Excel.


{% highlight r %}
write.table(my_mw_target4, file="my_file.xls", quote=F, sep="\t", col.names = NA) 
{% endhighlight %}

- __Homework 3H__: Write all commands from this exercise into an R script named `exerciseRbasics.R`, or download it from [here](http://faculty.ucr.edu/~tgirke/Documents/R_BioCond/My_R_Scripts/exerciseRbasics.R). Then execute the script with the `source` function like this: `source("exerciseRbasics.R")`. This will run all commands of this exercise and generate the corresponding output files in the current working directory.


{% highlight r %}
source("exerciseRbasics.R")
{% endhighlight %}

<br><br><center><a href="mydoc_Rbasics_13.html"><img src="images/left_arrow.png" alt="Previous page."></a>Previous Page &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Next Page
<a href="mydoc_Rbasics_15.html"><img src="images/right_arrow.png" alt="Next page."></a></center>
