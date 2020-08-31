library(dplyr)
library(matrixStats)

# Read all the files
xTrain<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
xTest<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
yTrain<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
yTest<-read.table("./data/UCI HAR Dataset/test/y_test.txt")
subjTrain<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subjTest<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")
actLabels<-read.table("./data/UCI HAR Dataset/activity_labels.txt")
features<-read.table("./data/UCI HAR Dataset/features.txt")

# Combine the train files
yTrain <- rename(yTrain, activityLabel=V1)
subjTrain <- rename(subjTrain, Subject=V1)
trainData<-cbind(subjTrain, yTrain, xTrain)

# Combine the test files
yTest <- rename(yTest, activityLabel=V1)
subjTest <- rename(subjTest, Subject=V1)
testData <- cbind(subjTest, yTest, xTest)

# Combine the Train and Test Data sets
actLabels <- rename(actLabels,activityLabel=V1, activityDesc=V2)
mergData <- rbind(trainData,testData)

# Create a vector of column means and SD
mergData <- mutate(mergData, measureMean = rowMeans(mergData[,3:563], na.rm=TRUE))
mergData <- mutate(mergData, measureSD = rowSds(as.matrix(mergData[,3:563]), na.rm=TRUE))

# Extract only the Mean and SD columns of all measurements
extractData <- select(mergData, c(1:2,564:565))

# Create a new group-by group for Activity Description and Subject
newData <- merge(extractData, actLabels, by="activityLabel")
newData <- arrange(newData, activityLabel, Subject)
AcLabel <- group_by(newData, activityDesc, Subject)

# Summarize the data per AcLabel and calculate the Mean per Activity and Subject
summaryData <- summarize(AcLabel, AvMean=mean(measureMean),AvSD=mean(measureSD))

# Write this table to a text file to upload as per instructions
write.table(summaryData, file="summaryData.txt", row.names = FALSE)