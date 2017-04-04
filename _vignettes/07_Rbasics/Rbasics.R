## ----style, echo = FALSE, results = 'asis'-------------------------------
BiocStyle::markdown()
options(width=100, max.print=1000)
knitr::opts_chunk$set(
    eval=as.logical(Sys.getenv("KNITR_EVAL", "TRUE")),
    cache=as.logical(Sys.getenv("KNITR_CACHE", "TRUE")))

## ----setup, echo=FALSE, messages=FALSE, warnings=FALSE-------------------
suppressPackageStartupMessages({
    library(limma) 
    library(ggplot2) }) 

## ----install_cran, eval=FALSE--------------------------------------------
## install.packages(c("pkg1", "pkg2"))
## install.packages("pkg.zip", repos=NULL)

## ----install_bioc, eval=FALSE--------------------------------------------
## source("http://www.bioconductor.org/biocLite.R")
## library(BiocInstaller)
## BiocVersion()
## biocLite()
## biocLite(c("pkg1", "pkg2"))

## ----closing_r, eval=FALSE-----------------------------------------------
## q()

## ----r_assignment, eval=FALSE--------------------------------------------
## object <- ...

## ----r_ls, eval=FALSE----------------------------------------------------
## ls()

## ----r_dirshow, eval=FALSE-----------------------------------------------
## dir()

## ----r_dirpath, eval=FALSE-----------------------------------------------
## getwd()

## ----r_setwd, eval=FALSE-------------------------------------------------
## setwd("/home/user")

## ----r_syntax, eval=FALSE------------------------------------------------
## object <- function_name(arguments)
## object <- object[arguments]

## ----r_find_help, eval=FALSE---------------------------------------------
## ?function_name

## ----r_package_load, eval=FALSE------------------------------------------
## library("my_library")

## ----r_package_functions, eval=FALSE-------------------------------------
## library(help="my_library")

## ----r_load_vignette, eval=FALSE-----------------------------------------
## vignette("my_library")

## ----r_execute_script, eval=FALSE----------------------------------------
## source("my_script.R")

## ----sh_execute_script, eval=FALSE, engine="sh"--------------------------
## $ Rscript my_script.R
## $ R CMD BATCH my_script.R
## $ R --slave < my_script.R

## ----r_numeric_data, eval=TRUE-------------------------------------------

x <- c(1, 2, 3)
x
is.numeric(x)
as.character(x)

## ----r_character_data, eval=TRUE-----------------------------------------
x <- c("1", "2", "3")
x
is.character(x)
as.numeric(x)

## ----r_complex_data, eval=TRUE-------------------------------------------
c(1, "b", 3)

## ----r_logical_data, eval=TRUE-------------------------------------------
x <- 1:10 < 5
x  
!x
which(x) # Returns index for the 'TRUE' values in logical vector

## ----r_vector_object, eval=TRUE------------------------------------------
myVec <- 1:10; names(myVec) <- letters[1:10]  
myVec[1:5]
myVec[c(2,4,6,8)]
myVec[c("b", "d", "f")]

## ----r_factor_object, eval=TRUE------------------------------------------
factor(c("dog", "cat", "mouse", "dog", "dog", "cat"))

## ----r_matrix_object, eval=TRUE------------------------------------------
myMA <- matrix(1:30, 3, 10, byrow = TRUE) 
class(myMA)
myMA[1:2,]
myMA[1, , drop=FALSE]

## ----r_dataframe_object, eval=TRUE---------------------------------------
myDF <- data.frame(Col1=1:10, Col2=10:1) 
myDF[1:2, ]

## ----r_list_object, eval=TRUE--------------------------------------------
myL <- list(name="Fred", wife="Mary", no.children=3, child.ages=c(4,7,9)) 
myL
myL[[4]][1:2] 

## ----r_function_object, eval=FALSE---------------------------------------
## myfct <- function(arg1, arg2, ...) {
## 	function_body
## }

## ----r_subset_by_index, eval=TRUE----------------------------------------
myVec <- 1:26; names(myVec) <- LETTERS 
myVec[1:4]

## ----r_subset_by_logical, eval=TRUE--------------------------------------
myLog <- myVec > 10
myVec[myLog] 

## ----r_subset_by_names, eval=TRUE----------------------------------------
myVec[c("B", "K", "M")]

## ----r_subset_by_dollar, eval=TRUE---------------------------------------
iris$Species[1:8]

## ----r_combine_vectors, eval=TRUE----------------------------------------
c(1, 2, 3)
x <- 1:3; y <- 101:103
c(x, y)
iris$Species[1:8]

## ----r_cbind_rbind, eval=TRUE--------------------------------------------
ma <- cbind(x, y)
ma
rbind(ma, ma)

