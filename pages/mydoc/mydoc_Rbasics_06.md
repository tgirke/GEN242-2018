---
title: 6. Data Types 
last_updated: Sun Apr  9 18:01:25 2017
sidebar: mydoc_sidebar
permalink: mydoc_Rbasics_06.html
---

## Numeric data

Example: `1, 2, 3, ...`


{% highlight r %}
x <- c(1, 2, 3)
x
{% endhighlight %}

{% highlight txt %}
## [1] 1 2 3
{% endhighlight %}

{% highlight r %}
is.numeric(x)
{% endhighlight %}

{% highlight txt %}
## [1] TRUE
{% endhighlight %}

{% highlight r %}
as.character(x)
{% endhighlight %}

{% highlight txt %}
## [1] "1" "2" "3"
{% endhighlight %}

## Character data

Example: `"a", "b", "c", ...`


{% highlight r %}
x <- c("1", "2", "3")
x
{% endhighlight %}

{% highlight txt %}
## [1] "1" "2" "3"
{% endhighlight %}

{% highlight r %}
is.character(x)
{% endhighlight %}

{% highlight txt %}
## [1] TRUE
{% endhighlight %}

{% highlight r %}
as.numeric(x)
{% endhighlight %}

{% highlight txt %}
## [1] 1 2 3
{% endhighlight %}

## Complex data

Example: mix of both


{% highlight r %}
c(1, "b", 3)
{% endhighlight %}

{% highlight txt %}
## [1] "1" "b" "3"
{% endhighlight %}

## Logical data

Example: `TRUE` of `FALSE`


{% highlight r %}
x <- 1:10 < 5
x  
{% endhighlight %}

{% highlight txt %}
##  [1]  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
{% endhighlight %}

{% highlight r %}
!x
{% endhighlight %}

{% highlight txt %}
##  [1] FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
{% endhighlight %}

{% highlight r %}
which(x) # Returns index for the 'TRUE' values in logical vector
{% endhighlight %}

{% highlight txt %}
## [1] 1 2 3 4
{% endhighlight %}

<br><br><center><a href="mydoc_Rbasics_05.html"><img src="images/left_arrow.png" alt="Previous page."></a>Previous Page &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Next Page
<a href="mydoc_Rbasics_07.html"><img src="images/right_arrow.png" alt="Next page."></a></center>
