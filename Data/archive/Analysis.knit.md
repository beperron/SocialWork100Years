---
title: '100 Years of Social Work Research: A Data Science Perspective'
output: html_document
---

# Data collection


+ Article record retrieval date:  January 8, 2015
Database: PsychInfo and Social Science Index (via EbscoHost Platform) 

+ Search terms:  SO "social work" or SO "social welfare" or SO "social casework" or "social case work" or SO "social service" or "social services" or SO "human service" or SO "human services" or SO "social development" or SO "social environment" 

+ Search limiters:  Publication Type: Peer Reviewed Journal; Document Type: Journal Article

+ Search modes: Boolean/Phrase

+ Search results were exported from EbscoHost Platformon in a _generic bibliographic format_.  This is an unstructured text file (*.txt) that was processed using in R.  

+ EbscoHost full journal listing retrieval date:  January 11, 2015 (http://www.ebscohost.com/title-lists)

# Data Pre-Processing

```r
# Clear workspace
rm(list=ls())

# Read BWR functions for Mac OS
source("/Users/beperron/Git/BibWrangleR/functions/piWrangleR.R")
source("/Users/beperron/Git/BibWrangleR/functions/packages.R")
# Set the path where original raw data are stored
setwd("/Users/beperron/Git/SocialWorkResearch/Data")

# Set the working directory to store files created by BWR functions
path <- "/Users/beperron/Git/SocialWorkResearch/Data"

# Wrangle the data with the BWR function suite
#piBWR.f(csv=FALSE, path=path)
#save(pi.df, file = "piArticles.R")
```













