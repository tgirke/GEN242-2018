---
title: SQLite Databases
last_updated: Sun Apr  9 17:02:07 2017
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
## 1    id8          5.0         3.4          1.5         0.2     setosa
## 2   id28          5.2         3.5          1.5         0.2     setosa
## 3  id111          6.5         3.2          5.1         2.0  virginica
## 4   id65          5.6         2.9          3.6         1.3 versicolor
## 5   id92          6.1         3.0          4.6         1.4 versicolor
## 6  id108          7.3         2.9          6.3         1.8  virginica
## 7  id140          6.9         3.1          5.4         2.1  virginica
## 8   id37          5.5         3.5          1.3         0.2     setosa
## 9  id101          6.3         3.3          6.0         2.5  virginica
## 10 id118          7.7         3.8          6.7         2.2  virginica
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
## 2   id28          5.2         3.5          1.5         0.2     setosa  id28          5.2
## 3   id37          5.5         3.5          1.3         0.2     setosa  id37          5.5
## 4   id65          5.6         2.9          3.6         1.3 versicolor  id65          5.6
## 5   id92          6.1         3.0          4.6         1.4 versicolor  id92          6.1
## 6  id101          6.3         3.3          6.0         2.5  virginica id101          6.3
## 7  id108          7.3         2.9          6.3         1.8  virginica id108          7.3
## 8  id111          6.5         3.2          5.1         2.0  virginica id111          6.5
## 9  id118          7.7         3.8          6.7         2.2  virginica id118          7.7
## 10 id140          6.9         3.1          5.4         2.1  virginica id140          6.9
##    Sepal.Width Petal.Length Petal.Width    Species
## 1          3.4          1.5         0.2     setosa
## 2          3.5          1.5         0.2     setosa
## 3          3.5          1.3         0.2     setosa
## 4          2.9          3.6         1.3 versicolor
## 5          3.0          4.6         1.4 versicolor
## 6          3.3          6.0         2.5  virginica
## 7          2.9          6.3         1.8  virginica
## 8          3.2          5.1         2.0  virginica
## 9          3.8          6.7         2.2  virginica
## 10         3.1          5.4         2.1  virginica
{% endhighlight %}


<br><br><center><a href="mydoc_Rbasics_11.html"><img src="images/left_arrow.png" alt="Previous page."></a>Previous Page &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Next Page
<a href="mydoc_Rbasics_13.html"><img src="images/right_arrow.png" alt="Next page."></a></center>
