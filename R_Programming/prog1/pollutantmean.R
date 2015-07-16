pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
      
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
      
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    ## NOTE: Do not round the result!
    raw_data <-numeric()
    for ( i in 1:length(id) ){
        file_name <- paste(getwd(),"/",directory,"/",formatC(id[i], width=3, flag="0"),".csv",sep="")
        from_file <- read.csv( file_name )
        raw_data <- c(raw_data,from_file[,pollutant])
    }
    clean_data <- raw_data[!is.na(raw_data)]
    mean(clean_data) 
}