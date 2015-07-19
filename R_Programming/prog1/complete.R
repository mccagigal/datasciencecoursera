complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    
    x <- data.frame(id=1:length(id) , nobs=1:length(id))
    
    for ( i in 1:length(id) ){
        file_name <- paste(getwd(),"/",directory,"/",formatC(id[i], width=3, flag="0"),".csv",sep="")
        from_file <- read.csv( file_name )
        
        counter = 0
        for ( j in 1:nrow(from_file)){
            if( ( !is.na(from_file[j,"sulfate"]) ) & ( !is.na(from_file[j,"nitrate"]) ) ){
                counter = counter+1
            }
        }
        
        x[ i , "id" ] = id[i]
        x[ i , "nobs" ] = counter    
        
    }
    x
}