#read in the file as a dataframe
npt_df <- read.table("NestingPlusTrapping.txt", header=TRUE)

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

  #Left scute marks
  for (j in 1:4){
    #setup new column name
    new_col <- paste0("leftScute", as.character(i))
    #create the new column, fill it with false
    npt_df[[new_col]] <- FALSE

    #look at one legacy col at a time
    legacy_col <- paste0("L",as.character(j))
    #fill in true where appropriate in the new column based on the legacy column
    npt_df[!is.na(npt_df[[legacy_col]]) & npt_df[[legacy_col]]== i , new_col] <- TRUE
  }

  #Right scute marks
  for (j in 1:3){
    #setup new column name
    new_col <- paste0("rightScute", as.character(i))
    #create the new column, fill it with false
    npt_df[[new_col]] <- FALSE

    #look at one legacy col at a time
    legacy_col <- paste0("R",as.character(j))
    #fill in true where appropriate in the new column based on the legacy column
    npt_df[!is.na(npt_df[[legacy_col]]) & npt_df[[legacy_col]]== i , new_col] <- TRUE
  }
}


#write out a new file of the cleaned data
write.table(npt_df, file = "turtlebase_cleaned.csv", sep=",", na="null")
