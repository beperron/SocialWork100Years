fewArticles.f <- function(){

    titles <- filter(full.df, attributes == "article")
    journals <- filter(full.df, attributes == "journal")
    year <- filter(full.df, attributes == "pubYear")
    
    

    year.journal <- dplyr::intersect(year$articleID, journals$articleID)
    year.journal.titles <- dplyr::intersect(year.journal, titles$articleID)
    full.df <- full.df[full.df$articleID %in% year.journal.titles, ]

    exclusions.2 <- c(
        "Issues in Social Work Education",
        "Maatskaplike Werk/Social Work",
        "Pediatric Social Work",
        "Critical Social Work"
    )

    ebsco.remove <- full.df[full.df$record %in% exclusions.2, ]
    ebsco.remove <- ebsco.remove[, "articleID"]
    full.df <- full.df[!(full.df$articleID %in% ebsco.remove),]
    
    author<-filter(full.df, attributes=="author")
    no.author<-filter(author, grepl("authorship|anonymous", record, ignore.case=TRUE))
    no.author.ID<-no.author$articleID
    full.df <<- full.df[!(full.df$articleID %in% no.author.ID),]
    
}
