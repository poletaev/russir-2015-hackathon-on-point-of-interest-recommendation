library(cluster)

genders <- tolower(data$body$person$gender)
genders[genders == "f"] = "female"

person <- data.frame(data$body$person$id)
person$location.name <- tolower(data$body$location[,5])
person$age <- as.integer(data$body$person$age)
person$normalized.age <- apply(person[3], 2,
                               function(x, na.rm){(x - mean(x, na.rm=na.rm))/mad(x, na.rm=na.rm)}, na.rm=TRUE)[,1]
person$gender <- as.factor(genders)
person$group <- as.factor(tolower(data$body$group))
person$season <- as.factor(tolower(data$body$season))
person$duration <- as.factor(tolower(data$body$duration))
person$trip.type <- as.factor(tolower(data$body$trip_type))

full.profiles <- person[complete.cases(person),]
## full.profiles <- full.profiles[names(person) %in%
##                                c("genders", "normalized.age", "group", "season", "duration", "trip.type")]


distances <- daisy(full.profiles[4:9])

# Hierarchical clustering
clusterPersons <- hclust(distances, method = "ward.D")

# Plot the dendrogram
plot(clusterPersons)

full.profiles$cluster <- cutree(clusterPersons, k = 5)

print(full.profiles[192:194, c(2,3,10)])
