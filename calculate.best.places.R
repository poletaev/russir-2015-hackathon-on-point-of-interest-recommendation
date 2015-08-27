#calculate best places
spbtags = read.table(file = "spb_places", header = FALSE, sep = ":",as.is = TRUE)
person1 = data.frame(id = response$body$suggestion[[2]],rate = 0,stringsAsFactors = FALSE)
person2 = data.frame(id = response$body$suggestion[[2]],rate = 0,stringsAsFactors = FALSE)
person3 = data.frame(id = response$body$suggestion[[2]],rate = 0,stringsAsFactors = FALSE)

count = 0
last = spbtags[1,1]
current.id = 1
for(i in 1:204)
{
    if(last!=spbtags[i,1])
    {
        person1[current.id,2] = person1[current.id,2]/count
        person2[current.id,2] = person2[current.id,2]/count
        person3[current.id,2] = person3[current.id,2]/count
        count = 1
        current.id = current.id+1
        last = spbtags[i,1]
    }
    else
    {
        count = count+1
    }
    tag.for1 = which(r.1234567[,1]==spbtags[i,2])
    tag.for2 = which(r.1234568[,1]==spbtags[i,2])
    tag.for3 = which(r.1234569[,1]==spbtags[i,2])
    if(length(tag.for1>0))
        person1[current.id,2] = person1[current.id,2] + r.1234567[tag.for1,2]
    if(length(tag.for2>0))
        person2[current.id,2] = person2[current.id,2] + r.1234568[tag.for2,2]
    if(length(tag.for3>0))
        person3[current.id,2] = person3[current.id,2] + r.1234569[tag.for3,2]
    
}