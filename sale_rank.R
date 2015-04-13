if (!require("plyr")) {
      install.packages("plyr", repos="http://cran.rstudio.com/")
}

library("plyr")

raw_table =read.table("to_order.log", sep=",", stringsAsFactor=FALSE)
colnames(raw_table) <- c("pid","number","cost")

amount <- ddply(raw_table, .(pid), summarise, amount = cost * number)
pid_money <- ddply(amount, .(pid), summarise, money = sum(amount))
rank <- pid_money[with(pid_money, order(-money)), ]

index <- sapply(c(1:20), function(n) sprintf("%02d,", n))
item <- sapply(head(rank$pid,20), function(n) gsub(" ", "0", sprintf("%10s", n)))
write(paste(index,item,sep=""), "output.txt")
