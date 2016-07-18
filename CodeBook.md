# Getting and Cleaning Data Project 

## Load libraries
dplyr, data.table

## Download data 
download.files() and unzip() them to your working directory
create a character vector of all of the data files with list.files()

## Import data 
import data with read.table(). the locations of all the files are in the output of list.files().

X contains all of the feature (variable) measurements
y contains the activity corresponding to each measurement
s contains the subject id from which the measurement came


## Merge testing and training sets 
use bind.rows()

## Label data set
setnames() lets you replace any number of names at once
use the names given in the features.txt file. some names might be duplicate and some might be invalid, but we will ignore these anyway.

## Name activities in data set
use gsub() and a fun for() loop 


## Extract measurements on mean and std for each measurement 
match the names with grep(); match the patern "mean|std"

## Create new tidy data set with average of each variable from X_mean_std for each activity and each subject
collect all of the X,y,s together with bind_cols()
create a tidy_data frame that summarizes the data with aggregate()
