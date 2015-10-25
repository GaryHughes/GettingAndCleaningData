library(data.table)
library(dplyr)

directory <- "UCI HAR Dataset"
activity_labels = read.table(sprintf("%s/activity_labels.txt", directory))[,2]
all_features = read.table(sprintf("%s/features.txt", directory))[,2]
required_features = grep("mean\\(|std\\(", all_features)
    
read_category <- function(category) {
    samples = read.table(sprintf("%s/%s/X_%s.txt", directory, category, category))
    names(samples) <- all_features
    samples <- samples[, required_features]
    subjects = read.table(sprintf("%s/%s/subject_%s.txt", directory, category, category))
    activities = read.table(sprintf("%s/%s/y_%s.txt", directory, category, category))
    data_set <- cbind(subjects, activities, samples)
    colnames(data_set)[1] <- "subject"
    colnames(data_set)[2] <- "activity"
    data_set <- as.data.table(data_set)
    data_set[, activity := activity_labels[activity]]
}

# read the train and test data sets and combine them
# calculate the mean for each subject + activity
tidy <- rbind(read_category("test"), read_category("train")) %>% 
        group_by(subject, activity) %>% 
        summarise_each(funs(mean))

write.csv(tidy, "tidy.csv", row.names = FALSE)

