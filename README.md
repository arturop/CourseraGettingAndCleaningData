# CourseraGettingAndCleaningData
This repo contains the assignment for the Coursera Getting and Cleaning Data course project

Please observe that in order to run the script, it must reside in the same directory where you unpacked the Samsung data folder. Please observe as well that the script has been written on a Windows environment, hence the paths to access the files conform the Windows syntax.

The script defines and uses 3 functions:

* readFeatures - this function receives no parameters and returns a list containing two vectors, one with the positions of the variables we want to use and the other with the names, already converted to something meaningful along the guidelines of the tidy data approach. This conversion is carried out via the sanitise function (see below). The way this function works is basically read the features.txt file one line at a time, splitting it in the integer representing the position and the variable name. Then it tries to match the variable name to a regex which will select any variables containing mean() or std(). After careful consideration my interpretation of the assignment's requirements is that those are the ones which the writer of the assignment was thinking about. It should be trivial to add others, but as I'm saying I opted for not doing that.

* sanitise - this is a simple function which defines a list of vectors with 2 elements each. Those are the parameters to match and carry out a substitution using sub, which is what the loop does for any variable name it receives as a parameter.

* readActivities - this function is along the lines of readFeatures but simpler. It basically forms a vector by reading the activities labels from the corresponding file and using the numeric value for each activity as the index for the vector

After that the main body of the script does a few things:

* forms xTable by reading both the train and test sets in a loop using lApply. Please observe that xTable is a list containing both the train and test results of the reading process as its elements. For each of them it forms 3 auxiliary tables:
 * tempTable contains the bulk of the data. It reads the whole file and then in a single step it uses the position vector output by readFeatures to keep only the columns we are interested in and after that it also sets the heading row with the names for the variables.
 * subjectTable contains the results of reading the subject file. This is the simplest of the lot as all it has to do is read the file and append it as a column to the corresponding xTable
 * activitiesTable reads the activities from the corresponding file and does a clever transformation enabled by the levels function to translate the numbers for the appropriate labels which we had read into a vector previously using the readActivities function above
 
 Finally a few steps to round it all up:
 
 1. tidyTable is formed by joining the two sets. In order to do this I use rbind with the list of arguments as set up in xTable by using do.call which I find pretty neat
 2. resultTable uses the aggregate function to produce the requested averages grouped by Subject and Activity as per the requirement and then orders it by individual and activity for readability purposes
 3. Finally a call to write.table produces the results
