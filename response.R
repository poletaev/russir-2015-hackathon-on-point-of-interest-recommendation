con.response.write = file(description = "response.json" , open = "w")

response$groupid = rep("MAD IT", 3)
response$runid = rep("Just another try 2", 3)

response$body$suggestions[[1]] = as.vector(person1[order(person1[,2], decreasing = TRUE),1])
response$body$suggestions[[2]] = as.vector(person2[order(person2[,2], decreasing = TRUE),1])
response$body$suggestions[[3]] = as.vector(person3[order(person3[,2], decreasing = TRUE),1])

stream_out(response, con.response.write, pagesize = 1)

close(con.response.write)
