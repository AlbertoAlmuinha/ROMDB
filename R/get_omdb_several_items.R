#' @title Get OMDB Several Items
#' @name get_omdb_several_items
#' @description This function searches OMDB Movies/Series by ID.
#' @author Alberto Almuiña
#' @param omdb_ids Vector with the omdb_ids for selected movies/series. All the IDs must be the same type (movie or series).
#' @param include_gif If TRUE, the result includes a gif of the movies/series. Default: TRUE.
#' @param API_KEY OMBD Api Key. Default: Get the Api Key from system environment. Use Sys.setenv('API_KEY' = 'XXXXX'). More information in: http://www.omdbapi.com/apikey.aspx
#' @return
#' If include_gif is TRUE, returns a list with a tibble with the movie information and a gif of the films. If include_image is FALSE, only returns the tibble.
#' @export
#' @examples
#' \dontrun{
#' get_omdb_several_items(odmb_ids = search_omdb_items('Titanic', include_gif = F) %>% .$imdb_id)
#' }


get_omdb_several_items<-function(omdb_ids, include_gif = TRUE, API_KEY = Sys.getenv('API_KEY')){

  url<-str_glue("http://www.omdbapi.com/?apikey={API_KEY}")

  res<-lmap(seq(length(omdb_ids)), function(movie){

    RETRY('GET', url = url,
          query = list(i = omdb_ids[movie],
                       r = 'json'
          ),
          quiet = TRUE) %>% content %>% list()

  })

  info<-map_df(seq(length(res)), function(this_list){

    movie<-res[[this_list]]

    switch(movie$Type,
           movie = list(

             title = movie$Title,
             year = movie$Year,
             rated = movie$Rated,
             released = movie$Released,
             runtime = movie$Runtime,
             genre = movie$Genre,
             director = movie$Director,
             writer = movie$Writer,
             actors = movie$Actors,
             plot = movie$Plot,
             language = movie$Language,
             country = movie$Country,
             awards = movie$Awards,
             poster = movie$Poster,
             metascore = movie$Metascore,
             imdbRating = movie$imdbRating,
             imdbVotes = movie$imdbVotes,
             imdbID = movie$imdbID,
             type = movie$Type,
             DVD = movie$DVD,
             boxoffice = movie$BoxOffice,
             production = movie$Production,
             website = movie$Website

           ),

           series = list(

             title = movie$Title,
             year = movie$Year,
             rated = movie$Rated,
             released = movie$Released,
             runtime = movie$Runtime,
             genre = movie$Genre,
             director = movie$Director,
             writer = movie$Writer,
             actors = movie$Actors,
             plot = movie$Plot,
             language = movie$Language,
             country = movie$Country,
             awards = movie$Awards,
             poster = movie$Poster,
             metascore = movie$Metascore,
             imdbRating = movie$imdbRating,
             imdbVotes = movie$imdbVotes,
             imdbID = movie$imdbID,
             type = movie$Type,
             total_seasons = movie$totalSeasons

           )

    )


  })

  if(include_gif){


    gif<-image_read(info$poster[info$poster != 'N/A']) %>%
      image_animate(fps = 1, dispose = 'previous')

    return(list(omdb_df = info, gif = gif))

  } else{

    return(info)

  }


}
