rankall <- function(outcome, num = "best") {
    ## Read outcome data
    outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    ## Check that outcome are valid
    # Isolate info and check 
    if      ( outcome == "heart attack" )  {target_info <- outcome_data[,c(2,7,11)]}
    else if ( outcome == "heart failure" ) {target_info <- outcome_data[,c(2,7,17)]}
    else if ( outcome == "pneumonia" )     {target_info <- outcome_data[,c(2,7,23)]}
    else                                   {stop("invalid outcome")}
    # Filter and numeric and order
    target_info     <- target_info[ target_info[ ,3 ] != "Not Available",]
    target_info[,3] <- as.numeric(target_info[,3])
    target_info     <- target_info [ order(target_info[,2]) , ]
    # Get state names
    state_names     <- unique(target_info[,2]) 
    ## For each state, find the hospital of the given rank
    output_hosp <- character(length(state_names)) 
    
    #print ( output )
    
    for ( i in 1:length(state_names) ){
        # Get state info
        state_info <- target_info  [ target_info [,"State"] == state_names[i] ,] 
        # Sort state info
        state_info <- state_info   [ order(state_info[,3],state_info[,1]), ]
        # State result
        hospital <- if      (num == "best")                               { state_info[1,1] }
                    else if (num == "worst")                              { state_info[nrow(state_info),1] }
                    else if ( is.numeric(num) & num <= nrow(state_info) ) { state_info[num,1] }
                    else                                                  {NA}
        output_hosp[i] = hospital
    }
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    output <- data.frame( hospital =  output_hosp , state = state_names )
}


