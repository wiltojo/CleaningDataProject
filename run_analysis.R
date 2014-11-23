## Create an R script called run_analysis.R that does the following:

if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")

# Load labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Load column names
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Mean and St Dev
extract_features <- grepl("mean|std", features)

# Work with all data
# Load and cook x and y for test and train
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(test_x) = features
names(train_x) = features

# Load Labels & Activities
test_y[,2] = activity_labels[test_y[,1]]
names(test_y) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"
train_y[,2] = activity_labels[train_y[,1]]
names(train_y) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

test_data <- cbind(as.data.table(subject_test), test_y, test_x)
train_data <- cbind(as.data.table(subject_train), train_y, train_x)

# Mean and St Dev for each measure
test_x = test_x[,extract_features]
train_x = train_x[,extract_features]

# Merge data
data = rbind(test_data, train_data)

# Uniformity
id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

# Apply mean
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

#Output table
write.table(tidy_data, file = "./tidy_data.txt")
