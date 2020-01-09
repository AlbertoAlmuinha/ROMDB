#' @title Get OMDB Item Languages
#' @name get_omdb_item_languages
#' @description This function returns a vector with the languages returned by the api (separated by commas).
#' @author Alberto Almuiña
#' @param omdb_id String with the omdb_id for a movie/series.
#' @param API_KEY OMBD Api Key. Default: Get the Api Key from system environment. Use Sys.setenv('API_KEY' = 'XXXXX'). More information in: http://www.omdbapi.com/apikey.aspx
#' @return
#' Return a vector with the languages of a movie/series.
#' @export
#' @examples
#' \dontrun{
#' get_omdb_item_languages(omdb_id = 'tt0120338')
#' }

get_omdb_item_languages<-function(omdb_id, API_KEY = Sys.getenv('API_KEY')){

  info<-get_omdb_item(omdb_id, API_KEY = API_KEY)[[1]] %>% .$language

  languages<-str_split(info, pattern = ',') %>% flatten_chr() %>% str_trim(side = 'both')

  return(languages)

}
