---
title: Operators and Calculations
last_updated: Tue Apr  4 21:47:38 2017
sidebar: mydoc_sidebar
permalink: mydoc_Rbasics_09.html
---

## Comparison Operators

Comparison operators: `==`, `!=`, `<`, `>`, `<=`, `>=`

{% highlight r %}
1==1
{% endhighlight %}

{% highlight txt %}
## [1] TRUE
{% endhighlight %}
Logical operators: AND: `&`, OR: `|`, NOT: `!`

{% highlight r %}
x <- 1:10; y <- 10:1
x > y & x > 5
{% endhighlight %}

{% highlight txt %}
##  [1] FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE
{% endhighlight %}

## Basic Calculations

To look up math functions, see Function Index [here](http://cran.at.r-project.org/doc/manuals/R-intro.html#Function-and-variable-index)

{% highlight r %}
x + y
{% endhighlight %}

{% highlight txt %}
##  [1] 11 11 11 11 11 11 11 11 11 11
{% endhighlight %}

{% highlight r %}
sum(x)
{% endhighlight %}

{% highlight txt %}
## [1] 55
{% endhighlight %}

{% highlight r %}
mean(x)
{% endhighlight %}

{% highlight txt %}
## [1] 5.5
{% endhighlight %}

{% highlight r %}
apply(iris[1:6,1:3], 1, mean) 
{% endhighlight %}

{% highlight txt %}
##        1        2        3        4        5        6 
## 3.333333 3.100000 3.066667 3.066667 3.333333 3.666667
{% endhighlight %}

