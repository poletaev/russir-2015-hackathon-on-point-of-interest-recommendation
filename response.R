person1 = person1 [ order(-person1[,2]), ]
person2 = person2 [ order(-person2[,2]), ]
person3 = person3 [ order(-person3[,2]), ]
con2 = file(description = "sample_batch_response_combined.json",open = "r")
con.request.write = file(description = "request.json" , open = "w")
con.response.write = file(description = "response.json" , open = "w")
response = stream_in(con2,pagesize = 1)
response = response[212:214,]
response$groupid = c("MAD IT","MAD IT","MAD IT")
response$runid = c("Our best try yet 1","Our best try yet 1","Our best try yet 1")

response$body$suggestions[[1]] = as.vector(person1[,1])
response$body$suggestions[[2]] = as.vector(person2[,1])
response$body$suggestions[[3]] = as.vector(person3[,1])
stream_out(request, con.request.write, pagesize = 1)
stream_out(response, con.response.write, pagesize = 1)
close(con.request.write)
close(con.response.write)
close(con2)