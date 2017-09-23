

setwd("/path/to/working/directory")

epoch_time <- as.integer(Sys.time())
as.POSIXct(epoch_time, origin="1970-01-01")

lapply(seq(10), function(i) {
  df <- data.frame(
       ID = vapply(seq(50), function(i) sample(seq(15), 1, replace=TRUE), integer(1)),
       GROUP = vapply(seq(50), function(i) sample(LETTERS, 1, replace=TRUE), character(1)),
       DATE = as.POSIXct(vapply(seq(50), function(i) sample(epoch_time, 1, replace=TRUE), integer(1)), origin="1970-01-01"),
       NUM1 = rnorm(50)*100,
       NUM2 = rnorm(50),
       BOOL = vapply(seq(50), function(i) sample(c("TRUE", "FALSE"), 1, replace=TRUE), character(1))
  )
 write.csv(df, paste0("RandomData_R_",i,".csv"))
 return(df)
})


str(df)
