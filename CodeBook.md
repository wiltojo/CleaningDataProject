# Codebook

This explains how the code work and the "ETL"

## Data Set

This is the dataset https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Data Information

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtai

## Steps Required

*Merges the training and the test sets to create one data set.

*Extracts only the measurements on the mean and standard deviation for each measurement. 

*Uses descriptive activity names to name the activities in the data set

*Appropriately labels the data set with descriptive variable names.

*From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

## Code does

*Loads data

*Loads features

*Loads activities

*Get mean

*Get St Dev

*Cook data

*Merge both sets

## Code Logic

*Import the necessary libraries

*Load the data into the following variables
**test_x - Loads the x_test.txt data table into this variable
**test_y - Loads the y_test.txt data table into this variable
**train_x - Loads the x_train.txt data table into this variable 
**train_y - Loads the y_train.txt data table into this variable
**Bind the variables
**As we step through the code base we are loading the labels and activities
**Acquire mean and st dev
**Merge data
