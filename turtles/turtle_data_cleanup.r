#read in the file as a dataframe
npt_df <- read.table("NestingPlusTrapping_2016update.txt", header=TRUE, stringsAsFactors=FALSE)

#one record has a mixedcase Pm, updating for consistency
npt_df[npt_df$AP == "Pm" & !is.na(npt_df$AP), c("AP")] <- "PM"

#fill in avg AM time for Time with NA, and AP of 'AM'
npt_df$Time[is.na(npt_df$Time) & npt_df$AP=="AM" & !is.na(npt_df$AP)] <- as.integer(round(mean(subset(npt_df, AP=='AM' & !is.na(Time))$Time)))

#fill in avg PM time for Time with NA, and AP of 'PM'
npt_df$Time[is.na(npt_df$Time) & npt_df$AP=="PM" & !is.na(npt_df$AP)] <- as.integer(round(mean(subset(npt_df, AP=='PM' & !is.na(Time))$Time)))

#at time of writing 20160728-09:10 there are still 4026 records with no time or AM/PM indicator
missingampm <- length(npt_df$AP[is.na(npt_df$AP) & is.na(npt_df$Time)])

#modify the layout of scute marks from L1-L4 and R1-R3 to leftScute1-leftScute12 and rightScute1-rightScute12

for (i in  1:12){

  #setup new column name
  new_left_col <- paste0("leftScute", as.character(i))
  #create the new column, fill it with false
  npt_df[[new_left_col]] <- FALSE

  #setup new column name
  new_right_col <- paste0("rightScute", as.character(i))
  #create the new column, fill it with false
  npt_df[[new_right_col]] <- FALSE


  #Left scute marks
  for (j in 1:4){
    #look at one legacy col at a time
    legacy_col <- paste0("L",as.character(j))
    #fill in true where appropriate in the new column based on the legacy column
    npt_df[(!is.na(npt_df[[legacy_col]])) & npt_df[[legacy_col]]== i , new_left_col] <- TRUE
  }

  #Right scute marks
  for (j in 1:3){
    #look at one legacy col at a time
    legacy_col <- paste0("R",as.character(j))
    #fill in true where appropriate in the new column based on the legacy column
    npt_df[!is.na(npt_df[[legacy_col]]) & npt_df[[legacy_col]]== i , new_right_col] <- TRUE
  }
}


#The males are all missing an observation time
#filling with 12PM for now //TODO: talk to Luke
npt_df[is.na(npt_df$Time),] <- "1200"

#npt_df[,"ObservationDateTime"] <- as.POSIXct(paste(npt_df$Date, npt_df$Time), format="%m/%d/%Y %H%M")
npt_df[,"ObservationDateTime"] <- paste(npt_df$Date, npt_df$Time)
#TODO: deal with blank times

#for now (20160901 - per email with Luke), remove all the rows that have no TrueID. Later they need to go in.
npt_df <- npt_df[!is.na(npt_df$TrueID),]


#Use the 'TrueID' column as a unique key to generate new seqential IndividualID
#not using this anymore, but useful example
#npt_df <- transform(npt_df, IndividualID=as.numeric(factor(TrueID)))

#load sqldf library to allow select statements from dataframe
#library(sqldf)
#static_chars_select <- "select IndividualID, Sex, JanzenNum, DateDead, leftScute1 from static_chars group by IndividualID, Sex, JanzenNum, DateDead, leftScute1"

#order the dataframe before writing csv to make sampling for testing easier
#npt_df <- npt_df[order(npt_df[,"IndividualID"]),]

#write out a new file of the cleaned data (this will be used for individual, observation, and dynamic_characteristics)
write.table(npt_df, file = "turtlebase_cleaned_20161018.csv", sep=",", na="null", row.names = FALSE)
