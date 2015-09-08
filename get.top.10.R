
spb.places <- read.csv2('spb.places.csv',
                        sep=',', header = FALSE, stringsAsFactors=FALSE)
colnames(spb.places) <- c("id", "url", "name")

get.top10 <- function(x){
    x <- merge(spb.places, x, by='id', all.y=TRUE)
    x <- x[order(x$rate, decreasing = TRUE),]
    return(x[1:10,c("name", "url")])
}
