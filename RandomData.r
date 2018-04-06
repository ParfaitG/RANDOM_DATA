

setwd("/path/to/working/directory")

epoch_time <- as.integer(Sys.time())
as.POSIXct(epoch_time, origin="1970-01-01")

lapply(seq(10), function(i) {
  df <- data.frame(
       ID = replicate(50, sample(seq(15), 1, replace=TRUE)),
       GROUP = replicate(50, sample(LETTERS, 1, replace=TRUE)),
       DATE = as.POSIXct(replicate(50, sample(epoch_time, 1, replace=TRUE)), origin="1970-01-01"),
       NUM1 = rnorm(50)*100,
       NUM2 = rnorm(50),
       BOOL = replicate(50, sample(c("TRUE", "FALSE"), 1, replace=TRUE))
  )
 write.csv(df, paste0("RandomData_R_",i,".csv"))
 return(df)
})


str(df)
