#' @title Search OMDB Items
#' @name search_omdb_items
#' @description This function searches OMDB Api Items (movies or series) by name, type and year.
#' @author Alberto Almuiña
#' @param movie String of movie/series name
#' @param type Default: 'movie'. Valid options are 'movie' or 'series'.
#' @param year Optional. Year of release.
#' @param page The number of results returned. 1: 10 results, 2: 20 results...
#' @param include_gif If TRUE, the result includes a gif of the movies/series. Default: TRUE.
#' @param API_KEY OMBD Api Key. Default: Get the Api Key from system environment. Use Sys.setenv('API_KEY' = 'XXXXX'). More information in: http://www.omdbapi.com/apikey.aspx
#' @return
#' If include_gif is TRUE, returns a list with a tibble with the movie information and a gif of the films. If include_image is FALSE, only returns the tibble.
#' @export
#' @examples
#' \dontrun{
#' search_omdb_items('Titanic')
#' }

search_omdb_items<-function(movie, type = 'movie', year = NULL, page = 1,
                            include_gif = TRUE, API_KEY = Sys.getenv('API_KEY')){

  type<-match.arg(type, choices = c('movie', 'series'))

  url<-str_glue("http://www.omdbapi.com/?apikey={API_KEY}")

  res<-RETRY('GET', url = url,
             query = list(s = movie,
                          type = type,
                          y = year,
                          page = page,
                          r = 'json'
             ),
             quiet = TRUE) %>% content

  get_request_status(res)

  res<-res$Search

  info<-map_df(seq_len(length(res)), function(this_list){

    iter<-res[[this_list]]

    list(

      title = iter$Title,
      year = iter$Year,
      imdb_id = iter$imdbID,
      type = iter$Type,
      poster = iter$Poster

    )

  })

  if(include_gif){

    images<-image_read(info$poster[info$poster != 'N/A']) %>%
      image_animate(fps = 1, dispose = 'previous')

    return(list(search_df = info, gif = images))

  } else{


    return(info)

  }

}
