


updateJournalList <- read.csv("journalList.csv")


updateJournalList <- within(updateJournalList, quartile <- as.integer(cut(hIndex, quantile(hIndex, probs=0:4/4, na.rm=TRUE), include.lowest=TRUE)))

write.csv(updateJournalList, file = "journalList.csv")
