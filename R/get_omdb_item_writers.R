#' @title Get OMDB Item Writers
#' @name get_omdb_item_writers
#' @description This function returns a vector with the writers returned by the api (separated by commas).
#' @author Alberto Almuiña
#' @param omdb_id String with the omdb_id for a movie/series.
#' @return
#' Return a vector with the writers of a movie/series.
#' @export
#' @examples
#' \dontrun{
#' get_omdb_item_writers(omdb_id = 'tt0120338')
#' }

get_omdb_item_writers<-function(omdb_id){

  info<-get_omdb_item(omdb_id)[[1]] %>% .$writer

  writers<-str_split(info, pattern = ',') %>% flatten_chr() %>% str_trim(side = 'both')

  return(writers)

}
