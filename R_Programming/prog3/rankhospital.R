rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    ## Check that state and outcome are valid
    # State info
    state_info   <- outcome_data[ outcome_data[,"State"] == state,]
    if ( nrow(state_info) == 0 ){ stop("invalid state") }
    # Outcome info
    if      ( outcome == "heart attack" )  {target_info <- state_info[,c(2,11)]}
    else if ( outcome == "heart failure" ) {target_info <- state_info[,c(2,17)]}
    else if ( outcome == "pneumonia" )     {target_info <- state_info[,c(2,23)]}
    else                                   {stop("invalid outcome")}
    # Filter and numeric
    target_info     <- target_info[ target_info[ ,2 ] != "Not Available",]
    target_info[,2] <- as.numeric(target_info[,2])
    ## Return hospital name in that state with the given rank
    # sort data
    target_info <- target_info [ order(target_info[,2],target_info[,1]),]
    # Looking for output
    output <- if      (num == "best")                                { target_info[1,1] }
              else if (num == "worst")                               { target_info[nrow(target_info),1] }
              else if ( is.numeric(num) & num <= nrow(target_info) ) { target_info[num,1] }
              else                                                   {NA}
    ## 30-day death rate
    output
}