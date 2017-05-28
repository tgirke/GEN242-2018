---
title: 12. dplyr and data.table 
last_updated: Sun May 28 10:36:53 2017
sidebar: mydoc_sidebar
permalink: mydoc_Rbasics_12.html
---

Modern object classes and methods for handling `data.frame` like structures
are provided by the `data.table` and `dplyr` packages. The following gives a
short introduction to the usage and functionalities of the `dplyr` package. 
More detailed tutorials on this topic can be found here:

* [dplyr: A Grammar of Data Manipulation](https://rdrr.io/cran/dplyr/){:target="_blank"}
* [Cheatsheet from Jenny Bryan](http://stat545.com/bit001_dplyr-cheatsheet.html){:target="_blank"}
* [Introduction to `dplyr`](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html){:target="_blank"}
* [Tutorial on `dplyr`](http://genomicsclass.github.io/book/pages/dplyr_tutorial.html){:target="_blank"}
* [Tibbles](https://cran.r-project.org/web/packages/tibble/vignettes/tibble.html){:target="_blank"}
* [Intro to `data.table` package](https://www.r-bloggers.com/intro-to-the-data-table-package/){:target="_blank"}
* [Big data with `dplyr` and `data.table`](https://www.r-bloggers.com/working-with-large-datasets-with-dplyr-and-data-table/){:target="_blank"}
* [Fast lookups with `dplyr` and `data.table`](https://www.r-bloggers.com/fast-data-lookups-in-r-dplyr-vs-data-table/){:target="_blank"}

## Construct a `data frame` (`tibble`)


```r
library(dplyr); library(tibble); library(data.table)
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
as_tibble(iris) # newer function provided by tibble package
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

## Fast table import with `fread` 


```r
write.table(iris, "iris.txt", row.names=FALSE, quote=FALSE, sep="\t") # Creates sample file
iris_df <- as_data_frame(fread("iris.txt")) # Import with fread and conversion to tibble
iris_df
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
unlink("iris.txt") # Deletes temp file
```

Note: to ignore lines starting with comment signs, one can pass on to `fread` a shell
command for preprocessing the file. The following example illustrates this option.


```r
fread("grep -v '^#' iris.txt") 
```
## Column and row binds

The equivalents to base R's `rbind` and `cbind` are `bind_rows` and `bind_cols`, respectively.


```r
bind_cols(iris_df, iris_df)
```

```
## # A tibble: 150 × 10
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species Sepal.Length Sepal.Width Petal.Length
##           <dbl>       <dbl>        <dbl>       <dbl>   <chr>        <dbl>       <dbl>        <dbl>
## 1           5.1         3.5          1.4         0.2  setosa          5.1         3.5          1.4
## 2           4.9         3.0          1.4         0.2  setosa          4.9         3.0          1.4
## 3           4.7         3.2          1.3         0.2  setosa          4.7         3.2          1.3
## 4           4.6         3.1          1.5         0.2  setosa          4.6         3.1          1.5
## 5           5.0         3.6          1.4         0.2  setosa          5.0         3.6          1.4
## 6           5.4         3.9          1.7         0.4  setosa          5.4         3.9          1.7
## 7           4.6         3.4          1.4         0.3  setosa          4.6         3.4          1.4
## 8           5.0         3.4          1.5         0.2  setosa          5.0         3.4          1.5
## 9           4.4         2.9          1.4         0.2  setosa          4.4         2.9          1.4
## 10          4.9         3.1          1.5         0.1  setosa          4.9         3.1          1.5
## # ... with 140 more rows, and 2 more variables: Petal.Width <dbl>, Species <chr>
```

```r
bind_rows(iris_df, iris_df)
```

```
## # A tibble: 300 × 5
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
## # ... with 290 more rows
```

## Important `dplyr` functions

1. `filter()` and `slice()`
2. `arrange()`
3. `select()` and `rename()`
4. `distinct()`
5. `mutate()` and `transmute()`
6. `summarise()`
7. `sample_n()` and `sample_frac()`

## Slice and filter functions 

### Filter function


```r
filter(iris_df, Sepal.Length > 7.5, Species=="virginica")
```

```
## # A tibble: 6 × 5
##   Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
##          <dbl>       <dbl>        <dbl>       <dbl>     <chr>
## 1          7.6         3.0          6.6         2.1 virginica
## 2          7.7         3.8          6.7         2.2 virginica
## 3          7.7         2.6          6.9         2.3 virginica
## 4          7.7         2.8          6.7         2.0 virginica
## 5          7.9         3.8          6.4         2.0 virginica
## 6          7.7         3.0          6.1         2.3 virginica
```

### Base R code equivalent


```r
iris_df[iris_df[, "Sepal.Length"] > 7.5 & iris_df[, "Species"]=="virginica", ]
```

```
## # A tibble: 6 × 5
##   Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
##          <dbl>       <dbl>        <dbl>       <dbl>     <chr>
## 1          7.6         3.0          6.6         2.1 virginica
## 2          7.7         3.8          6.7         2.2 virginica
## 3          7.7         2.6          6.9         2.3 virginica
## 4          7.7         2.8          6.7         2.0 virginica
## 5          7.9         3.8          6.4         2.0 virginica
## 6          7.7         3.0          6.1         2.3 virginica
```

### Including boolean operators


```r
filter(iris_df, Sepal.Length > 7.5 | Sepal.Length < 5.5, Species=="virginica")
```

```
## # A tibble: 7 × 5
##   Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
##          <dbl>       <dbl>        <dbl>       <dbl>     <chr>
## 1          7.6         3.0          6.6         2.1 virginica
## 2          4.9         2.5          4.5         1.7 virginica
## 3          7.7         3.8          6.7         2.2 virginica
## 4          7.7         2.6          6.9         2.3 virginica
## 5          7.7         2.8          6.7         2.0 virginica
## 6          7.9         3.8          6.4         2.0 virginica
## 7          7.7         3.0          6.1         2.3 virginica
```

### Subset rows by position

`dplyr` approach


```r
slice(iris_df, 1:2)
```

```
## # A tibble: 2 × 5
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
##          <dbl>       <dbl>        <dbl>       <dbl>   <chr>
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
```

Base R code equivalent


```r
iris_df[1:2,]
```

```
## # A tibble: 2 × 5
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
##          <dbl>       <dbl>        <dbl>       <dbl>   <chr>
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
```

## Sorting with `arrange`

Row-wise ordering based on specific columns

`dplyr` approach


```r
arrange(iris_df, Species, Sepal.Length, Sepal.Width)
```

```
## # A tibble: 150 × 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
##           <dbl>       <dbl>        <dbl>       <dbl>   <chr>
## 1           4.3         3.0          1.1         0.1  setosa
## 2           4.4         2.9          1.4         0.2  setosa
## 3           4.4         3.0          1.3         0.2  setosa
## 4           4.4         3.2          1.3         0.2  setosa
## 5           4.5         2.3          1.3         0.3  setosa
## 6           4.6         3.1          1.5         0.2  setosa
## 7           4.6         3.2          1.4         0.2  setosa
## 8           4.6         3.4          1.4         0.3  setosa
## 9           4.6         3.6          1.0         0.2  setosa
## 10          4.7         3.2          1.3         0.2  setosa
## # ... with 140 more rows
```

For ordering descendingly use `desc()` function


```r
arrange(iris_df, desc(Species), Sepal.Length, Sepal.Width)
```

```
## # A tibble: 150 × 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
##           <dbl>       <dbl>        <dbl>       <dbl>     <chr>
## 1           4.9         2.5          4.5         1.7 virginica
## 2           5.6         2.8          4.9         2.0 virginica
## 3           5.7         2.5          5.0         2.0 virginica
## 4           5.8         2.7          5.1         1.9 virginica
## 5           5.8         2.7          5.1         1.9 virginica
## 6           5.8         2.8          5.1         2.4 virginica
## 7           5.9         3.0          5.1         1.8 virginica
## 8           6.0         2.2          5.0         1.5 virginica
## 9           6.0         3.0          4.8         1.8 virginica
## 10          6.1         2.6          5.6         1.4 virginica
## # ... with 140 more rows
```

Base R code equivalent


```r
iris_df[order(iris_df$Species, iris_df$Sepal.Length, iris_df$Sepal.Width), ]
```

```
## # A tibble: 150 × 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
##           <dbl>       <dbl>        <dbl>       <dbl>   <chr>
## 1           4.3         3.0          1.1         0.1  setosa
## 2           4.4         2.9          1.4         0.2  setosa
## 3           4.4         3.0          1.3         0.2  setosa
## 4           4.4         3.2          1.3         0.2  setosa
## 5           4.5         2.3          1.3         0.3  setosa
## 6           4.6         3.1          1.5         0.2  setosa
## 7           4.6         3.2          1.4         0.2  setosa
## 8           4.6         3.4          1.4         0.3  setosa
## 9           4.6         3.6          1.0         0.2  setosa
## 10          4.7         3.2          1.3         0.2  setosa
## # ... with 140 more rows
```

```r
iris_df[order(iris_df$Species, decreasing=TRUE), ] 
```

```
## # A tibble: 150 × 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
##           <dbl>       <dbl>        <dbl>       <dbl>     <chr>
## 1           6.3         3.3          6.0         2.5 virginica
## 2           5.8         2.7          5.1         1.9 virginica
## 3           7.1         3.0          5.9         2.1 virginica
## 4           6.3         2.9          5.6         1.8 virginica
## 5           6.5         3.0          5.8         2.2 virginica
## 6           7.6         3.0          6.6         2.1 virginica
## 7           4.9         2.5          4.5         1.7 virginica
## 8           7.3         2.9          6.3         1.8 virginica
## 9           6.7         2.5          5.8         1.8 virginica
## 10          7.2         3.6          6.1         2.5 virginica
## # ... with 140 more rows
```

## Select columns with `select`

Select specific columns


```r
select(iris_df, Species, Petal.Length, Sepal.Length)
```

```
## # A tibble: 150 × 3
##    Species Petal.Length Sepal.Length
##      <chr>        <dbl>        <dbl>
## 1   setosa          1.4          5.1
## 2   setosa          1.4          4.9
## 3   setosa          1.3          4.7
## 4   setosa          1.5          4.6
## 5   setosa          1.4          5.0
## 6   setosa          1.7          5.4
## 7   setosa          1.4          4.6
## 8   setosa          1.5          5.0
## 9   setosa          1.4          4.4
## 10  setosa          1.5          4.9
## # ... with 140 more rows
```

Select range of columns by name


```r
select(iris_df, Sepal.Length : Petal.Width)
```

```
## # A tibble: 150 × 4
##    Sepal.Length Sepal.Width Petal.Length Petal.Width
##           <dbl>       <dbl>        <dbl>       <dbl>
## 1           5.1         3.5          1.4         0.2
## 2           4.9         3.0          1.4         0.2
## 3           4.7         3.2          1.3         0.2
## 4           4.6         3.1          1.5         0.2
## 5           5.0         3.6          1.4         0.2
## 6           5.4         3.9          1.7         0.4
## 7           4.6         3.4          1.4         0.3
## 8           5.0         3.4          1.5         0.2
## 9           4.4         2.9          1.4         0.2
## 10          4.9         3.1          1.5         0.1
## # ... with 140 more rows
```

Drop specific columns (here range)


```r
select(iris_df, -(Sepal.Length : Petal.Width))
```

```
## # A tibble: 150 × 1
##    Species
##      <chr>
## 1   setosa
## 2   setosa
## 3   setosa
## 4   setosa
## 5   setosa
## 6   setosa
## 7   setosa
## 8   setosa
## 9   setosa
## 10  setosa
## # ... with 140 more rows
```

## Renaming columns with `rename`


`dplyr` approach


```r
rename(iris_df, new_col_name = Species)
```

```
## # A tibble: 150 × 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width new_col_name
##           <dbl>       <dbl>        <dbl>       <dbl>        <chr>
## 1           5.1         3.5          1.4         0.2       setosa
## 2           4.9         3.0          1.4         0.2       setosa
## 3           4.7         3.2          1.3         0.2       setosa
## 4           4.6         3.1          1.5         0.2       setosa
## 5           5.0         3.6          1.4         0.2       setosa
## 6           5.4         3.9          1.7         0.4       setosa
## 7           4.6         3.4          1.4         0.3       setosa
## 8           5.0         3.4          1.5         0.2       setosa
## 9           4.4         2.9          1.4         0.2       setosa
## 10          4.9         3.1          1.5         0.1       setosa
## # ... with 140 more rows
```

Base R code approach


```r
colnames(iris_df)[colnames(iris_df)=="Species"] <- "new_col_names"
```

## Obtain unique rows with `distinct`

`dplyr` approach


```r
distinct(iris_df, Species, .keep_all=TRUE)
```

```
## # A tibble: 3 × 5
##   Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
##          <dbl>       <dbl>        <dbl>       <dbl>      <chr>
## 1          5.1         3.5          1.4         0.2     setosa
## 2          7.0         3.2          4.7         1.4 versicolor
## 3          6.3         3.3          6.0         2.5  virginica
```

Base R code approach


```r
iris_df[!duplicated(iris_df$Species),]
```

```
## # A tibble: 3 × 5
##   Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
##          <dbl>       <dbl>        <dbl>       <dbl>      <chr>
## 1          5.1         3.5          1.4         0.2     setosa
## 2          7.0         3.2          4.7         1.4 versicolor
## 3          6.3         3.3          6.0         2.5  virginica
```

## Add columns

### `mutate`

The `mutate` function allows to append columns to existing ones.


```r
mutate(iris_df, Ratio = Sepal.Length / Sepal.Width, Sum = Sepal.Length + Sepal.Width)
```

```
## # A tibble: 150 × 7
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species    Ratio   Sum
##           <dbl>       <dbl>        <dbl>       <dbl>   <chr>    <dbl> <dbl>
## 1           5.1         3.5          1.4         0.2  setosa 1.457143   8.6
## 2           4.9         3.0          1.4         0.2  setosa 1.633333   7.9
## 3           4.7         3.2          1.3         0.2  setosa 1.468750   7.9
## 4           4.6         3.1          1.5         0.2  setosa 1.483871   7.7
## 5           5.0         3.6          1.4         0.2  setosa 1.388889   8.6
## 6           5.4         3.9          1.7         0.4  setosa 1.384615   9.3
## 7           4.6         3.4          1.4         0.3  setosa 1.352941   8.0
## 8           5.0         3.4          1.5         0.2  setosa 1.470588   8.4
## 9           4.4         2.9          1.4         0.2  setosa 1.517241   7.3
## 10          4.9         3.1          1.5         0.1  setosa 1.580645   8.0
## # ... with 140 more rows
```

### `transmute`

The `transmute` function does the same as `mutate` but drops existing columns


```r
transmute(iris_df, Ratio = Sepal.Length / Sepal.Width, Sum = Sepal.Length + Sepal.Width)
```

```
## # A tibble: 150 × 2
##       Ratio   Sum
##       <dbl> <dbl>
## 1  1.457143   8.6
## 2  1.633333   7.9
## 3  1.468750   7.9
## 4  1.483871   7.7
## 5  1.388889   8.6
## 6  1.384615   9.3
## 7  1.352941   8.0
## 8  1.470588   8.4
## 9  1.517241   7.3
## 10 1.580645   8.0
## # ... with 140 more rows
```

### `bind_cols`

The `bind_cols` function is the equivalent of `cbind` in base R. To add rows, use the corresponding 
`bind_rows` function.


```r
bind_cols(iris_df, iris_df)
```

```
## # A tibble: 150 × 10
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species Sepal.Length Sepal.Width Petal.Length
##           <dbl>       <dbl>        <dbl>       <dbl>   <chr>        <dbl>       <dbl>        <dbl>
## 1           5.1         3.5          1.4         0.2  setosa          5.1         3.5          1.4
## 2           4.9         3.0          1.4         0.2  setosa          4.9         3.0          1.4
## 3           4.7         3.2          1.3         0.2  setosa          4.7         3.2          1.3
## 4           4.6         3.1          1.5         0.2  setosa          4.6         3.1          1.5
## 5           5.0         3.6          1.4         0.2  setosa          5.0         3.6          1.4
## 6           5.4         3.9          1.7         0.4  setosa          5.4         3.9          1.7
## 7           4.6         3.4          1.4         0.3  setosa          4.6         3.4          1.4
## 8           5.0         3.4          1.5         0.2  setosa          5.0         3.4          1.5
## 9           4.4         2.9          1.4         0.2  setosa          4.4         2.9          1.4
## 10          4.9         3.1          1.5         0.1  setosa          4.9         3.1          1.5
## # ... with 140 more rows, and 2 more variables: Petal.Width <dbl>, Species <chr>
```

## Summarize data

Summary calculation on single column


```r
summarize(iris_df, mean(Petal.Length))
```

```
## # A tibble: 1 × 1
##   `mean(Petal.Length)`
##                  <dbl>
## 1                3.758
```

Summary calculation on many columns


```r
summarize_all(iris_df[,1:4], mean)
```

```
## # A tibble: 1 × 4
##   Sepal.Length Sepal.Width Petal.Length Petal.Width
##          <dbl>       <dbl>        <dbl>       <dbl>
## 1     5.843333    3.057333        3.758    1.199333
```

Summarize by grouping column


```r
summarize(group_by(iris_df, Species), mean(Petal.Length))
```

```
## # A tibble: 3 × 2
##      Species `mean(Petal.Length)`
##        <chr>                <dbl>
## 1     setosa                1.462
## 2 versicolor                4.260
## 3  virginica                5.552
```

### Extract column as vector

The subsetting operators `[[` and `$`can be used to extract from a `data frame` single columns as vector.


```r
iris_df[[5]][1:12]
```

```
##  [1] "setosa" "setosa" "setosa" "setosa" "setosa" "setosa" "setosa" "setosa" "setosa" "setosa"
## [11] "setosa" "setosa"
```

```r
iris_df$Species[1:12]
```

```
##  [1] "setosa" "setosa" "setosa" "setosa" "setosa" "setosa" "setosa" "setosa" "setosa" "setosa"
## [11] "setosa" "setosa"
```

## Chaining

To simplify chaining of serveral operations (pipes), `dplyr` provides the `%>%` operator. where `x %>% f(y)`
turns into `f(x, y)`. This way one can write multiple operations that can read left-to-right or 
top-to-bottom. This makes for easy to type and readable code.


```r
iris_df %>% # Declare data frame to use 
    select(Sepal.Length:Species) %>% # Select columns
    filter(Species=="setosa") %>% # Filter rows by some value
    arrange(Sepal.Length) %>% # Sort by some column
    mutate(Subtract=Petal.Length - Petal.Width) %>% # Calculate and append
    write.table("iris.txt", quote=FALSE, row.names=FALSE, sep="\t") # Export to file
```

<br><br><center><a href="mydoc_Rbasics_11.html"><img src="images/left_arrow.png" alt="Previous page."></a>Previous Page &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Next Page
<a href="mydoc_Rbasics_13.html"><img src="images/right_arrow.png" alt="Next page."></a></center>
