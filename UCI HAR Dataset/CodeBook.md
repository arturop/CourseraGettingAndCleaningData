## Project Description
This is the codebook corresponding to the Cleaning and Getting Data course project from Coursera.
 
##Study design and data processing
 
###Collection of the raw data
I refer the reader to the file features_info.txt within the distribution
 
###Notes on the original (raw) data 
Some additional notes (if avaialble, otherwise you can leave this section out).
 
##Creating the tidy datafile
 
###Guide to create the tidy data file
I refer the reader to the [Readme.md file](https://github.com/arturop/CourseraGettingAndCleaningData/blob/master/README.md)
 
###Cleaning of the data
Again, please see the Readme file for details. In a nutshell however the script just constructs a list of the variables it wants to use and then loads the different data incorporating additional information like subject and activity in a more descriptive manner.
 
##Description of the variables in the tiny_data.txt file
The file has had all the variables described in the README file sanitised to make the consistent with the tidy data guidelines. Please consult the README file for specific details
The file is made up of 180 observations with 68 variables each. The file incorporates variables to represent the Subject and the Activity corresponding to each observation.
Each observation represents an aggregation (by using the mean) of all the available observations for an specific individual and a specific activity which are quite a few. As I'm saying each line in the tidyAveragedTable file represents the averaging of a number of observations for an individual performing an activity.