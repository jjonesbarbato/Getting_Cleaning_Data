#Getting and Cleaning Data Final Project
library(plyr); library(dplyr)

#Requirement is that the working directory must be set to where the unzipped files are located
#Descriptions for each file are based on information found in the README.txt file
#Read in all Data Files to variables for easy combination 

####Features and Activity Label Information####
features<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")

####Training Data####
x_train<-read.table("train\\X_train.txt")
colnames(x_train)<-features[,2]

y_train<-read.table("train\\y_train.txt")
colnames(y_train)<-"ActivityId"

subject_train<-read.table("train\\subject_train.txt")
colnames(subject_train)<-"SubjectId"

####Test Data####
x_test<-read.table("test\\X_test.txt")
colnames(x_test)<-features[,2]

y_test<-read.table("test\\y_test.txt")
colnames(y_test)<-"ActivityId"

subject_test<-read.table("test\\subject_test.txt")
colnames(subject_test)<-"SubjectId"

#Combine x_ files and assign columns names based on features table
x_combined<-rbind(x_train, x_test)
colnames(x_combined)<-features[,2]

#Combine y_ files and assign column name of Activity ID which represents the data in the file
y_combined<-rbind(y_train, y_test)
colnames(y_combined)<-"ActivityId"

#Combine subject_files and assign column name of Subject ID which represents the data in the file 
subject_combined<-rbind(subject_train, subject_test)
colnames(subject_combined)<-"SubjectId"


#Create one combined dataset for the testing and training data that has columns for the measurements
#as well as the activity and subjects

dataset_1<-cbind(subject_combined, y_combined, x_combined)
###STEP 1 COMPLETED - COMBINED DATA SET CREATED####

#Extract only those columns which are measurements of mean or standard deviation 
feature_cols<-grep("-(mean|std)\\(\\)", features[, 2])
#Becase we added two columns to the x_ datasets for subject and activity we need to add 2 to the column values 
#for subsetting
subset_cols<-feature_cols + 2
subset_features<-dataset_1[, subset_cols]
dataset_2<-cbind(dataset_1[,1:2], subset_features)

###STEP 2 COMPLETED - COMBINED DATA SET ONLY HAS COLUMNS FOR MEAN AND STD DEVIATION MEASUREMENTS####

#Next we will add activity labels to the dataset based on the Activity_ID columns
#Rename the columns in the activity_labels dataset 
colnames(activity_labels)<-c("ActivityId", "ActivityDesc")

#Combine the activity description as a new column based on the matching values for ActivityID
dataset_3<-merge(dataset_2, activity_labels, by.x="ActivityId", by.y="ActivityId")

####STEP 3 COMPLETED - COLUMN IN DATASET HAS ACTIVITY DESCRIPTIONS FOR EACH RECORD ####

#Change labels within the features columsnt to be more desriptive
#Items to change include removal of parentheses
names(dataset_3) = gsub("\\()","",names(dataset_3))
#Update names for the specific domain (time and frequency)
names(dataset_3) <- gsub('^t',"Time.",names(dataset_3))
names(dataset_3) <- gsub('^f',"Frequency.",names(dataset_3))
#Update names to indicate the tool used for measurement (Accelerometer and Gyroscope)
names(dataset_3)<-gsub("Acc", "Accelerometer", names(dataset_3))
names(dataset_3)<-gsub("Gyro", "Gyroscope", names(dataset_3))
#Update names for Magnitude
names(dataset_3)<-gsub("Mag", "Magnitude", names(dataset_3))
#Update names to replace double "body" 
names(dataset_3)<-gsub("BodyBody", "Body", names(dataset_3))

####STEP 4 COMPLETED - COLUMN IN DATASET HAS DESCRIPTIVE VARIABLE NAME####
#Create a tidy dataset grouped by subject and activity with the mean for each column variable 
tidydata<-aggregate(. ~SubjectId + ActivityId + ActivityDesc, dataset_3, mean)
#Write out text file for attachment to final project 
write.table(tidydata, file = "tidydata.txt", row.name=FALSE)
####STEP 5 COMPLETED - WRITE THE TIDY DATASET OUT TO A TEXT FILE####

