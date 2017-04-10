---
title: 5. Basic Syntax
last_updated: Sun Apr  9 18:51:21 2017
sidebar: mydoc_sidebar
permalink: mydoc_Rbasics_05.html
---

General R command syntax


{% highlight r %}
object <- function_name(arguments) 
object <- object[arguments] 
{% endhighlight %}

Finding help


{% highlight r %}
?function_name
{% endhighlight %}

Load a library/package


{% highlight r %}
library("my_library") 
{% endhighlight %}

List functions defined by a library


{% highlight r %}
library(help="my_library")
{% endhighlight %}

Load library manual (PDF or HTML file)


{% highlight r %}
vignette("my_library") 
{% endhighlight %}

Execute an R script from within R


{% highlight r %}
source("my_script.R")
{% endhighlight %}

Execute an R script from command-line (the first of the three options is preferred)


{% highlight sh %}
$ Rscript my_script.R
$ R CMD BATCH my_script.R 
$ R --slave < my_script.R 
{% endhighlight %}

<br><br><center><a href="mydoc_Rbasics_04.html"><img src="images/left_arrow.png" alt="Previous page."></a>Previous Page &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Next Page
<a href="mydoc_Rbasics_06.html"><img src="images/right_arrow.png" alt="Next page."></a></center>
