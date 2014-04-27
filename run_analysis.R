
#download and unzip file to local directory
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile="FUCI.zip")
unzip(FUCI.zip)

#read in test data
test <- read.table("../gettingdatacoursera/UCI HAR Dataset/test/X_test.txt", header = FALSE)

#review information on test
str(test)

testLabels <- read.table("../gettingdatacoursera/UCI HAR Dataset/test/y_test.txt", header = FALSE)
str(testLabels)

#repeat for training data

train <- read.table("../gettingdatacoursera/UCI HAR Dataset/train/X_train.txt", header = FALSE)
str(train)

trainLabels <- read.table("../gettingdatacoursera/UCI HAR Dataset/train/y_train.txt", header = FALSE)
str(trainLabels)


#load activity labels

activityLabels <- read.table("../gettingdatacoursera/UCI HAR Dataset/activity_labels.txt", header = FALSE)

