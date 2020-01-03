#' @title Get Request Status
#' @name get_request_status
#' @description This function determines if a OMDB API Request is correct or not.
#' @author Alberto Almuiña
#' @param res OMDB API Request
#' @return
#' Raise an error if the request is not correct.


get_request_status<-function(res){

  if(res$Response != "True"){stop(str_glue('OMDb Request Response was not found'))}

}
