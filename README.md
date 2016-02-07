# ProgrammingAssignment3
Getting and cleanning data course project

The script works in the following way.

First, the script saves the current working directory and creates a new one for saving the works of that Programming Assignment. At the end of the script, the initial working directory is set back. 

The project data is downloaded and saved, the data files are read to a number of data frames, and after performing some inspections (e.g., using the str() function), the training and test sets are merged to create one single data set called 'merged_alldata'.

The variable names of the 'merged_alldata' data frame is read from the 'features.txt' file. The variable names with the character strings "mean()" or "std()" were identified using the grep() function. Then, a new data frame is created containing  only the values of mean and standard deviation for each observation. This new data frame is called 'mean_std_meas'. Note that the first two columns of that data frame contains the subject id and the activity name of each observation.

The activity names are read from the 'activity_labels.txt' file, which is a look‐up table linking IDs with unique activity names (i.e., a vector with activity names ordered according to IDs). Then, the "activity IDs" contained in the column V1.1 of the 'mean_std_meas' data frame is replaced by the corresponding "activity names" by indexing the abovementioned look-up table. 

The column names of the 'mean_std_meas' is labeled with appropriate variable names: The first two variables is labeled as "subject.num" and "activity.name"; The other variables names are changed using the sub() function to avoid especial characters like ‐, and replace the first occurrences of the prefix "t" and "f" by the strings "time" and "frequency", respectively.

The 'mean_std_meas' data frame is copied to a new data frane called 'Xmean_std_meas'. It is important to realize that for each variable (column) in the 'mean_std_meas' data frame, there are several observations for the same subject‐activity pair. A tidy data set should have "one observation per row and one variable per column". Thus, the variable names "Xmean_std_meas$subject.num" and "Xmean_std_meas$activity.name" are converted to factors, the rows of the 'Xmean_std_meas' data frame are reordered (while preserving corresponding order of other columns) using the arrange() function (of the dplyr package), and a new data frame is created by grouping the 'Xmean_std_meas' data frame according to the "subject.num" and "activity.name" variable names using the group_by() function (of the dplyr package). This new data frame is called grouped_dset. 

Last, a new data frame is created using the summarize_each() function (of the dplyr package) to average the columns by group to end with only one observation (the mean in this case) for each subject‐activity pair (30 subjects * 6 activities = 180 observations in total). This new data frame is called 'tidy_dset'.
