# Data

This directory contains source data and R scripts to transform it into
aggregate form that is easier for Shiny app to work with.

`read-data-sav.R` is obsolete file that was used to load SAV files in sequence
and extract interesting variables into main data frame. It was created
roughly 12 hours before ESS download wizard was made available for general 
public.

`read-data.R` will prepare main data frame. It will extract interesting
variables for all countries and compute aggregate statistics (number of
"yes" for each respondent and then number of respondents in each category).
Output data frame is just over 1000 rows, so it should go easy on RStudio 
servers. If it turns out that data frame is too huge anyway, we might
consider splitting each country into separate file.

`ESS-full-data.zip` is file provided by ESS download wizard. It contains
all source data (answers for selected questions in all countries in all
waves + some metadata, most importantly weights) and codebook. This file
is covered by standard ESS license: you can distribute it, you can't use
it for for-profit purposes, you must cite it, you can't try to hold ESS CST
responsible for any decisions and interpretations made and you must register
your usage in ESS on-line bibliography database.
Data citation:

European Social Survey Cumulative File, ESS 1-5 (2012). Data file edition 1.0.
Norwegian Social Science Data Services, Norway - Data Archive and distributor
of ESS data.
