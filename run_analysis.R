setwd("~/R/getting_and_cleaning_data/Week2/Project_GACD")
library(plyr)
# Set URL and file variables
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipname <- "./data/Projectdataset.zip"
filenametest <- ("./data/UCI HAR Dataset/test/X_test.txt")
filenametrain <- ("./data/UCI HAR Dataset/train/X_train.txt")
#create data directory, fetch data and unzip data
if (!file.exists("data")) {
        dir.create("data")
}
if (!file.exists(zipname)){
        download.file(fileurl, destfile=zipname, mode="wb")
        unzip(zipname, exdir="./data")
        dateDownloaded <- date()
        write(dateDownloaded, file = paste("./data/datedownloaded.txt"))
}
# load data sets into R workspace
data <- rbind(read.table(filenametest),read.table(filenametrain))
features <- read.table("./data//UCI HAR Dataset/features.txt", colClasses=c("integer","character"))[,2]
activitiesnames<- read.table("./data//UCI HAR Dataset/activity_labels.txt", colClasses=c("integer", "character"))[,2]
test_activities <- read.table("./data//UCI HAR Dataset/test/y_test.txt") [,1]
train_activities <- read.table("./data//UCI HAR Dataset/train/y_train.txt") [,1]
test_subject <- read.table("./data//UCI HAR Dataset/test/subject_test.txt") [,1]
train_subject <- read.table("./data//UCI HAR Dataset/train//subject_train.txt") [,1]
#transform activity names to lower case and remove special characters
activitiesnames <- tolower(gsub("_","",activitiesnames))
# join subject lists from two data sets
subject <- c(test_subject,train_subject)
# assign column names
colnames(data)<-features
# discard columns from data frame that do not contain .mean. or .std. but also are not .Freq. values
data <- data[,setdiff(grep(".mean.|.std.", features), grep(".Freq.", features))]
# add column with subject number
data$subject <- subject
# add column with activities from activitiesnames according to the activities number
data$activities <- factor(c(test_activities, train_activities), labels=activitiesnames)
# take average from retained measurement columns according to subject and activity
datamean<- ddply(data, .(subject, activities), function(x) colMeans(x[1:66]))
#transform column names to lower case and remove special characters
colnames(datamean) <- tolower(gsub("(\\(\\))|-","",names(datamean)))
#write tidy dataset to file
write.csv (datamean, file="./data/results.csv")
