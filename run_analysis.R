library(data.table)
library(dplyr)

# The source data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip should
# be unzipped in the working directory, this should result in a sub directory with the following name.
directory <- "UCI HAR Dataset"

# This file contains the descriptions for each of the numeric activities in the data files.
activity_labels = read.table(sprintf("%s/activity_labels.txt", directory))[,2]

# This file contains the variable names for each column in the data files.
all_features = read.table(sprintf("%s/features.txt", directory))[,2]

# Extract only the variable names we want to keep. namely those names containing mean( or std(.
required_features = grep("mean\\(|std\\(", all_features)

# This function reads the data for a single category into a data frame, names the columns and
# replaces the numeric activity labels with text descriptions.
read_category <- function(category) {
    # Read the individual samples
    samples = read.table(sprintf("%s/%s/X_%s.txt", directory, category, category))
    # Rename the columns
    names(samples) <- all_features
    # Extract only the columns we want to retain
    samples <- samples[, required_features]
    # Read the subject identifiers that correspond to each row in samples
    subjects = read.table(sprintf("%s/%s/subject_%s.txt", directory, category, category))
    # Read the activity identifiers that correspond to each row in samples
    activities = read.table(sprintf("%s/%s/y_%s.txt", directory, category, category))
    # Join the subject and activity identifiers to the samples
    data_set <- cbind(subjects, activities, samples)
    # Name the subject and activity columns appropriately
    colnames(data_set)[1] <- "subject"
    colnames(data_set)[2] <- "activity"
    # Replace the numeric activity identifiers with text descriptions
    data_set <- as.data.table(data_set)
    data_set[, activity := activity_labels[activity]]
}

# Read the train and test data sets and combine them, then calculate the mean for each subject + activity
tidy <- rbind(read_category("test"), read_category("train")) %>% 
        group_by(subject, activity) %>% 
        summarise_each(funs(mean))

write.txt(tidy, "tidy.txt", row.names = FALSE)

