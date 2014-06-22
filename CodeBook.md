Run Analysis for cleaning and analysing data

Original description File: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Original data files : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

R script (run_analysis.R) performs the following to clean up the data:

1. Merges the training and test data sets using mergedFile function to create one data set:

    1.1 train/X_train.txt merged with test/X_test.txt to generate resulted file with 10299 x 561 data frame, as in the original description ("Number of Instances: 10299" x "Number of Attributes: 561")

    1.2 train/subject_train.txt merged with test/subject_test.txt to generate resulted data frame with dimension 10299 x 1  with subject IDs,

    1.3 train/y_train.txt merged with test/y_test.txt to generate resulted data frame with dimension 10299 x 1 with activity IDs.

2. Reads file features.txt and extracts only the measurements on the mean and standard deviation for each measurement. Result is a 10299 x 66 data frame since only 66 out of 561 attributes are measurements on the mean and standard deviation. All measurements appear to be floating point numbers in the range (-1, 1).

3. Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set:
    3.1 walking

    3.2 walkingupstairs

    3.3 walkingdownstairs

    3.4 sitting

    3.5 standing

    3.6 laying

4. The script also appropriately labels the data set with descriptive names: all feature names (attributes) and activity names are converted to lower case, underscores and brackets () are removed. Then it merges the 10299x66 data frame containing features with 10299x1 data frames containing activity labels and subject IDs.

The result is saved as tidyData.txt, a 10299x68 data frame such that the first column contains subject IDs, the second column activity names, and the last 66 columns are measurements. Subject IDs are integers between 1 and 30 inclusive. Names of the attributes are similar to the following:

    4.1 tbodyacc-mean-x

    4.2 tbodyacc-mean-y

    4.3 tbodyacc-mean-z

    4.4 tbodyacc-std-x

    4.5 tbodyacc-std-y

    4.6 tbodyacc-std-z

    4.7 tgravityacc-mean-x

    4.8 tgravityacc-mean-y

5. Finally, the script creates a 2nd, independent tidy data set with the average of each measurement for each activity and each subject.
The result is saved as dataSetWithTheAverages.txt, a 180x68 data frame, where as before, the first column contains subject IDs, the second column contains activity names (see below), and then the averages for each of the 66 attributes are in columns 3...68. There are 30 subjects and 6 activities, thus 180 rows in this data set with averages.
