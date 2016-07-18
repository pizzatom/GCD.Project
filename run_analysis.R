# Getting and Cleaning Data Project 

## Load libraries
library(dplyr)
library(data.table)

## Download data 

dataPath = "./data"
if(!file.exists(dataPath)){dir.create(dataPath)}
f.url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f.dest<-paste(dataPath,"/project_data.zip",sep="")
download.file(f.url,f.dest,method="curl")    #download zip files
unzip(f.dest, exdir=dataPath)                #extract to ./data directory
# create a character vector of all of the data files
f.files<-list.files(path=paste(dataPath,"/UCI HAR Dataset",sep="bar"),full.names = TRUE, recursive = TRUE)
f.s_test<-f.files[14]
f.X_test<-f.files[15]
f.y_test<-f.files[16]

f.s_train<-f.files[26]
f.X_train<-f.files[27]
f.y_train<-f.files[28]

## Import data 
X_test<-read.table(f.X_test)
y_test<-read.table(f.y_test)
s_test<-read.table(f.s_test)

X_train<-read.table(f.X_train)
y_train<-read.table(f.y_train)
s_train<-read.table(f.s_train)



## Merge testing and training sets 
X<-bind_rows(X_test,X_train)      # each column is a feature
y<-bind_rows(y_test,y_train)      # each point is an activity (numbered 1--6)
s<-bind_rows(s_test,s_train)      # subject identities
  
  
## Label data set
f.features<-f.files[3]                           # feature names for the X data
old_names<-paste0("V",1:dim_X[2])                # old names sequence
new_names<-as.vector(read.table(f.features)$V2)  # these might not be valid names, there might be duplicates
setnames(X,old=old_names,new=new_names)
setnames(y,old="V1",new="Activity")
setnames(s,old="V1",new="Subject")

## Name activities in data set
f.activity_label<-f.files[1]
activity_label<-as.vector(read.table(f.activity_label,stringsAsFactors = TRUE)$V2)
for (i in 1:length(activity_label)){
  y$Activity<-gsub(i,activity_label[i],y$Activity)
}


## Extract measurements on mean and std for each measurement 
mean_std_names<-grep("mean|std",new_names)
X_mean_std<-X[,mean_std_names]


## Create new tidy data set with average of each variable from X_mean_std for each activity and each subject
combined_data<-bind_cols(s,y,X_mean_std)
tidy_data<-aggregate(.~Subject+Activity,combined_data,mean)
