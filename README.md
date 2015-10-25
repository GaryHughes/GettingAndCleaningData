## About

The associated script **run_analysis.R** is designed to provide a tidy, derived view of the data located in this [dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

This data is a collection of physical activity of several subjects collected via smartphones. The specifics of this file are described in detail  [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The source data contains two sets of data, train, and test, the **run_analysis.R** script will merge these data sets. It will then extract only the mean and std measurements and calculate averages of these values for each subject and activity. The resultant data set will be written to a file called **tidy.txt** in the same directory as **run_analysis.R**.

## Instructions

Download the [dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) file and unzip it in the same directory as the **run_analysis.R** script.

This should create a directory called **UCI HAR Dataset**.

Execute **run_analysis.R** and it will create an output file called **tidy.txt**, the contents of **tidy.txt** are detailed in **CodeBook.md**.

## Notes

Only explicit mean and std measurements are extracted from the source data, measurements that include mean or std in their names such as meanFreq are not included.

The measurement names and activity labels from the source data are resused with their original formatting even though the meaning of the values has changed, this is intended to make it easier to cross reference the derived data in **tidy.txt** with the original data and its associated documentation.



