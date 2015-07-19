corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    ## NOTE: Do not round the result!
    
    output <- numeric()
    
    for ( i in 1:332 ){
        
        file_name <- paste(getwd(),"/",directory,"/",formatC(i, width=3, flag="0"),".csv",sep="")
        from_file <- read.csv( file_name )
        
        counter = 0
        x <- numeric()
        y <- numeric()
        for ( j in 1:nrow(from_file)){
            if( ( !is.na(from_file[j,"sulfate"]) ) & ( !is.na(from_file[j,"nitrate"]) ) ){
                counter = counter+1
                x <- c(x, from_file[j,"sulfate"])
                y <- c(y, from_file[j,"nitrate"])
                
            }
        }
        
        if ( counter >= threshold ){
            output <- c(output , cor(x,y))
        }
    }
    output
        
}
