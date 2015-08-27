p <- data$body$person
p$age <- NULL
p$gender <- NULL

id = numeric()
documentId = numeric()
rating = numeric()
tag = character()

for(i in 1:214)
{
    for (k in 1:length(p[[2]][i][[1]]$documentId))
        {
            for(j in 1:length(p[[2]][i][[1]]$tags[k][[1]]))
                {
                    id <- append(id, p[[1]][i])
                    documentId <- append(documentId, p[[2]][i][[1]]$documentId[k])
                    rating <- append(rating, p[[2]][i][[1]]$rating[k])
                    if(is.null(p[[2]][i][[1]]$tags[k][[1]]))
                        tag <- append(tag, NA)
                    else
                        tag <- append(tag, p[[2]][i][[1]]$tags[k][[1]][j])
                }
        }
}

print(length(id))
print(length(documentId))
print(length(rating))
print(length(tag))

r <- data.frame(as.factor(id),
                as.factor(documentId),
                as.integer(rating),
                tolower(tag),
                stringsAsFactors = FALSE)
colnames(r) <- c("id", "documentId", "rating", "tag")
str(r)
person.ratings <- unique(r)
str(person.ratings)

rm(r, p)
rm(i, j, k)

# merge person.ratings and full.profiles
person.ratings <- merge(person.ratings, full.profiles, by="id",
                        incomparables = NA, ALL=TRUE)
str(person.ratings)

# aggregate(rating ~ cluster + tag, data=person.ratings, FUN="mean")
