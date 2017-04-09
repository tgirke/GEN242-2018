---
title: SQLite Databases
last_updated: Sun Apr  9 15:29:37 2017
sidebar: mydoc_sidebar
permalink: mydoc_Rbasics_12.html
---

`SQLite` is a lightweight relational database solution. The `RSQLite` package provides an easy to use interface to create, manage and query `SQLite` databases directly from R. Basic instructions
for using `SQLite` from the command-line are available [here](https://www.sqlite.org/cli.html). A short introduction to `RSQLite` is available [here](https://github.com/rstats-db/RSQLite/blob/master/vignettes/RSQLite.Rmd).

## Loading data into SQLite databases

The following loads two `data.frames` derived from the `iris` data set (here `mydf1` and `mydf2`) 
into an SQLite database (here `test.db`).


{% highlight r %}
library(RSQLite)
{% endhighlight %}

{% highlight txt %}
## Loading required package: DBI
{% endhighlight %}

{% highlight r %}
mydb <- dbConnect(SQLite(), "test.db") # Creates database file test.db
mydf1 <- data.frame(ids=paste0("id", seq_along(iris[,1])), iris)
mydf2 <- mydf1[sample(seq_along(mydf1[,1]), 10),]
dbWriteTable(mydb, "mydf1", mydf1)
{% endhighlight %}

{% highlight txt %}
## [1] TRUE
{% endhighlight %}

{% highlight r %}
dbWriteTable(mydb, "mydf2", mydf2)
{% endhighlight %}

{% highlight txt %}
## [1] TRUE
{% endhighlight %}

## List names of tables in database


{% highlight r %}
dbListTables(mydb)
{% endhighlight %}

{% highlight txt %}
## [1] "mydf1" "mydf2"
{% endhighlight %}

## Import table into `data.frame`


{% highlight r %}
dbGetQuery(mydb, 'SELECT * FROM mydf2')
{% endhighlight %}

{% highlight txt %}
##      ids Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
## 1   id46          4.8         3.0          1.4         0.3     setosa
## 2  id137          6.3         3.4          5.6         2.4  virginica
## 3   id87          6.7         3.1          4.7         1.5 versicolor
## 4    id8          5.0         3.4          1.5         0.2     setosa
## 5   id42          4.5         2.3          1.3         0.3     setosa
## 6   id16          5.7         4.4          1.5         0.4     setosa
## 7  id142          6.9         3.1          5.1         2.3  virginica
## 8  id117          6.5         3.0          5.5         1.8  virginica
## 9   id41          5.0         3.5          1.3         0.3     setosa
## 10  id56          5.7         2.8          4.5         1.3 versicolor
{% endhighlight %}

## Query database


{% highlight r %}
dbGetQuery(mydb, 'SELECT * FROM mydf1 WHERE "Sepal.Length" < 4.6')
{% endhighlight %}

{% highlight txt %}
##    ids Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1  id9          4.4         2.9          1.4         0.2  setosa
## 2 id14          4.3         3.0          1.1         0.1  setosa
## 3 id39          4.4         3.0          1.3         0.2  setosa
## 4 id42          4.5         2.3          1.3         0.3  setosa
## 5 id43          4.4         3.2          1.3         0.2  setosa
{% endhighlight %}

## Join tables

The two tables can be joined on the shared `ids` column as follows. 


{% highlight r %}
dbGetQuery(mydb, 'SELECT * FROM mydf1, mydf2 WHERE mydf1.ids = mydf2.ids')
{% endhighlight %}

{% highlight txt %}
##      ids Sepal.Length Sepal.Width Petal.Length Petal.Width    Species   ids Sepal.Length
## 1    id8          5.0         3.4          1.5         0.2     setosa   id8          5.0
## 2   id16          5.7         4.4          1.5         0.4     setosa  id16          5.7
## 3   id41          5.0         3.5          1.3         0.3     setosa  id41          5.0
## 4   id42          4.5         2.3          1.3         0.3     setosa  id42          4.5
## 5   id46          4.8         3.0          1.4         0.3     setosa  id46          4.8
## 6   id56          5.7         2.8          4.5         1.3 versicolor  id56          5.7
## 7   id87          6.7         3.1          4.7         1.5 versicolor  id87          6.7
## 8  id117          6.5         3.0          5.5         1.8  virginica id117          6.5
## 9  id137          6.3         3.4          5.6         2.4  virginica id137          6.3
## 10 id142          6.9         3.1          5.1         2.3  virginica id142          6.9
##    Sepal.Width Petal.Length Petal.Width    Species
## 1          3.4          1.5         0.2     setosa
## 2          4.4          1.5         0.4     setosa
## 3          3.5          1.3         0.3     setosa
## 4          2.3          1.3         0.3     setosa
## 5          3.0          1.4         0.3     setosa
## 6          2.8          4.5         1.3 versicolor
## 7          3.1          4.7         1.5 versicolor
## 8          3.0          5.5         1.8  virginica
## 9          3.4          5.6         2.4  virginica
## 10         3.1          5.1         2.3  virginica
{% endhighlight %}


<br><br><center><a href="mydoc_Rbasics_11.html"><img src="images/left_arrow.png" alt="Previous page."></a>Previous Page &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Next Page
<a href="mydoc_Rbasics_13.html"><img src="images/right_arrow.png" alt="Next page."></a></center>
