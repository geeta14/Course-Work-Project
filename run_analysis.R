####RUN_Analaysis-------


#getwd()
#setwd("C:\\gnain\\data_science_project\\3_cleaning Data\\Practice\\project")



###step 1---------------------------------------------------------------------------------------
###reading activity values---
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")


###reading feature files
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")


####reading subject
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")


###Binding data sets by rbind
Features<- rbind(x_train, x_test)
Activity<- rbind(y_train,y_test)
Subject <- rbind(subject_train, subject_test)


###readind features names------
featuresname <- read.table("./UCI HAR Dataset/features.txt")[,2]
View(featuresname)


###set names to variables
names(Subject)<-c("subject")
names(Activity)<- c("activityno")
names(Features)<-c(as.character(featuresname))

###merging data---
dat1 <- cbind(Subject, Activity)
Data1 <- cbind(Features, dat1)  ########Project step1 completed-----Required merged data set is created here.
View(Data1)  ###View data set
str(Data1)
summary(Data1)

#####step 2---------------------------------------------------------------------------------------------------------
##Extracts only the measurements on the mean and standard deviation for each measurement. 
extract_features <- grepl("mean|std", featuresname) #####finding which name of features are having mean or std in their name
View(extract_features)
features_labels<-featuresname[extract_features] #####extract only fetures which have mean or std in their name
View(features_labels)

class(features_labels)

##Subset the data frame Data by seleted names of Features
requiredcolumn<-c("subject", "activityno",as.character(features_labels) )
Data2<-subset(Data1,select=requiredcolumn)  ###### Project step 2 is completed here.

#########################step 3--------------------------------------------------------------
#####Uses descriptive activity names to name the activities in the data set
###reading activity_labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activity_labels)<-c("ID", "activity")
View(Data2$activity) #####checking activitiy in Data
##--------------------------------------------------------------
Data3 <- merge(Data2, activity_labels, by.x="activityno", by.y="ID")
Data3<- Data3[,!(names(Data3) %in% c("activityno"))]   #########project -step 3 is completed here



############step 4----------------------------------------------------------------------------------
####Appropriately labels the data set with descriptive variable names.
####replacing shortcuts with descriptive name in coulmns of final data set
names(Data3)<-gsub("^t", "time", names(Data3))
names(Data3)<-gsub("^f", "frequency", names(Data3))
names(Data3)<-gsub("Acc", "Accelerometer", names(Data3))
names(Data3)<-gsub("Gyro", "Gyroscope", names(Data3))
names(Data3)<-gsub("Mag", "Magnitude", names(Data3))
names(Data3)<-gsub("BodyBody", "Body", names(Data3))
View(Data3)

#############################################################Project -step 4 is completed here

###creates a second, independent tidy data set with the average of each variable for each activity and each subject

library(plyr);
Data.set<-aggregate(. ~subject + activity, Data3, mean)
Data.set<-Data.set[order(Data.set$subject,Data.set$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)  ####3Project -step 5 is completed.

View(Data.set)



