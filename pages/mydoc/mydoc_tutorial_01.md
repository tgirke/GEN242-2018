---
title: GitHub Introduction
sidebar: mydoc_sidebar
permalink: mydoc_tutorial_01.html 
---

## GEN242 and GitHub 

+ Note, this class will make heavy use of GitHub 
+ Homework assignments will be submitted to private GitHub repositories: one repository for each student
+ Course projects will also use private GitHub repositories: one repository for each course project (shared among students of each project)
+ Each student will need a personal GitHub account. They can be created [here](https://github.com/personal).
+ GitHub provides an unlimited number of free public repositories to each user. Via GitHub Education students can sign up for free private GitHub accounts (see [here](https://education.github.com)).
+ All private GitHub accounts required for this class will be provided by the instructor via [GitHub Classroom](https://classroom.github.com/)
+ For beginners this [quick guide](https://guides.github.com/activities/hello-world/) may be useful

## What are Git and GitHub?

+ Git is a distributed version control system similar to SVN
+ GitHub is an online social coding service based on Git 
+ Combined Git/GitHub: environment for version control and social coding

## Installing Git
+ [Install](http://git-scm.com/book/en/Getting-Started-Installing-Git) on Windows, OS X and Linux
+ When using it from RStudio, it needs to find the Git executable

## Git Basics from Command-Line

+ Finding help from command-line 

{% highlight sh %}
git <command> --help
{% endhighlight %}

+ Initialize a directory as a Git repository

{% highlight sh %}
git init
{% endhighlight %}
	
+ Add files to Git repository (staging area) 

{% highlight sh %}
git add myfile
{% endhighlight %}

After editing file(s) in your repos, record a snapshot of the staging area 

{% highlight sh %}
git commit -am "some edits"
{% endhighlight %}


## GitHub Basics from Command-Line

+ Generate a new remote repository. Alternatively, create the repository online on the GitHub site.

{% highlight sh %}
git remote add origin https://github.com/tgirke/myrepos.git
{% endhighlight %}

+ Push updates to remote. Next time one can just use `git push`

{% highlight sh %}
git push -u origin master
{% endhighlight %}

+ Clone existing remote repository
    
{% highlight sh %}
git clone git@github.com:<user_name>/<repos_name>.git
{% endhighlight %}

+ Before working on project, update local git repos 

{% highlight sh %}
git pull 
{% endhighlight %}

+ Make changes and recommit local to remote 

{% highlight sh %}
git commit -am "some edits"; git push -u origin master
{% endhighlight %}


## Using GitHub from RStudio
+ After installing Git, set path to Git executable in Rstudio: 
	+ Tools `>` Global Options `>` Git/SVN

+ If needed, login to GitHub account and create repository. Use option `Initialize this repository with a README`. 

+ Clone repository by copying & pasting URL from repository into RStudio's 'Clone Git Repository' window: 
    + File `>` New Project `>` Version Control `>` Git `>` Provide URL

+ Now do some work (_e.g._ add an R script), commit and push changes as follows: 
    + Tools `>` Version Control `>` Commit

+ Check files in staging area and press `Commit Button`

+ To commit changes to GitHub, press `Push Button`

+ Shortcuts to automate above routines are [here](https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts)

+ To resolve password issues, follow instructions [here](https://github.com/jennybc/stat540_2014/blob/master/seminars/seminar92_git.md). 


