journalArticleFinder.f <- function(journalTitle, keyword = FALSE, 
                                   authorAff = FALSE, abstract = FALSE){
  article.search <- which(full.df$record == journalTitle)
  article.search <- full.df[article.search,]
  article.search.ID <- select(article.search, articleID)
  target.ID <- full.df$articleID %in% article.search.ID$articleID
  journal.article.df <- full.df[target.ID, ]
  journal.article.df <- filter(journal.article.df, attributes == "article")
  journal.article.df <- arrange(journal.article.df, record)
  #if(keyword == TRUE){journal.article.df <- filter(journal.article.df, attributes == "keyWord")}
  #if(authorAff == TRUE){journal.article.df <- filter(journal.article.df, attributes == "authorAff")}
  #if(abstract == TRUE){journal.article.df <- filter(journal.article.df, attributes == "abstract")}
  x.shortened <- gsub(" ", "", journalTitle)
  write.csv(journal.article.df, file = paste0(x.shortened, ".csv"), row.names=F)
}