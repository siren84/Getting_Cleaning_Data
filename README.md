Here are the steps one have to perform before running the R script:

    Download the zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    Unzip the file.
    Move the following files to the directory that R script is also located:
        features.txt
        subject_train.txt
        subject_test.txt
        X_train.txt
        X_test.txt
        y_train.txt
        y_test.txt

Once those steps are complete, you can run the R script (run_analysis.R). It requires the plyr library.

The output of the R script is a tidy data set, tidy.txt.
