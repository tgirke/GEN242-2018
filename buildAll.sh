#!/bin/bash
## Script that runs typical workflow when updating site
## Author: Thomas Girke
## Last update: Apr 9, 2017

## (1) Make sure you are in the gh-pages branch
git checkout gh-pages  

## (4) Commit edits made in gh-pages branch 
git add -A :/
git commit -am "some edits"
git push -u origin gh-pages
echo "Committed/pushed changes to gh-pages branch on GitHub"


