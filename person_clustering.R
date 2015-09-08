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

num.profiles <- dim(person)[1]
num.full.profiles <- dim(full.profiles)[1]

## distances <- daisy(full.profiles[4:9])
distances <- daisy(full.profiles[names(person) %in%
                               c("genders", "group", "season", "duration", "trip.type")])

# Hierarchical clustering
clusterPersons <- hclust(distances, method = "ward.D")

# Plot the dendrogram
# plot(clusterPersons, main="User clustering")

full.profiles$cluster <- cutree(clusterPersons, k = 5)
colnames(full.profiles) <- c("id", "location.name", "age", "normalized.age",
                             "gender", "group", "season", "duration", "trip.type",
                             "cluster")

target.users.clusters <- full.profiles[192:194,
                                       colnames(full.profiles) %in%
                                       c("id", "age", "gender", "group",
                                         "season", "duration", "trip.type",
                                         "cluster")]
