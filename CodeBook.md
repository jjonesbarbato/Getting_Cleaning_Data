# Getting_Cleaning_Data CodeBook 
Coursera Getting and Cleaning Data Final Project March 2015

<b>Description</b>

The purpose of this project was to create one tidy dataset from multiple files as defined below.  The five steps noted here were required as part of this project.  

1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

<b>Dataset Description and Source </b>

The dataset used is from data collected using the accelerometers on the Samsung Galaxy S smartphone.  The full desription is available at the following site: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The dataset used for this project is available at: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

<b>Variables </b>

Within the dataset are testing and training files that have three sets of data:

- Subject Files which include an identifier for each subject tested (1 - 30)
- Activity Files which include an identifer for each activity (1 - 6 = Matched with labels in the activity labels text file)
- Measurement Files which include 561 variables that have measurements from the accelerometer and gyroscope within the device. Further information about the variables is included in features_info.txt. 

<b>Transformations</b>

In order to create one tidy dataset multiple transformations were required. 

The plyr and dplyr packages in R were installed for this project and loaded at the begining of the R script. 

First all text files were loaded to data tables and were assigned column names appropriate to the data within the table. 

The test and training files were combined using the "rbind" function for each of the three subsets of data: subject, activity, measurements.  These three subsets were then combined into one dataset that represents all of the test and training data and satisfies the first step in the proejct. 

Next activity descriptions were added as a new column based on the activity labels file and using the unique ActivityId value from each set to match. The "merge" function was used to create this new dataset. This satisfies the second step in the project. 

The column names were then updated to be more descriptive of the values that they contain, this was done using the "gsub" function. 
- The parentheses were removed
- The prefix "t" was replaced with "Time" to indicate that these are Time Domain variables
- The prefix "f" was replaced with "Frequency" to indicate that these are Frequency Domain varaibles
- The value "Acc" was replaced with "Accelerometer" to indicate that measurement was done with the Accelerometer
- The value "Gyro" was replaced with "Gyroscope" to indicate that measurement was done with the Gyroscope
- The value "Mag" was replaced with "Magnitude" to add description to the value
- The term "BodyBody" was replaced with "Body" to simplify the description 

This completed the fourth step in the project. 

Finally the dataset was summarized using the "aggregate" function such that the values left were grouped by Activity ID, Subject ID and Activity Description and represented the means of the values for each combination. 

The tidy dataset was then written to a text file.








