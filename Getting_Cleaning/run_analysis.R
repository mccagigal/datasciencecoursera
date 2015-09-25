######################################
# Getting, cleaning and merging Data #
######################################
library(reshape2)

# Download file if it is not 
if (!file.exists( "getdata_projectfiles_UCI HAR Dataset.zip" )){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "getdata_projectfiles_UCI HAR Dataset.zip", method="curl")
}
# Unzip file if the folder is not
if (!file.exists("UCI HAR Dataset")) { 
  unzip("getdata_projectfiles_UCI HAR Dataset.zip") 
}

# Get info from data features
features       <- read.table("UCI HAR Dataset/features.txt")
features[,2]   <- as.character(features[,2])
featuresPos    <- grep(".*mean.*|.*std.*", features[,2])
featuresNam    <- features[featuresPos,2]

# Get training info and  prepare data 
training_sub   <- read.table( "UCI HAR Dataset/train/subject_train.txt" )
training_label <- read.table( "UCI HAR Dataset/train/y_train.txt" )
training_set   <- read.table   ( "UCI HAR Dataset/train/X_train.txt" )
training_set   <- training_set [, featuresPos ]
training        <- cbind( training_sub , training_label , training_set )
colnames(training) <- c( "Subjects" , "Activities" , featuresNam )   

# Get test info and  prepare data
test_sub     <- read.table( "UCI HAR Dataset/test/subject_test.txt" )
test_label   <- read.table( "UCI HAR Dataset/test/y_test.txt" )
test_set     <- read.table( "UCI HAR Dataset/test/X_test.txt" )
test_set     <- test_set [, featuresPos ]
test         <- cbind( test_sub , test_label , test_set )
colnames(test) <- c( "Subjects" , "Activities" , featuresNam )

# Get activity names 
activities     <- read.table("UCI HAR Dataset/activity_labels.txt")
activities[,2] <- as.character(activities[,2])

# Configure data with activity names and factors
training$Activities <- factor( training$Activities , levels = activities[,1], labels = activities[,2])
test$Activities     <- factor( test$Activities , levels = activities[,1], labels = activities[,2])
training$Subjects   <- factor( training$Subjects )
test$Subjects       <- factor( test$Subjects     )

# Final data strucutre
final_data        <- rbind(training, test)

# Data melted
processed_data <- melt(allData, id = c("Subjects", "Activities"))

# Average of data
averaged_data <- dcast(processed_data, Subjects + Activities ~ variable, mean)

# Write averaged 
write.table(averaged_data, "tidy.txt", row.names = FALSE, quote = FALSE)


