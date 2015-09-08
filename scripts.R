#install.packages(c('jsonlite', 'plyr'))
library(jsonlite)
con = file(description = "batch_requests_combined.json",open = "r")
data = stream_in(con,pagesize = 1)

tags = vector(mode = "character")
for(i in 1:214)
{
    pref = data$body$person$preferences[[i]]
    for(taglist in pref$tags)
    {
        for(tag in taglist)
        {
            if(tag %in% tags == FALSE)
                tags = append(tags,tag)
        }
    }
}
tags = sort(tags)  #creates cloud of tags(sorted)


places = vector("character")   #creates list of places and their tags
placestags = vector("list")
for(i in 1:214)
{
    pref = data$body$person$preferences[[i]]
    count = 1
    for(place in pref$documentId)
    {
        if(place %in% places == FALSE)
        {
            places = append(places,place)
            placestags[[length(places)]] = pref$tags[[count]]
        }
        else
        {
            id = match(place,places)
            placestags[[id]] = append(placestags[[id]],pref$tags[[count]])
        }
        count=count+1
    }
}
placesinfo = data.frame(id = places,stringsAsFactors = FALSE)
placesinfo$tags = vector("list",4102)  #creates table with both ids and tags

for(i in 1:length(placestags))
{
    if(is.null(placestags[[i]]))
        next
    placestags[[i]] = unique(placestags[[i]])  #filtering unique tags
}

for(i in 1:4100)
{
    if(is.null(placestags[[i]]))
        next
    placesinfo$tags[[i]] = placestags[[i]]  #placing tags along dataframe
}
