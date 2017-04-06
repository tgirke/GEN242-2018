---
title: SQLite Databases
last_updated: Tue Apr  4 21:47:38 2017
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
## 1  id115          5.8         2.8          5.1         2.4  virginica
## 2   id73          6.3         2.5          4.9         1.5 versicolor
## 3   id80          5.7         2.6          3.5         1.0 versicolor
## 4   id63          6.0         2.2          4.0         1.0 versicolor
## 5  id123          7.7         2.8          6.7         2.0  virginica
## 6   id99          5.1         2.5          3.0         1.1 versicolor
## 7  id126          7.2         3.2          6.0         1.8  virginica
## 8    id2          4.9         3.0          1.4         0.2     setosa
## 9   id91          5.5         2.6          4.4         1.2 versicolor
## 10  id20          5.1         3.8          1.5         0.3     setosa
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
## 1    id2          4.9         3.0          1.4         0.2     setosa   id2          4.9
## 2   id20          5.1         3.8          1.5         0.3     setosa  id20          5.1
## 3   id63          6.0         2.2          4.0         1.0 versicolor  id63          6.0
## 4   id73          6.3         2.5          4.9         1.5 versicolor  id73          6.3
## 5   id80          5.7         2.6          3.5         1.0 versicolor  id80          5.7
## 6   id91          5.5         2.6          4.4         1.2 versicolor  id91          5.5
## 7   id99          5.1         2.5          3.0         1.1 versicolor  id99          5.1
## 8  id115          5.8         2.8          5.1         2.4  virginica id115          5.8
## 9  id123          7.7         2.8          6.7         2.0  virginica id123          7.7
## 10 id126          7.2         3.2          6.0         1.8  virginica id126          7.2
##    Sepal.Width Petal.Length Petal.Width    Species
## 1          3.0          1.4         0.2     setosa
## 2          3.8          1.5         0.3     setosa
## 3          2.2          4.0         1.0 versicolor
## 4          2.5          4.9         1.5 versicolor
## 5          2.6          3.5         1.0 versicolor
## 6          2.6          4.4         1.2 versicolor
## 7          2.5          3.0         1.1 versicolor
## 8          2.8          5.1         2.4  virginica
## 9          2.8          6.7         2.0  virginica
## 10         3.2          6.0         1.8  virginica
{% endhighlight %}


