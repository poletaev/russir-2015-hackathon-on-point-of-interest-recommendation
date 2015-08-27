tags <- read.csv2('newtags.csv', sep=',', stringsAsFactors=FALSE)

person.ratings <- merge(person.ratings, tags, by.x="tag", by.y="oldtags", all=TRUE)
person.ratings[is.na(person.ratings$newtags),]$newtags <- person.ratings[is.na(person.ratings$newtags),]$tag

str(person.ratings)