## ----r_length_dim, eval=TRUE---------------------------------------------
length(iris$Species)
dim(iris)

## ----col_row_names, eval=TRUE--------------------------------------------
rownames(iris)[1:8]
colnames(iris)

## ----name_slots, eval=TRUE-----------------------------------------------
names(myVec)
names(myL)

## ----sort_objects, eval=TRUE---------------------------------------------
sort(10:1)

## ----order_objects, eval=TRUE--------------------------------------------
sortindex <- order(iris[,1], decreasing = FALSE)
sortindex[1:12]
iris[sortindex,][1:2,]
sortindex <- order(-iris[,1]) # Same as decreasing=TRUE

## ----order_columns, eval=TRUE--------------------------------------------
iris[order(iris$Sepal.Length, iris$Sepal.Width),][1:2,]

## ----comparison_operators, eval=TRUE-------------------------------------
1==1

## ----logical_operators, eval=TRUE----------------------------------------
x <- 1:10; y <- 10:1
x > y & x > 5

## ----logical_calculations, eval=TRUE-------------------------------------
x + y
sum(x)
mean(x)
apply(iris[1:6,1:3], 1, mean) 

## ----read_delim, eval=FALSE----------------------------------------------
## myDF <- read.delim("myData.xls", sep="\t")

## ----read_excel, eval=FALSE----------------------------------------------
## library(gdata)
## myDF <- read.xls"myData.xls")

## ----read_gs, eval=FALSE-------------------------------------------------
## library("googlesheets"); library("dplyr"); library(knitr)
## gs_auth() # Creates authorizaton token (.httr-oauth) in current directory if not present
## sheetid <-"1U-32UcwZP1k3saKeaH1mbvEAOfZRdNHNkWK2GI1rpPM"
## gap <- gs_key(sheetid)
## mysheet <- gs_read(gap, skip=4)
## myDF <- as.data.frame(mysheet)
## myDF

## ----write_table, eval=FALSE---------------------------------------------
## write.table(myDF, file="myfile.xls", sep="\t", quote=FALSE, col.names=NA)

## ----readlines, eval=FALSE-----------------------------------------------
## myDF <- readLines("myData.txt")

## ----writelines, eval=FALSE----------------------------------------------
## writeLines(month.name, "myData.txt")

## ----paste_windows, eval=FALSE-------------------------------------------
## read.delim("clipboard")

## ----paste_osx, eval=FALSE-----------------------------------------------
## read.delim(pipe("pbpaste"))

## ----copy_windows, eval=FALSE--------------------------------------------
## write.table(iris, "clipboard", sep="\t", col.names=NA, quote=F)

## ----copy_osx, eval=FALSE------------------------------------------------
## zz <- pipe('pbcopy', 'w')
## write.table(iris, zz, sep="\t", col.names=NA, quote=F)
## close(zz)

## ----unique, eval=TRUE---------------------------------------------------
length(iris$Sepal.Length)
length(unique(iris$Sepal.Length))

## ----table, eval=TRUE----------------------------------------------------
table(iris$Species)

## ----aggregate, eval=TRUE------------------------------------------------
aggregate(iris[,1:4], by=list(iris$Species), FUN=mean, na.rm=TRUE)

## ----intersect, eval=TRUE------------------------------------------------
month.name %in% c("May", "July")

## ----merge, eval=TRUE----------------------------------------------------
frame1 <- iris[sample(1:length(iris[,1]), 30), ]
frame1[1:2,]
dim(frame1)
my_result <- merge(frame1, iris, by.x = 0, by.y = 0, all = TRUE)
dim(my_result)

## ----load_sqlite, eval=TRUE----------------------------------------------
library(RSQLite)
mydb <- dbConnect(SQLite(), "test.db") # Creates database file test.db
mydf1 <- data.frame(ids=paste0("id", seq_along(iris[,1])), iris)
mydf2 <- mydf1[sample(seq_along(mydf1[,1]), 10),]
dbWriteTable(mydb, "mydf1", mydf1)
dbWriteTable(mydb, "mydf2", mydf2)

## ----list_tables, eval=TRUE----------------------------------------------
dbListTables(mydb)

## ----import_sqlite_tables, eval=TRUE-------------------------------------
dbGetQuery(mydb, 'SELECT * FROM mydf2')

## ----query_sqlite_tables, eval=TRUE--------------------------------------
dbGetQuery(mydb, 'SELECT * FROM mydf1 WHERE "Sepal.Length" < 4.6')

## ----join_sqlite_tables, eval=TRUE---------------------------------------
dbGetQuery(mydb, 'SELECT * FROM mydf1, mydf2 WHERE mydf1.ids = mydf2.ids')

## ----sample_data, eval=TRUE----------------------------------------------
set.seed(1410)
y <- matrix(runif(30), ncol=3, dimnames=list(letters[1:10], LETTERS[1:3]))

