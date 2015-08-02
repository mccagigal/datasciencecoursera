best <- function(state, outcome) {
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
    ## Return hospital name in that state with lowest 30-day death
    target_info     <- target_info[ target_info[ ,2 ] != "Not Available",]
    target_info[,2] <- as.numeric(target_info[,2])
    target_hospital <- target_info [ which.min( target_info[,2] ) , "Hospital.Name" ]
    ## rate
    target_hospital
}