---
title: 'History of Social Work Research: Data Cleaning'
output: html_document
---

# Overview

This document summarizes data cleaning procedures of the data file processed by the `ebscoBWR` fucntion.  It should be noted that that `ebscoBWR` function merged the search results from the first- and second-level searches performed on the three databases (psycInfo, Social Science Abstracts, and Social Work Abstract) hosted by the EbscoPlatform.  This function merged all the search results, transformed the data into a structured data file, and removed all duplicate article records.  No further transformations or cleaning was performed by the `ebscoBWR` function.  Provided below are basic descriptive summaries of the results from the full search before further cleaning.  It should be noted that the second-level search was specified to be overly inclusive to help ensure the most comprehensive search possible.  All journal titles from the secondary search are identified in the following summary.  

The main file for analysis is `fullDF.R`, and a separate file is just for psycInfo `psycInfoDF.R`.  The same cleaning procedures need to be performed on both data files prior to analysis.  


# Initialization of workspace





























