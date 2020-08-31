##Study design and data processing

###Collection of the raw data
The data are obtained [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The dataset used:

* **README.txt**
* **features_info.txt**: Information about the variables used on feature.
* **features.txt**: List of all features.
* **activity_labels.txt**: Labels for class with activity name.
* **train/X_train.txt**: Training set.
* **train/y_train.txt**: Training labels.
* **train/subject_train.txt**: Subjects who performed the activity for each sample. Range is 1:30.
* **test/X_test.txt**: Test set.
* **test/y_test.txt**: Test labels.
* **test/subject_train.txt**: Subjects who performed the activity for each sample. Range is 1:30.

All data from Inertial Signals are unused.

###Notes on the original (raw) data 
The detailed explanation of the experiments can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

##Creating the tidy datafile

* Download and read all data needed to be used
* Test and training datasets are merged into one data frame.
* Extract only the Mean and SD of all measurements
* Activity labels are placed based on the activity_labels.txt file.
* Summary dataset is written to a file, summaryData.txt.