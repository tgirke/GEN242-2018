---
title: 3. Run workflow
last_updated: Wed May 10 19:37:04 2017
sidebar: mydoc_sidebar
permalink: mydoc_systemPipeChIPseq_03.html
---

Now open the R markdown script `systemPipeChIPseq.Rmd`in your R IDE (_e.g._ vim-r or RStudio) and 
run the workflow as outlined below. 


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

The `systemPipeR` package needs to be loaded to perform the analysis steps shown in
this report (H Backman et al., 2016).


```r
library(systemPipeR)
```

If applicable users can load custom functions not provided by `systemPipeR`. Skip
this step if this is not the case.


```r
source("systemPipeChIPseq_Fct.R")
```

<br><br><center><a href="mydoc_systemPipeChIPseq_02.html"><img src="images/left_arrow.png" alt="Previous page."></a>Previous Page &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Next Page
<a href="mydoc_systemPipeChIPseq_04.html"><img src="images/right_arrow.png" alt="Next page."></a></center>