## ----basic_scatter_plot, eval=TRUE---------------------------------------
plot(y[,1], y[,2]) 

## ----pairs_scatter_plot, eval=TRUE---------------------------------------
pairs(y) 

## ----labels_scatter_plot, eval=TRUE--------------------------------------
plot(y[,1], y[,2], pch=20, col="red", main="Symbols and Labels")
text(y[,1]+0.03, y[,2], rownames(y))

## ----row_scatter_plot, eval=TRUE-----------------------------------------
plot(y[,1], y[,2], type="n", main="Plot of Labels")
text(y[,1], y[,2], rownames(y)) 

## ----plot_usage, eval=FALSE----------------------------------------------
## grid(5, 5, lwd = 2)
## op <- par(mar=c(8,8,8,8), bg="lightblue")
## plot(y[,1], y[,2], type="p", col="red", cex.lab=1.2, cex.axis=1.2,
##      cex.main=1.2, cex.sub=1, lwd=4, pch=20, xlab="x label",
##      ylab="y label", main="My Main", sub="My Sub")
## par(op)

## ----plot_regression, eval=TRUE------------------------------------------
plot(y[,1], y[,2])
myline <- lm(y[,2]~y[,1]); abline(myline, lwd=2) 
summary(myline) 

## ----plot_regression_log, eval=TRUE--------------------------------------
plot(y[,1], y[,2], log="xy") 

## ----plot_regression_math, eval=TRUE-------------------------------------
plot(y[,1], y[,2]); text(y[1,1], y[1,2], expression(sum(frac(1,sqrt(x^2*pi)))), cex=1.3) 

## ----plot_line_single, eval=TRUE-----------------------------------------
plot(y[,1], type="l", lwd=2, col="blue") 

## ----plot_line_many, eval=TRUE-------------------------------------------
split.screen(c(1,1)) 
plot(y[,1], ylim=c(0,1), xlab="Measurement", ylab="Intensity", type="l", lwd=2, col=1)
for(i in 2:length(y[1,])) { 
	screen(1, new=FALSE)
	plot(y[,i], ylim=c(0,1), type="l", lwd=2, col=i, xaxt="n", yaxt="n", ylab="", xlab="", main="", bty="n") 
}
close.screen(all=TRUE) 

## ----plot_bar_simple, eval=TRUE------------------------------------------
barplot(y[1:4,], ylim=c(0, max(y[1:4,])+0.3), beside=TRUE, legend=letters[1:4]) 
text(labels=round(as.vector(as.matrix(y[1:4,])),2), x=seq(1.5, 13, by=1) + sort(rep(c(0,1,2), 4)), y=as.vector(as.matrix(y[1:4,]))+0.04) 

## ----plot_bar_error, eval=TRUE-------------------------------------------
bar <- barplot(m <- rowMeans(y) * 10, ylim=c(0, 10))
stdev <- sd(t(y))
arrows(bar, m, bar, m + stdev, length=0.15, angle = 90)

## ----plot_hist, eval=TRUE------------------------------------------------
hist(y, freq=TRUE, breaks=10)

## ----plot_dens, eval=TRUE------------------------------------------------
plot(density(y), col="red")

## ----plot_pie, eval=TRUE-------------------------------------------------
pie(y[,1], col=rainbow(length(y[,1]), start=0.1, end=0.8), clockwise=TRUE)
legend("topright", legend=row.names(y), cex=1.3, bty="n", pch=15, pt.cex=1.8, 
col=rainbow(length(y[,1]), start=0.1, end=0.8), ncol=1) 

## ----color_palette, eval=TRUE--------------------------------------------
palette()
palette(rainbow(5, start=0.1, end=0.2))
palette()
palette("default")

## ----color_grey, eval=TRUE-----------------------------------------------
gray(seq(0.1, 1, by= 0.2))

## ----color_gradient, eval=TRUE-------------------------------------------
library(gplots)
colorpanel(5, "darkblue", "yellow", "white")

## ----save_graphics, eval=FALSE-------------------------------------------
## pdf("test.pdf")
## plot(1:10, 1:10)
## dev.off()

## ----save_graphics_svg, eval=FALSE---------------------------------------
## library("RSvgDevice")
## devSVG("test.svg")
## plot(1:10, 1:10)
## dev.off()

## ----import_data1, eval=FALSE--------------------------------------------
## my_mw <- read.delim(file="MolecularWeight_tair7.xls", header=T, sep="\t")
## my_mw[1:2,]

## ----import_data2, eval=FALSE--------------------------------------------
## my_target <- read.delim(file="TargetP_analysis_tair7.xls", header=T, sep="\t")
## my_target[1:2,]

