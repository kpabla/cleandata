# run_analysis.R
# source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# This R script does the following:

# 1. Merges the training and the test sets to create one data set.
mergedFile <- function (file1, file2) {
    d1 <- read.table(file1)
    d2 <- read.table(file2)
    m <- rbind(d1, d2)
}

## merge X files
X <- mergedFile("train/X_train.txt","test/X_test.txt")
##dim(X)

## merge subject files
S <- mergedFile ("train/subject_train.txt", "test/subject_test.txt")
##dim(S)

## merge Y files
Y <- mergedFile ("train/y_train.txt", "test/y_test.txt")
##dim(Y)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
##dim (features)
## extracts indices of good features
goodFeatures <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
## subset X with good features
X <- X[, goodFeatures]
##dim(X)
names(X) <- features[goodFeatures, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))  

# 3. Uses descriptive activity names to name the activities in the data set

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S) <- "subject"
cleaned <- cbind(S, Y, X)
write.table(cleaned, "tidyData.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(S)[,1]
numSubjects = length(unique(S)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
    for (a in 1:numActivities) {
        result[row, 1] = uniqueSubjects[s]
        result[row, 2] = activities[a, 2]
        tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
        result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
        row = row + 1
    }
}
write.table(result, "dataSetWithTheAverages.txt")
