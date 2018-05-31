---
title: 13. SQLite Databases
last_updated: Wed May 30 17:07:21 2018
sidebar: mydoc_sidebar
permalink: mydoc_Rbasics_13.html
---

`SQLite` is a lightweight relational database solution. The `RSQLite` package provides an easy to use interface to create, manage and query `SQLite` databases directly from R. Basic instructions
for using `SQLite` from the command-line are available [here](https://www.sqlite.org/cli.html). A short introduction to `RSQLite` is available [here](https://github.com/rstats-db/RSQLite/blob/master/vignettes/RSQLite.Rmd).

## Loading data into SQLite databases

The following loads two `data.frames` derived from the `iris` data set (here `mydf1` and `mydf2`) 
into an SQLite database (here `test.db`).


```r
library(RSQLite)
unlink("test.db") # Delete any existing test.db
mydb <- dbConnect(SQLite(), "test.db") # Creates database file test.db
mydf1 <- data.frame(ids=paste0("id", seq_along(iris[,1])), iris)
mydf2 <- mydf1[sample(seq_along(mydf1[,1]), 10),]
dbWriteTable(mydb, "mydf1", mydf1)
dbWriteTable(mydb, "mydf2", mydf2)
```

## List names of tables in database


```r
dbListTables(mydb)
```

```
## [1] "mydf1" "mydf2"
```

## Import table into `data.frame`


```r
dbGetQuery(mydb, 'SELECT * FROM mydf2')
```

```
##      ids Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
## 1   id70          5.6         2.5          3.9         1.1 versicolor
## 2  id146          6.7         3.0          5.2         2.3  virginica
## 3   id89          5.6         3.0          4.1         1.3 versicolor
## 4   id63          6.0         2.2          4.0         1.0 versicolor
## 5  id117          6.5         3.0          5.5         1.8  virginica
## 6  id113          6.8         3.0          5.5         2.1  virginica
## 7  id130          7.2         3.0          5.8         1.6  virginica
## 8   id96          5.7         3.0          4.2         1.2 versicolor
## 9   id27          5.0         3.4          1.6         0.4     setosa
## 10   id8          5.0         3.4          1.5         0.2     setosa
```

## Query database


```r
dbGetQuery(mydb, 'SELECT * FROM mydf1 WHERE "Sepal.Length" < 4.6')
```

```
##    ids Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1  id9          4.4         2.9          1.4         0.2  setosa
## 2 id14          4.3         3.0          1.1         0.1  setosa
## 3 id39          4.4         3.0          1.3         0.2  setosa
## 4 id42          4.5         2.3          1.3         0.3  setosa
## 5 id43          4.4         3.2          1.3         0.2  setosa
```

## Join tables

The two tables can be joined on the shared `ids` column as follows. 


```r
dbGetQuery(mydb, 'SELECT * FROM mydf1, mydf2 WHERE mydf1.ids = mydf2.ids')
```

```
##      ids Sepal.Length Sepal.Width Petal.Length Petal.Width    Species   ids Sepal.Length
## 1    id8          5.0         3.4          1.5         0.2     setosa   id8          5.0
## 2   id27          5.0         3.4          1.6         0.4     setosa  id27          5.0
## 3   id63          6.0         2.2          4.0         1.0 versicolor  id63          6.0
## 4   id70          5.6         2.5          3.9         1.1 versicolor  id70          5.6
## 5   id89          5.6         3.0          4.1         1.3 versicolor  id89          5.6
## 6   id96          5.7         3.0          4.2         1.2 versicolor  id96          5.7
## 7  id113          6.8         3.0          5.5         2.1  virginica id113          6.8
## 8  id117          6.5         3.0          5.5         1.8  virginica id117          6.5
## 9  id130          7.2         3.0          5.8         1.6  virginica id130          7.2
## 10 id146          6.7         3.0          5.2         2.3  virginica id146          6.7
##    Sepal.Width Petal.Length Petal.Width    Species
## 1          3.4          1.5         0.2     setosa
## 2          3.4          1.6         0.4     setosa
## 3          2.2          4.0         1.0 versicolor
## 4          2.5          3.9         1.1 versicolor
## 5          3.0          4.1         1.3 versicolor
## 6          3.0          4.2         1.2 versicolor
## 7          3.0          5.5         2.1  virginica
## 8          3.0          5.5         1.8  virginica
## 9          3.0          5.8         1.6  virginica
## 10         3.0          5.2         2.3  virginica
```


<br><br><center><a href="mydoc_Rbasics_12.html"><img src="images/left_arrow.png" alt="Previous page."></a>Previous Page &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Next Page
<a href="mydoc_Rbasics_14.html"><img src="images/right_arrow.png" alt="Next page."></a></center>
