#' @title Search OMDB Gif
#' @name search_omdb_gif
#' @description This function searches OMDB Api Items (movies or series) by name, type and year.
#' @author Alberto Almuiña
#' @param movie String of movie/series name
#' @param type Default: 'movie'. Valid options are 'movie' or 'series'.
#' @param year Optional. Year of release.
#' @param page The number of results returned. 1: 10 results, 2: 20 results...
#' @param API_KEY OMBD Api Key. Default: Get the Api Key from system environment. Use Sys.setenv('API_KEY' = 'XXXXX'). More information in: http://www.omdbapi.com/apikey.aspx
#' @return
#' Returns a gif of the movies searched (an image if only one result is returned)
#' @export
#' @examples
#' \dontrun{
#' search_omdb_gif('Titanic')
#' }


search_omdb_gif<-function(movie, type = 'movie', year = NULL, page = 1,API_KEY = Sys.getenv('API_KEY')){

  type<-match.arg(type, choices = c('movie', 'series', 'episode'))

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

      poster = iter$Poster

    )

  })



  gif<-image_read(info$poster[info$poster != 'N/A']) %>%
    image_animate(fps = 1, dispose = 'previous')

  return(gif)

}
