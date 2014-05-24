Getting and Cleaning Data Course Project
=========================

**Scripts:**  
run_analysis.R

**Packages required:**  
plyr

**Function of the script:**  
The script first loads the required plyr package and sets variables for file url, zip file name, and file names. Next it tests if a data directory was previously created. If not it creates one. If the data zip file was not downloaded before, the zip file is fetched and unziped. Next , the training and test data sets are loaded and joined together into a data frame. Activity names, column labels, the activity number vectors for test and traning set and the subject vectors for both data sets are loaded into the work space. To suit the general convention about variable names and factor values, the activity names are converted to lower case and are stripped off special characters. The subject variables of test and training set are joined into a new combined subject object. Next the colnames of the main data frame is named according to the names in the feature file. With a combination of the setdiff and two grep functions the columns in the data frame that contains .mean. and .std. and not .Freq. are retained in the data frame. Next, a subject and an activity column is added the data frame with the activities matching the labels in the activity name vector. The averages of the mean and std columns of each activity type and subject are  calculated by utilising the ddply function of the plyr package. Finally, the column names are converted to lower case and stripped off all special characters. The tidy data frame is written to a csv file.
