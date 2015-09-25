# Course Project of Getting and Cleaning Data

The objetives asked by the course projects are done by the 'run_analysis.R' script. This script takes the raw data from the web, processes this data and return a 'tidy.txt' file.

## Detailled script explanation

1 - The script 'run_analysis.R' uses the 'reshape2' library for melting and casting functions.

2 - In this first part of the script, the compressed data is downloaded from the server if it is not downloaded yet. After that, the raw data is unzipped, obtaning the "UCI HAR Dataset" folder.

3 - In the next step, the information about the diffrent features is processed. The features related with the measurements on the mean and standard deviation are isolated from the others.

4 - The training data is processed. It is obtained from the files. The desired measurements on the mean and standard deviation are stored and the 'subject' and 'activity' information is added together with the descriptive variable names.

5 - The test data is processed. It is obtained from the files. The desired measurements on the mean and standard deviation are stored and the 'subject' and 'activity' information is added together with the descriptive variable names.   

6 - The real names of the activities are obtained. The number code for the activities in the training and test data is replaced by the real names.

7 - Both training and test data are merged in a 'final_data' structure.

8 - 'final_data' is melted and averaged.

9 - The averaged data is stored in the 'tidy.txt' file.


