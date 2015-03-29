#Deletes article records associated with articles that are 3 pages or less  (this can be adjusted below in   ###                                                                               this chunk)
shortArticles.f <- function(){
    pages.df<-filter(full.df, attributes=="pages")
    pages.df$record <- gsub("p", "", pages.df$record)
    pages.df$record <- gsub("ArtID:\\s", "", pages.df$record)
    pages.df$record<-gsub("S", "", pages.df$record)
    pages.df$record <- gsub(" ", "", pages.df$record)
    
    pages.df$record[pages.df$record==1830]<-"173-183"
    pages.df$record[pages.df$record==364] <- 1
    pages.df$record[pages.df$record==216] <- 1
    pages.df$record[pages.df$record==190] <- 1
    pages.df$record[pages.df$record==131] <- 1
    pages.df$record[pages.df$record==183] <- 1
    pages.df$record[pages.df$record==50] <- "533-552"
    pages.df$record[pages.df$record==116] <- "191-207" 
    pages.df$record[pages.df$record==58] <-"58-66"
    pages.df$record[pages.df$record==84] <-"339-355"
       
    dashes<-filter(pages.df, grepl("-", record) )
    dashes$record[dashes$record=="389-314"]<-"289-314"
    dashes$record[dashes$record=="209-2018"]<-"209-218"
    dashes$record[dashes$record=="611-931"]<-"611-631"
    dashes$record[dashes$record=="13-224"]<-"13-24"
    dashes$record[dashes$record=="446-499"]<-"466-499"
    dashes$record[dashes$record=="117-186"]<-"117-129"
    dashes$record[dashes$record=="19-228"]<-"1-2"  #could not verify page numbers, slated for removal
    dashes$record[dashes$record=="1-109"]<-"1-2"  #not an article
    dashes$record[dashes$record=="1-116"]<-"1-2"  #not an article
    dashes$record[dashes$record=="1-172"]<-"1-2"  #not an article
    dashes$record[dashes$record=="1-120"]<-"1-2"  #not an article
    dashes$record[dashes$record=="1-218"]<-"1-2"  #not an article
    dashes$record[dashes$record=="1-98"]<-"1-2"  #not an article
    dashes$record[dashes$record=="1-212"]<-"1-2"  #not an article
    
    splitDash<-strsplit(dashes$record, "-")
    mat  <- matrix(unlist(splitDash), ncol=2, byrow=TRUE)
    mat <- as.data.frame(mat)
    mat$V1[mat$V1==119119]<-119

    mat$V1<- as.character(mat$V1)
    mat$V2<- as.character(mat$V2)

    mat$V1<- as.numeric(mat$V1)
    mat$V2<- as.numeric(mat$V2)
    mat <-mutate(mat, record=V2-V1+1)
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
    
    pages.keep<-filter(pages.df, record>=3)
    pages.keep$record<-as.character(pages.keep$record)
    pages.keep$record<-as.numeric(pages.keep$record)
    
    full.df<-filter(full.df, attributes!="pages")
    full.df<-rbind(full.df, pages.keep)
    full.df<<-full.df


    rm(dashes, splitDash, mat, dashes.df, dashes.ID, pages.df, pages.noDashes)
}
