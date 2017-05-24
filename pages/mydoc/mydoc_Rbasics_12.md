---
title: 12. Modern Data Frames
last_updated: Tue May 23 21:57:26 2017
sidebar: mydoc_sidebar
permalink: mydoc_Rbasics_12.html
---

Modern day object classes and methods for handling `data.frame` like structures are provided by the `data.table` and `dplyr` packages. 
The following provides a short introduction to their usage and functionalities. More detailed tutorials on this topic can be found here:

* [`dplyr` Introduction](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)
* [`dplyr` Tutorial](http://genomicsclass.github.io/book/pages/dplyr_tutorial.html)
* [Tibbles](https://cran.r-project.org/web/packages/tibble/vignettes/tibble.html)
* [Intro to `data.table` package](https://www.r-bloggers.com/intro-to-the-data-table-package/)
* [Working with large datasets using `dplyr` and `data.table`](https://www.r-bloggers.com/working-with-large-datasets-with-dplyr-and-data-table/)
* [Fast data lookups: `dplyr` vs `data.table`](https://www.r-bloggers.com/fast-data-lookups-in-r-dplyr-vs-data-table/)

## Construct a `data frame tbl`


```r
library(dplyr); library(data.table)
as_data_frame(iris) # coerce data.frame to data frame tbl
```

```
## # A tibble: 150 × 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
##           <dbl>       <dbl>        <dbl>       <dbl>  <fctr>
## 1           5.1         3.5          1.4         0.2  setosa
## 2           4.9         3.0          1.4         0.2  setosa
## 3           4.7         3.2          1.3         0.2  setosa
## 4           4.6         3.1          1.5         0.2  setosa
## 5           5.0         3.6          1.4         0.2  setosa
## 6           5.4         3.9          1.7         0.4  setosa
## 7           4.6         3.4          1.4         0.3  setosa
## 8           5.0         3.4          1.5         0.2  setosa
## 9           4.4         2.9          1.4         0.2  setosa
## 10          4.9         3.1          1.5         0.1  setosa
## # ... with 140 more rows
```

```r
tbl_df(iris) # gives same result; this alternative exists for historical reasons
```

```
## # A tibble: 150 × 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
##           <dbl>       <dbl>        <dbl>       <dbl>  <fctr>
## 1           5.1         3.5          1.4         0.2  setosa
## 2           4.9         3.0          1.4         0.2  setosa
## 3           4.7         3.2          1.3         0.2  setosa
## 4           4.6         3.1          1.5         0.2  setosa
## 5           5.0         3.6          1.4         0.2  setosa
## 6           5.4         3.9          1.7         0.4  setosa
## 7           4.6         3.4          1.4         0.3  setosa
## 8           5.0         3.4          1.5         0.2  setosa
## 9           4.4         2.9          1.4         0.2  setosa
## 10          4.9         3.1          1.5         0.1  setosa
## # ... with 140 more rows
```

## Fast data import from file via fread from data.table package


```r
write.table(iris, "iris.txt", row.names=FALSE, quote=FALSE, sep="\t") # Creates sample file
tbl_df(fread("iris.txt")) # Import with fread and conversion to tibble
```

```
## # A tibble: 150 × 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
##           <dbl>       <dbl>        <dbl>       <dbl>   <chr>
## 1           5.1         3.5          1.4         0.2  setosa
## 2           4.9         3.0          1.4         0.2  setosa
## 3           4.7         3.2          1.3         0.2  setosa
## 4           4.6         3.1          1.5         0.2  setosa
## 5           5.0         3.6          1.4         0.2  setosa
## 6           5.4         3.9          1.7         0.4  setosa
## 7           4.6         3.4          1.4         0.3  setosa
## 8           5.0         3.4          1.5         0.2  setosa
## 9           4.4         2.9          1.4         0.2  setosa
## 10          4.9         3.1          1.5         0.1  setosa
## # ... with 140 more rows
```

```r
unlink("iris.txt")
```

## Basic `dplyr` functions for data manipulation

A. `filter()` (and `slice()`)
B. `arrange()`
C. `select()` (and `rename()`)
D. `distinct()`
E. `mutate()` (and `transmute()`)
F. `summarise()`
G. `sample_n()` (and `sample_frac()`)


```r
library(nycflights13)
dim(flights)
```

```
## [1] 336776     19
```

```r
flights
```

```
## # A tibble: 336,776 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time arr_delay carrier
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>     <dbl>   <chr>
## 1   2013     1     1      517            515         2      830            819        11      UA
## 2   2013     1     1      533            529         4      850            830        20      UA
## 3   2013     1     1      542            540         2      923            850        33      AA
## 4   2013     1     1      544            545        -1     1004           1022       -18      B6
## 5   2013     1     1      554            600        -6      812            837       -25      DL
## 6   2013     1     1      554            558        -4      740            728        12      UA
## 7   2013     1     1      555            600        -5      913            854        19      B6
## 8   2013     1     1      557            600        -3      709            723       -14      EV
## 9   2013     1     1      557            600        -3      838            846        -8      B6
## 10  2013     1     1      558            600        -2      753            745         8      AA
## # ... with 336,766 more rows, and 9 more variables: flight <int>, tailnum <chr>, origin <chr>,
## #   dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>
```

## Slice and filter functions 

### Filter function


```r
filter(flights, month == 1, day == 1)
```

```
## # A tibble: 842 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time arr_delay carrier
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>     <dbl>   <chr>
## 1   2013     1     1      517            515         2      830            819        11      UA
## 2   2013     1     1      533            529         4      850            830        20      UA
## 3   2013     1     1      542            540         2      923            850        33      AA
## 4   2013     1     1      544            545        -1     1004           1022       -18      B6
## 5   2013     1     1      554            600        -6      812            837       -25      DL
## 6   2013     1     1      554            558        -4      740            728        12      UA
## 7   2013     1     1      555            600        -5      913            854        19      B6
## 8   2013     1     1      557            600        -3      709            723       -14      EV
## 9   2013     1     1      557            600        -3      838            846        -8      B6
## 10  2013     1     1      558            600        -2      753            745         8      AA
## # ... with 832 more rows, and 9 more variables: flight <int>, tailnum <chr>, origin <chr>,
## #   dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>
```

### Base R code equivalent


```r
flights[flights[,"month"]==1 & flights[,"day"]==1,]
```

```
## # A tibble: 842 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time arr_delay carrier
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>     <dbl>   <chr>
## 1   2013     1     1      517            515         2      830            819        11      UA
## 2   2013     1     1      533            529         4      850            830        20      UA
## 3   2013     1     1      542            540         2      923            850        33      AA
## 4   2013     1     1      544            545        -1     1004           1022       -18      B6
## 5   2013     1     1      554            600        -6      812            837       -25      DL
## 6   2013     1     1      554            558        -4      740            728        12      UA
## 7   2013     1     1      555            600        -5      913            854        19      B6
## 8   2013     1     1      557            600        -3      709            723       -14      EV
## 9   2013     1     1      557            600        -3      838            846        -8      B6
## 10  2013     1     1      558            600        -2      753            745         8      AA
## # ... with 832 more rows, and 9 more variables: flight <int>, tailnum <chr>, origin <chr>,
## #   dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>
```

### Including boolean operators


```r
filter(flights, month == 1 | month == 2)
```

```
## # A tibble: 51,955 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time arr_delay carrier
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>     <dbl>   <chr>
## 1   2013     1     1      517            515         2      830            819        11      UA
## 2   2013     1     1      533            529         4      850            830        20      UA
## 3   2013     1     1      542            540         2      923            850        33      AA
## 4   2013     1     1      544            545        -1     1004           1022       -18      B6
## 5   2013     1     1      554            600        -6      812            837       -25      DL
## 6   2013     1     1      554            558        -4      740            728        12      UA
## 7   2013     1     1      555            600        -5      913            854        19      B6
## 8   2013     1     1      557            600        -3      709            723       -14      EV
## 9   2013     1     1      557            600        -3      838            846        -8      B6
## 10  2013     1     1      558            600        -2      753            745         8      AA
## # ... with 51,945 more rows, and 9 more variables: flight <int>, tailnum <chr>, origin <chr>,
## #   dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>
```

### Subset rows by position

`dplyr` version


```r
slice(flights, 1:10)
```

```
## # A tibble: 10 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time arr_delay carrier
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>     <dbl>   <chr>
## 1   2013     1     1      517            515         2      830            819        11      UA
## 2   2013     1     1      533            529         4      850            830        20      UA
## 3   2013     1     1      542            540         2      923            850        33      AA
## 4   2013     1     1      544            545        -1     1004           1022       -18      B6
## 5   2013     1     1      554            600        -6      812            837       -25      DL
## 6   2013     1     1      554            558        -4      740            728        12      UA
## 7   2013     1     1      555            600        -5      913            854        19      B6
## 8   2013     1     1      557            600        -3      709            723       -14      EV
## 9   2013     1     1      557            600        -3      838            846        -8      B6
## 10  2013     1     1      558            600        -2      753            745         8      AA
## # ... with 9 more variables: flight <int>, tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>,
## #   distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>
```

Base R code equivalent


```r
flights[1:10,]
```

```
## # A tibble: 10 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time arr_delay carrier
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>     <dbl>   <chr>
## 1   2013     1     1      517            515         2      830            819        11      UA
## 2   2013     1     1      533            529         4      850            830        20      UA
## 3   2013     1     1      542            540         2      923            850        33      AA
## 4   2013     1     1      544            545        -1     1004           1022       -18      B6
## 5   2013     1     1      554            600        -6      812            837       -25      DL
## 6   2013     1     1      554            558        -4      740            728        12      UA
## 7   2013     1     1      555            600        -5      913            854        19      B6
## 8   2013     1     1      557            600        -3      709            723       -14      EV
## 9   2013     1     1      557            600        -3      838            846        -8      B6
## 10  2013     1     1      558            600        -2      753            745         8      AA
## # ... with 9 more variables: flight <int>, tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>,
## #   distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>
```

## Order/sort with arrange 

Row-wise ordering based on specific columns

`dplyr` version


```r
arrange(flights, year, month, day)
```

```
## # A tibble: 336,776 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time arr_delay carrier
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>     <dbl>   <chr>
## 1   2013     1     1      517            515         2      830            819        11      UA
## 2   2013     1     1      533            529         4      850            830        20      UA
## 3   2013     1     1      542            540         2      923            850        33      AA
## 4   2013     1     1      544            545        -1     1004           1022       -18      B6
## 5   2013     1     1      554            600        -6      812            837       -25      DL
## 6   2013     1     1      554            558        -4      740            728        12      UA
## 7   2013     1     1      555            600        -5      913            854        19      B6
## 8   2013     1     1      557            600        -3      709            723       -14      EV
## 9   2013     1     1      557            600        -3      838            846        -8      B6
## 10  2013     1     1      558            600        -2      753            745         8      AA
## # ... with 336,766 more rows, and 9 more variables: flight <int>, tailnum <chr>, origin <chr>,
## #   dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>
```

For ordering descendingly use desc() function


```r
arrange(flights, desc(month))
```

```
## # A tibble: 336,776 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time arr_delay carrier
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>     <dbl>   <chr>
## 1   2013    12     1       13           2359        14      446            445         1      B6
## 2   2013    12     1       17           2359        18      443            437         6      B6
## 3   2013    12     1      453            500        -7      636            651       -15      US
## 4   2013    12     1      520            515         5      749            808       -19      UA
## 5   2013    12     1      536            540        -4      845            850        -5      AA
## 6   2013    12     1      540            550       -10     1005           1027       -22      B6
## 7   2013    12     1      541            545        -4      734            755       -21      EV
## 8   2013    12     1      546            545         1      826            835        -9      UA
## 9   2013    12     1      549            600       -11      648            659       -11      US
## 10  2013    12     1      550            600       -10      825            854       -29      B6
## # ... with 336,766 more rows, and 9 more variables: flight <int>, tailnum <chr>, origin <chr>,
## #   dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>
```

Base R code equivalent


```r
flights[order(flights$year, flights$month, flights$day), ]
```

```
## # A tibble: 336,776 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time arr_delay carrier
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>     <dbl>   <chr>
## 1   2013     1     1      517            515         2      830            819        11      UA
## 2   2013     1     1      533            529         4      850            830        20      UA
## 3   2013     1     1      542            540         2      923            850        33      AA
## 4   2013     1     1      544            545        -1     1004           1022       -18      B6
## 5   2013     1     1      554            600        -6      812            837       -25      DL
## 6   2013     1     1      554            558        -4      740            728        12      UA
## 7   2013     1     1      555            600        -5      913            854        19      B6
## 8   2013     1     1      557            600        -3      709            723       -14      EV
## 9   2013     1     1      557            600        -3      838            846        -8      B6
## 10  2013     1     1      558            600        -2      753            745         8      AA
## # ... with 336,766 more rows, and 9 more variables: flight <int>, tailnum <chr>, origin <chr>,
## #   dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>
```

```r
flights[order(flights$month, decreasing = TRUE), ] # or flights[order(-flights$month), ]
```

```
## # A tibble: 336,776 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time arr_delay carrier
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>     <dbl>   <chr>
## 1   2013    12     1       13           2359        14      446            445         1      B6
## 2   2013    12     1       17           2359        18      443            437         6      B6
## 3   2013    12     1      453            500        -7      636            651       -15      US
## 4   2013    12     1      520            515         5      749            808       -19      UA
## 5   2013    12     1      536            540        -4      845            850        -5      AA
## 6   2013    12     1      540            550       -10     1005           1027       -22      B6
## 7   2013    12     1      541            545        -4      734            755       -21      EV
## 8   2013    12     1      546            545         1      826            835        -9      UA
## 9   2013    12     1      549            600       -11      648            659       -11      US
## 10  2013    12     1      550            600       -10      825            854       -29      B6
## # ... with 336,766 more rows, and 9 more variables: flight <int>, tailnum <chr>, origin <chr>,
## #   dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>
```

## Select columns with select 

Select specific columns


```r
select(flights, year, month, day)
```

```
## # A tibble: 336,776 × 3
##     year month   day
##    <int> <int> <int>
## 1   2013     1     1
## 2   2013     1     1
## 3   2013     1     1
## 4   2013     1     1
## 5   2013     1     1
## 6   2013     1     1
## 7   2013     1     1
## 8   2013     1     1
## 9   2013     1     1
## 10  2013     1     1
## # ... with 336,766 more rows
```

Select range of columns by name


```r
select(flights, year:day)
```

```
## # A tibble: 336,776 × 3
##     year month   day
##    <int> <int> <int>
## 1   2013     1     1
## 2   2013     1     1
## 3   2013     1     1
## 4   2013     1     1
## 5   2013     1     1
## 6   2013     1     1
## 7   2013     1     1
## 8   2013     1     1
## 9   2013     1     1
## 10  2013     1     1
## # ... with 336,766 more rows
```

Drop specific columns (here range)


```r
select(flights, -(year:day))
```

```
## # A tibble: 336,776 × 16
##    dep_time sched_dep_time dep_delay arr_time sched_arr_time arr_delay carrier flight tailnum
##       <int>          <int>     <dbl>    <int>          <int>     <dbl>   <chr>  <int>   <chr>
## 1       517            515         2      830            819        11      UA   1545  N14228
## 2       533            529         4      850            830        20      UA   1714  N24211
## 3       542            540         2      923            850        33      AA   1141  N619AA
## 4       544            545        -1     1004           1022       -18      B6    725  N804JB
## 5       554            600        -6      812            837       -25      DL    461  N668DN
## 6       554            558        -4      740            728        12      UA   1696  N39463
## 7       555            600        -5      913            854        19      B6    507  N516JB
## 8       557            600        -3      709            723       -14      EV   5708  N829AS
## 9       557            600        -3      838            846        -8      B6     79  N593JB
## 10      558            600        -2      753            745         8      AA    301  N3ALAA
## # ... with 336,766 more rows, and 7 more variables: origin <chr>, dest <chr>, air_time <dbl>,
## #   distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>
```


<br><br><center><a href="mydoc_Rbasics_11.html"><img src="images/left_arrow.png" alt="Previous page."></a>Previous Page &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Next Page
<a href="mydoc_Rbasics_13.html"><img src="images/right_arrow.png" alt="Next page."></a></center>
