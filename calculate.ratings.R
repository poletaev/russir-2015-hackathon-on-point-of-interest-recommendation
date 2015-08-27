t<-aggregate(rating ~ newtags + id, data=person.ratings, FUN="mean")
# empty:
print(t[t$id == 1234567,])
# not empty:
print(t[t$id == 1234568,])
print(t[t$id == 1234569,])

tmp<-aggregate(rating ~ newtags + cluster, data=person.ratings, FUN="mean")
r.clusters <- tmp[,c("newtags", "cluster", "rating")]

print(unique(person.ratings[person.ratings$id %in% c(1234567, 1234568, 1234569), c("id", "cluster", "gender", "season", "group")]))

 ## 1234568       3   male autumn friends
 ## 1234569       2 female summer   alone
 ## 1234567       3   male summer friends

# calculate ratings by new class for 1234567 user:
r.1234567 <- r.clusters[r.clusters$cluster == 3, c("newtags", "rating")]

# calculate ratings by new class for 1234568 user:
r.1234568 <- t[t$id == 1234568, c("newtags", "rating")]

# calculate ratings by new class for 1234569 user:
r.1234569 <- t[t$id == 1234569, c("newtags", "rating")]
