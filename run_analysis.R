
#download and unzip file to local directory
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile="FUCI.zip")
unzip(FUCI.zip)

#read in test data
test <- read.table("../gettingdatacoursera/UCI HAR Dataset/test/X_test.txt", header = FALSE)
str(test)
testLabels <- read.table("../gettingdatacoursera/UCI HAR Dataset/test/y_test.txt", header = FALSE)
str(testLabels)

#subject data - add labels
testSubjects <- read.table("../gettingdatacoursera/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
colnames(testSubjects)<- c("Subject")

trainSubjects <- read.table("../gettingdatacoursera/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
colnames(trainSubjects)<- c("Subject")

#repeat for training data
train <- read.table("../gettingdatacoursera/UCI HAR Dataset/train/X_train.txt", header = FALSE)
str(train)
trainLabels <- read.table("../gettingdatacoursera/UCI HAR Dataset/train/y_train.txt", header = FALSE)
str(trainLabels)


#apply column labels to train and test
colnames(test) <- features$V2
colnames(train) <- features$V2

#winnow data
trainPart <- train[, grepl("([Mm]ean|[Ss]td)",features$V2)]
testPart <- test[, grepl("([Mm]ean|[Ss]td)",features$V2)]

#merge training Labels with Activities
trainLabels <- merge(trainLabels, activityLabels, by="V1")
testLabels <- merge(testLabels, activityLabels, by="V1")


#load activity labels and features
activityLabels <- read.table("../gettingdatacoursera/UCI HAR Dataset/activity_labels.txt", header = FALSE)
features <- read.table("../gettingdatacoursera/UCI HAR Dataset/features.txt", header = FALSE)


# review mean and std feature values
features$V2[grep("([Mm]ean|[Ss]td)", features$V2)]

# bind observation label and subject to each row for test and train

trainFull <- cbind(trainLabels[2], trainSubjects, trainPart)
testFull <- cbind(testLabels[2], testSubjects, testPart)

#Combine rows
dataFull <- rbind(trainFull, testFull)

#tidy data column name
colnames(dataFull)[1] <- c("Activity")

#convert Subject to a factor
dataFull$Subject <- factor(dataFull$Subject)

#create melted data set from full data set
#todo fix factors - something is causing them to fold to 40 obs

dataMelt <- melt(dataFull, id=(c("Activity", "Subject")))
dataMeans <- dcast(dataMelt, Activity + Subject ~ variable, mean)

# output data set
write.table(dataMeans, file="tidyDataMeans.txt", sep="\t")

