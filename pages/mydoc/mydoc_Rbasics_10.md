---
title: Reading and Writing External Data
last_updated: Sun Apr  9 15:29:37 2017
sidebar: mydoc_sidebar
permalink: mydoc_Rbasics_10.html
---
## Import of tabular data

Import of a tab-delimited tabular file

{% highlight r %}
myDF <- read.delim("myData.xls", sep="\t")
{% endhighlight %}

Import of Excel file. Note: working with tab- or comma-delimited files is more flexible and preferred.

{% highlight r %}
library(gdata)
myDF <- read.xls"myData.xls")
{% endhighlight %}

Import of Google Sheets. The following example imports a sample Google Sheet from [here](https://docs.google.com/spreadsheets/d/1U-32UcwZP1k3saKeaH1mbvEAOfZRdNHNkWK2GI1rpPM/edit#gid=472150521).
Detailed instructions for interacting from R with Google Sheets with the required `googlesheets` package are [here](https://github.com/jennybc/googlesheets).


{% highlight r %}
library("googlesheets"); library("dplyr"); library(knitr)
gs_auth() # Creates authorizaton token (.httr-oauth) in current directory if not present
sheetid <-"1U-32UcwZP1k3saKeaH1mbvEAOfZRdNHNkWK2GI1rpPM"
gap <- gs_key(sheetid)
mysheet <- gs_read(gap, skip=4)
myDF <- as.data.frame(mysheet)
myDF
{% endhighlight %}

## Export of tabular data

{% highlight r %}
write.table(myDF, file="myfile.xls", sep="\t", quote=FALSE, col.names=NA)
{% endhighlight %}

## Line-wise import

{% highlight r %}
myDF <- readLines("myData.txt")
{% endhighlight %}

## Line-wise export

{% highlight r %}
writeLines(month.name, "myData.txt")
{% endhighlight %}

## Copy and paste into R

On Windows/Linux systems

{% highlight r %}
read.delim("clipboard") 
{% endhighlight %}
On Mac OS X systems

{% highlight r %}
read.delim(pipe("pbpaste")) 
{% endhighlight %}

## Copy and paste from R 

On Windows/Linux systems

{% highlight r %}
write.table(iris, "clipboard", sep="\t", col.names=NA, quote=F) 
{% endhighlight %}

On Mac OS X systems

{% highlight r %}
zz <- pipe('pbcopy', 'w')
write.table(iris, zz, sep="\t", col.names=NA, quote=F)
close(zz) 
{% endhighlight %}

## Homework 3A 

Homework 3A: [Object Subsetting Routines and Import/Export](http://girke.bioinformatics.ucr.edu/GEN242/mydoc_homework_03.html)

<br><br><center><a href="mydoc_Rbasics_09.html"><img src="images/left_arrow.png" alt="Previous page."></a>Previous Page &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Next Page
<a href="mydoc_Rbasics_11.html"><img src="images/right_arrow.png" alt="Next page."></a></center>
