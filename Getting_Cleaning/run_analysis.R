# Getting, cleaning and merging Data

library(reshape2)

# Get info from data features
features       <- read.table("UCI HAR Dataset/features.txt")
features[,2]   <- as.character(features[,2])
featuresPos    <- grep(".*mean.*|.*std.*", features[,2])
featuresNam    <- features[featuresPos,2]

#training_sub   <- read.table( "UCI HAR Dataset/train/subject_train.txt" )
#training_label <- read.table( "UCI HAR Dataset/train/y_train.txt" )
#training_set   <- read.table   ( "UCI HAR Dataset/train/X_train.txt" )
#training_set   <- training_set [, featuresPos ]
training        <- cbind( training_sub , training_label , training_set )
colnames(training) <- c( "Subjects" , "Activities" , featuresNam )   


#test_sub     <- read.table( "UCI HAR Dataset/test/subject_test.txt" )
#test_label   <- read.table( "UCI HAR Dataset/test/y_test.txt" )
#test_set     <- read.table( "UCI HAR Dataset/test/X_test.txt" )
#test_set     <- test_set [, featuresPos ]
test         <- cbind( test_sub , test_label , test_set )
colnames(test) <- c( "Subjects" , "Activities" , featuresNam )

# Get activity names 
activities     <- read.table("UCI HAR Dataset/activity_labels.txt")
activities[,2] <- as.character(activities[,2])

training$Activities <- factor( training$Activities , levels = activities[,1], labels = activities[,2])
test$Activities     <- factor( test$Activities , levels = activities[,1], labels = activities[,2])

training$Subjects <- factor( training$Subjects )
test$Subjects     <- factor( test$Subjects     )

allData <- rbind(training, test)

allData.melted <- melt(allData, id = c("Subjects", "Activities"))




