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

# Work with Test Data
# Load and cook x and y
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(X_test) = features

# Mean and St Dev for each measure
X_test = X_test[,extract_features]

# Load Labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# Work with Test Data
# Load and cook x and y
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(X_train) = features

# Mean and St Dev for each measure
X_train = X_train[,extract_features]

# Load activity data
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

train_data <- cbind(as.data.table(subject_train), y_train, X_train)

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
