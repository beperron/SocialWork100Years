#Deletes article records associated with articles that are 3 pages or less  (this can be adjusted below in   ###                                                                               this chunk)
shortArticles.f <- function(){
    pages.df<-filter(full.df, attributes=="pages")
    pages.df$record <- gsub("p", "", pages.df$record)
    pages.df$record <- gsub("ArtID:\\s", "", pages.df$record)
    pages.df$record<-gsub("S", "", pages.df$record)
    pages.df$record <- gsub(" ", "", pages.df$record)

    dashes<-filter(pages.df, grepl("-", record) )

    splitDash<-strsplit(dashes$record, "-")
    mat  <- matrix(unlist(splitDash), ncol=2, byrow=TRUE)
    mat <- as.data.frame(mat)

    mat$V1<- as.character(mat$V1)
    mat$V2<- as.character(mat$V2)

    mat$V1<- as.numeric(mat$V1)
    mat$V2<- as.numeric(mat$V2)
    mat <-mutate(mat, record=V2-V1)
    mat<-select(mat, record)

    dashes<-select(dashes, -record)
    dashes.df<-cbind(dashes, mat)
    dashes.ID<-dashes.df$articleID

    pages.noDashes<-pages.df[!pages.df$articleID %in% dashes.ID, ]

    pages.df<-rbind(pages.noDashes, dashes.df)
    pages.df$record<-as.numeric(pages.df$record)
    pages.df[is.na(pages.df)] <- 0

    pages.remove<-filter(pages.df, record < 3)    ## Set threshold for retaining articles by number of pages
    pages.remove.ID <- pages.remove$articleID

    full.df <- full.df[!full.df$articleID %in% pages.remove.ID, ]
    rownames(full.df) <- NULL
    full.df <<- full.df


    rm(dashes, splitDash, mat, dashes.df, dashes.ID, pages.df, pages.noDashes)
}
