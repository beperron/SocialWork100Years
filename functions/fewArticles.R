fewArticles.f <- function(){

    titles <- filter(full.df, attributes == "article")
    journals <- filter(full.df, attributes == "journal")
    year <- filter(full.df, attributes == "pubYear")



    year.journal <- dplyr::intersect(year$articleID, journals$articleID)
    year.journal.titles <- dplyr::intersect(year.journal, titles$articleID)
    full.df <- full.df[full.df$articleID %in% year.journal.titles, ]

    exclusions.2 <- filter(full.df, attributes == "journal") %>%
        group_by(record) %>%
        summarise(N = n()) %>%
        arrange(N)

    fewArticles <<- exclusions.2 %>% filter(N <=20)

    exclusions.2 <- exclusions.2[exclusions.2$N <=20, "record"]
    fewArticles <- exclusions.2$record





    ebsco.remove <- full.df[full.df$record %in% fewArticles, ]
    ebsco.remove <- ebsco.remove[, "articleID"]
    full.df <- full.df[!(full.df$articleID %in% ebsco.remove),]

    author<-filter(full.df, attributes=="author")
    no.author<-filter(author, grepl("authorship|anonymous", record, ignore.case=TRUE))
    no.author.ID<-no.author$articleID
    full.df <<- full.df[!(full.df$articleID %in% no.author.ID),]

}