## ----import_data1b, eval=TRUE--------------------------------------------
my_mw <- read.delim(file="http://faculty.ucr.edu/~tgirke/Documents/R_BioCond/Samples/MolecularWeight_tair7.xls", header=T, sep="\t") 
my_mw[1:2,]

## ----import_data2b, eval=TRUE--------------------------------------------
my_target <- read.delim(file="http://faculty.ucr.edu/~tgirke/Documents/R_BioCond/Samples/TargetP_analysis_tair7.xls", header=T, sep="\t") 
my_target[1:2,]

## ----col_names_uni, eval=TRUE--------------------------------------------
colnames(my_target)[1] <- "ID"
colnames(my_mw)[1] <- "ID" 

## ----merge_tables, eval=TRUE---------------------------------------------
my_mw_target <- merge(my_mw, my_target, by.x="ID", by.y="ID", all.x=T)

## ----merge_tables_shorten, eval=TRUE-------------------------------------
my_mw_target2a <- merge(my_mw, my_target[1:40,], by.x="ID", by.y="ID", all.x=T)  # To remove non-matching rows, use the argument setting 'all=F'.
my_mw_target2 <- na.omit(my_mw_target2a) # Removes rows containing "NAs" (non-matching rows).

## ----homework3D_solutions, eval=FALSE, echo=FALSE------------------------
## my_mw_target_tmp <- merge(my_mw, my_target[1:40,], by.x="ID", by.y="ID", all=FALSE)
## all(my_mw_target2 == my_mw_target_tmp)
## my_mw_target2a <- as.matrix(my_mw_target2a)
## my_mw_target2a[is.na(my_mw_target2a)] <- 0
## my_mw_target2a <- as.data.frame(my_mw_target2a)

## ----filter_tables1, eval=TRUE-------------------------------------------
query <- my_mw_target[my_mw_target[, 2] > 100000 & my_mw_target[, 4] == "C", ] 
query[1:4, ]
dim(query)

## ----string_sub, eval=TRUE-----------------------------------------------
my_mw_target3 <- data.frame(loci=gsub("\\..*", "", as.character(my_mw_target[,1]), perl = TRUE), my_mw_target)
my_mw_target3[1:3,1:8]

## ----calcul_1, eval=TRUE-------------------------------------------------
mycounts <- table(my_mw_target3[,1])[my_mw_target3[,1]]
my_mw_target4 <- cbind(my_mw_target3, Freq=mycounts[as.character(my_mw_target3[,1])]) 

## ----calcul_2, eval=TRUE-------------------------------------------------
data.frame(my_mw_target4, avg_AA_WT=(my_mw_target4[,3] / my_mw_target4[,4]))[1:2,5:11] 

## ----calcul_3, eval=TRUE-------------------------------------------------
mymean <- apply(my_mw_target4[,6:9], 1, mean)
mystdev <- apply(my_mw_target4[,6:9], 1, sd, na.rm=TRUE)
data.frame(my_mw_target4, mean=mymean, stdev=mystdev)[1:2,5:12] 

## ----plot_example, eval=TRUE---------------------------------------------
plot(my_mw_target4[1:500,3:4], col="red")

## ----export_example, eval=TRUE-------------------------------------------
write.table(my_mw_target4, file="my_file.xls", quote=F, sep="\t", col.names = NA) 

## ----source_example, eval=FALSE------------------------------------------
## source("exerciseRbasics.R")

## ----install_rmarkdown, eval=FALSE---------------------------------------
## install.packages("rmarkdown")

## ----render_rmarkdown, eval=FALSE, message=FALSE-------------------------
## rmarkdown::render("sample.Rmd", clean=TRUE, output_format="html_document")

## ----render_commandline, eval=FALSE, message=FALSE, engine="sh"----------
## $ echo "rmarkdown::render('sample.Rmd', clean=TRUE)" | R --slave
## $ Rscript -e "rmarkdown::render('sample.Rmd', clean=TRUE)"

## ----render_makefile, eval=FALSE, message=FALSE, engine="sh"-------------
## $ make -B

## ----kable---------------------------------------------------------------
library(knitr)
kable(iris[1:12,])

## ----some_jitter_plot, eval=TRUE-----------------------------------------
library(ggplot2)
dsmall <- diamonds[sample(nrow(diamonds), 1000), ]
ggplot(dsmall, aes(color, price/carat)) + geom_jitter(alpha = I(1 / 2), aes(color=color))

## ----some_custom_inserted_plot, eval=TRUE, warning=FALSE, message=FALSE----
png("myplot.png")
ggplot(dsmall, aes(color, price/carat)) + geom_jitter(alpha = I(1 / 2), aes(color=color))
dev.off()

## ----sessionInfo---------------------------------------------------------
sessionInfo()

