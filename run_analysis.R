# Set Working Directory

#setwd("/media/mydata/Coursera/Data_science/R/Course_3_week_4/UCI_HAR_Dataset")


# 1. Merge the training and the test sets to create one data set

# read train data

subject_train = read.table('./train/subject_train.txt',header=FALSE)
X_train = read.table('./train/X_train.txt',header=FALSE)
Y_train = read.table('./train/y_train.txt',header=FALSE)

# read test data

subject_test <-read.table("./test/subject_test.txt", header=FALSE)
X_test <- read.table("./test/X_test.txt", header=FALSE)
Y_test <- read.table("./test/y_test.txt", header=FALSE)

# Read the feature labels 
features <-read.table("features.txt", header=FALSE, sep=" ")

# naming columns

colnames(features)<-c("nr", "name")
colnames(X_train) <- features[,2]
colnames(X_test) <- features[,2]
colnames(Y_train) <- "activityid"
colnames(Y_test) <- "activityid"

# merging data

merged.subject <- rbind(subject_train, subject_test)
merged.X <- rbind(X_train,X_test)
merged.Y <- rbind(Y_train,Y_test)
colnames(merged.subject) <- c("subject")

Final.data <- cbind(merged.subject,merged.X,merged.Y)

colNames <- colnames(Final.data)

# 2. Extract only the measurements on the mean and standard deviation for each measurement

data_mean_std <- Final.data[,grepl("mean|std|subject|activityid",colNames)]

# 3. Use descriptive activity names to name the activities in the data set

activity_labels <- read.table("activity_labels.txt", header=FALSE, sep=" ")

colnames(activity_labels) <- c("activityid","activityname")

merged.dataset <- merge(x=data_mean_std, y=activity_labels, by="activityid")

# 4. Appropriately labels the data set with descriptive variable names. 
#names(merged.dataset) <- gsub("tBodyAcc-(mean|std)\\(\\)-(.)","Accelerometer-\\2 \\1",names(merged.dataset))
#names(merged.dataset) <- gsub("tBodyGyro-(mean|std)\\(\\)-(.)","Gyroscope-\\2 \\1",names(merged.dataset))

#names(merged.dataset) <- gsub("fBodyAcc-(mean|std)\\(\\)-(.)","Freq Accelerometer-\\2 \\1",names(merged.dataset))
#names(merged.dataset) <- gsub("fBodyGyro-(mean|std)\\(\\)-(.)","Freq Gyroscope-\\2 \\1",names(merged.dataset))

names(merged.dataset)<-gsub("^t", "time", names(merged.dataset))
names(merged.dataset)<-gsub("^f", "frequency", names(merged.dataset))
names(merged.dataset)<-gsub("Acc", "Accelerometer", names(merged.dataset))
names(merged.dataset)<-gsub("Gyro", "Gyroscope", names(merged.dataset))
names(merged.dataset)<-gsub("Mag", "Magnitude", names(merged.dataset))
names(merged.dataset)<-gsub("BodyBody", "Body", names(merged.dataset))

# 5. From the data set in step 4, creates a second, 
# independent tidy data set with the average of each variable for each 
# activity and each subject
library(plyr)

tidy_data_average <- ddply(merged.dataset, c("subject","activityname"), numcolwise(mean))

write.table(tidy_data_average,file="tidydata.txt",row.name=FALSE )
