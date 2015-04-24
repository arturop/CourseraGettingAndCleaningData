sanitise <- function(variableName) {
  translationList <- list(
    c("^t(.+)","TimeDomain\\1"),
    c("^f(.+)","FreqDomain\\1"),
    c("Acc(.*)\\-","Accelerometer\\1\\-"),
    c("Gyro(.*)\\-","Gyroscope\\1\\-"),
    c("Mag(.*)\\-","Magnitude\\1\\-"),
    c("(.+)\\-([X|Y|Z])$","\\2Axis\\1"),
    c("(.+)\\-mean\\(\\)(.*)","mean\\1\\2"),
    c("(.+)\\-std\\(\\)(.*)","stdDev\\1\\2"),
    c("(Body)+","Body")
  )
  for(entry in translationList) {
    variableName <- sub(entry[1], entry[2], variableName)
  }
  variableName
}

readFeatures <- function() {
  featurePosition <- c()
  featureName <- c()
  
  featuresFile <- "UCI HAR Dataset\\features.txt"
  con <- file(featuresFile, open = "r")
  
  while(length(line <- readLines(con, n=1)) >0) {
    currentLine <- strsplit(line, " ")
    position <- as.integer(currentLine[[1]][1])
    name <- currentLine[[1]][2]
    regString <- "(mean|std)\\(\\)"
    if((match <- regexpr(regString,name, perl=TRUE)) != -1) {
      featureName <- c(featureName,sanitise(name))
      featurePosition <- c(featurePosition,position)
    }
  }
  close(con)
  list(position=featurePosition, name=featureName)
}

readActivities <- function() {
  activitiesPosition <- c()
  activitiesName <- c()
  activitiesVector <- c()
  
  activitiesFile <- "UCI HAR Dataset\\activity_labels.txt"
  con <- file(activitiesFile, open = "r")
  
  while(length(line <- readLines(con, n=1)) >0) {
    currentLine <- strsplit(line, " ")
    position <- as.integer(currentLine[[1]][1])
    activitiesVector[position] <- currentLine[[1]][2]
  }
  close(con)
  activitiesVector
}

features <- readFeatures()
activities <- readActivities()

xTable <- lapply(c("test","train"), function(file) {
  tempTable <- read.table(paste("UCI HAR Dataset\\", file, "\\X_", file, ".txt", sep=""))
  tempTable <- tempTable[,features$position]
  names(tempTable) <- features$name
  
  subjectTable <- read.table(paste("UCI HAR Dataset\\", file, "\\subject_", file, ".txt", sep=""), col.names="SUBJECT")
  tempTable <- cbind(tempTable, subjectTable)
  
  activitiesTable <- read.table(paste("UCI HAR Dataset\\", file, "\\y_", file, ".txt", sep=""),
                                col.names="ACTIVITY", colClasses = "factor")
  levels(activitiesTable[,1]) <- activities
  tempTable <- cbind(tempTable, activitiesTable)
  
  tempTable
})

tidyTable <- do.call(rbind, xTable[seq(length(xTable))])

resultTable <- aggregate(tidyTable[!names(tidyTable) %in% c("SUBJECT","ACTIVITY")], 
                         list(SUBJECT = tidyTable$SUBJECT, ACTIVITY = tidyTable$ACTIVITY), FUN = "mean")
resultTable <- resultTable[order(resultTable$SUBJECT, resultTable$ACTIVITY),]

write.table(resultTable, file = "UCI HAR Dataset\\tidyAveragedTable.txt", row.names = FALSE)


