Getting and cleaning data
###Project work----------------------------------------------------------
Goal:- Creating a tidy data set following specified 5 steps.

Files in this repo

README.md -- you are reading it right now
CodeBook.md -- codebook describing variables, the data and transformations
run_analysis.R -- actual R code for analysis

run_analysis.R detailes:-

one R script called run_analysis.R is created that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

It should run in a folder of the Samsung data (the zip had this folder: UCI HAR Dataset)
and script assumes it has the following files and folders in its working directory:

activity_labels.txt
features.txt
test/
train/
The output is created in working directory with the name of tidydata.txt

run_analysis.R walkthrough

It follows the goals step by step.

###Step 1:

Read all the test and training files: y_test.txt, y_train.txt, X_test.txt, x_train, subject_test.txt and subject_train.txt
Combine the files (test and train data sets) to 3 different data frame  after giving name to all coulumn from appropriate files in the form of Subjects, Activity, Features.
then finally, these files are binded columnwise to get desired output data named Data 1 in step 1

###Step 2:

Read the features from features.txt and filter it to only leave features that are either means ("mean()") or standard deviations ("std()"). 
A new data frame named Data2 is then created that includes subjects, activity and the described features.

###Step 3:

Read the activity labels from activity_labels.txt and replace the numbers with the text.


###Step 4:
  
Appropriately labels the data set with descriptive variable names by replacing shortcuts with descriptive name in coulmns of final data set


###Step 5:

Create a new data frame by finding the mean for each combination of subject and label using aggregate() function.
and write the new tidy set in text file called tidy.txt.
