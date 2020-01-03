#' @title Get OMDB Item Languages
#' @name get_omdb_item_languages
#' @description This function returns a vector with the languages returned by the api (separated by commas).
#' @author Alberto Almuiña
#' @param omdb_id String with the omdb_id for a movie/series.
#' @return
#' Return a vector with the languages of a movie/series.
#' @export
#' @examples
#' \dontrun{
#' get_omdb_item_languages(omdb_id = 'tt0120338')
#' }

get_omdb_item_languages<-function(omdb_id){

  info<-get_omdb_item(omdb_id)[[1]] %>% .$language

  languages<-str_split(info, pattern = ',') %>% flatten_chr() %>% str_trim(side = 'both')

  return(languages)

}
