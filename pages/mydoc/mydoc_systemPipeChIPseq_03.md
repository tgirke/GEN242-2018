---
title: 3. Run workflow
last_updated: Wed May 10 19:32:42 2017
sidebar: mydoc_sidebar
permalink: mydoc_systemPipeChIPseq_03.html
---

Now open the R markdown script `systemPipeChIPseq.Rmd`in your R IDE (_e.g._ vim-r or RStudio) and 
run the workflow as outlined below. 

The `systemPipeR` package needs to be loaded to perform the analysis steps shown in
this report (H Backman et al., 2016).


## Run R session on computer node

After opening the `Rmd` file of this workflow in Vim and attaching a connected
R session via the `F2` (or other) key, use the following command sequence to run your R
session on a computer node. 


```r
q("no") # closes R session on head node
srun --x11 --partition=short --mem=2gb --cpus-per-task 4 --ntasks 1 --time 2:00:00 --pty bash -l
module load R/3.3.0
R
```

Now check whether your R session is running on a computer node of the cluster and assess your environment.


```r
system("hostname") # should return name of a compute node starting with i or c 
getwd() # checks current working directory of R session
dir() # returns content of current working directory
```

Load `systemPipeR` package


```r
library(systemPipeR)
```

If applicable users can load custom functions not provided by `systemPipeR`. Skip
this step if this is not the case.


```r
source("systemPipeChIPseq_Fct.R")
```

## Experiment definition provided by `targets` file

The `targets` file defines all FASTQ files and sample comparisons of the analysis workflow.


```r
targetspath <- system.file("extdata", "targets_chip.txt", package="systemPipeR")
targets <- read.delim(targetspath, comment.char = "#")
targets[1:4,-c(5,6)]
```

```
##                   FileName SampleName Factor SampleLong SampleReference
## 1 ./data/SRR446027_1.fastq        M1A     M1  Mock.1h.A                
## 2 ./data/SRR446028_1.fastq        M1B     M1  Mock.1h.B                
## 3 ./data/SRR446029_1.fastq        A1A     A1   Avr.1h.A             M1A
## 4 ./data/SRR446030_1.fastq        A1B     A1   Avr.1h.B             M1B
```

<br><br><center><a href="mydoc_systemPipeChIPseq_02.html"><img src="images/left_arrow.png" alt="Previous page."></a>Previous Page &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Next Page
<a href="mydoc_systemPipeChIPseq_04.html"><img src="images/right_arrow.png" alt="Next page."></a></center>
