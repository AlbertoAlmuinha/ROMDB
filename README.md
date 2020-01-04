
# ROMDB

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)
[![Build Status](https://travis-ci.com/AlbertoAlmuinha/ROMDB.svg?branch=master)](https://travis-ci.com/AlbertoAlmuinha/ROMDB)

R Package to Get Multiple Information from OMDB API (The Open Movie
Database).

# Installation

``` r
devtools::install_github('https://github.com/AlbertoAlmuinha/ROMDB')
```

# Authentication

You need to get your API Key to can use the OMDB API. You can get one
from this [link](http://www.omdbapi.com/apikey.aspx) . Most of the ROMDB
package functions use this Key as a parameter, but the functions are
prepared go get this information from the system environment. It’s
recommendable to use it that way, but you can also use it in each
function manually.

``` r
Sys.setenv('API_KEY' = 'your_api_key')
```

# Usage

## Search an Item

Most of the package functions needs an item ID to run succesfully. For
this reason, we need a mechanism to obtain this items IDs. For this
purpose, we need to use the function **search\_omdb\_items**.

``` r
movies <- ROMDB::search_omdb_items(movie = 'Titanic', type = 'movie', include_gif = FALSE)

head(movies, 5) %>% knitr::kable()
```

| title                        | year | imdb\_id  | type  | poster                                                                                                                               |
| :--------------------------- | :--- | :-------- | :---- | :----------------------------------------------------------------------------------------------------------------------------------- |
| Titanic                      | 1997 | tt0120338 | movie | <https://m.media-amazon.com/images/M/MV5BMDdmZGU3NDQtY2E5My00ZTliLWIzOTUtMTY4ZGI1YjdiNjk3XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg> |
| Titanic II                   | 2010 | tt1640571 | movie | <https://m.media-amazon.com/images/M/MV5BMTMxMjQ1MjA5Ml5BMl5BanBnXkFtZTcwNjIzNjg1Mw@@._V1_SX300.jpg>                                 |
| Titanic: The Legend Goes On… | 2000 | tt0330994 | movie | <https://m.media-amazon.com/images/M/MV5BMTg5MjcxODAwMV5BMl5BanBnXkFtZTcwMTk4OTMwMg@@._V1_SX300.jpg>                                 |
| Titanic                      | 1953 | tt0046435 | movie | <https://m.media-amazon.com/images/M/MV5BMTU3NTUyMTc3Nl5BMl5BanBnXkFtZTgwOTA2MDE3MTE@._V1_SX300.jpg>                                 |
| Raise the Titanic            | 1980 | tt0081400 | movie | <https://m.media-amazon.com/images/M/MV5BM2MyZWYzOTQtMTYzNC00OWIyLWE2NWItMzMwODA0OGQ2ZTRkXkEyXkFqcGdeQXVyMjI4MjA5MzA@._V1_SX300.jpg> |

Note that the parameter ‘include\_gif’ is FALSE (this means that the
final result will be a tibble with all the movies/series information),
but if we choose TRUE, the final result will be a list with the tibble
and a gif with the movies/series posters (if only one item is returned,
then the gif will be an image). We can get only the gif with the
function **search\_omdb\_gif**.

## Get an Item Information

Once we have the required IDs, we can obtain the information about the
item/s. We have two options here: the first one is to use the
**get\_omdb\_item** that applies onlye to one item. The second one is
the **get\_omdb\_several\_items** to get more than one item.

``` r
one_movie <- ROMDB::get_omdb_item(omdb_id = 'tt0120338', include_image = FALSE)

several_movies <- ROMDB::get_omdb_several_items(omdb_ids = movies$imdb_id, include_gif = FALSE)

head(one_movie) %>% kable()
```

| title   | year | rated | released    | runtime | genre          | director      | writer        | actors                                                   | plot                                                                                                                      | language                  | country | awards                                            | poster                                                                                                                               | metascore | imdbRating | imdbVotes | imdbID    | type  | DVD         | boxoffice | production         | website |
| :------ | :--- | :---- | :---------- | :------ | :------------- | :------------ | :------------ | :------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------ | :------------------------ | :------ | :------------------------------------------------ | :----------------------------------------------------------------------------------------------------------------------------------- | :-------- | :--------- | :-------- | :-------- | :---- | :---------- | :-------- | :----------------- | :------ |
| Titanic | 1997 | PG-13 | 19 Dec 1997 | 194 min | Drama, Romance | James Cameron | James Cameron | Leonardo DiCaprio, Kate Winslet, Billy Zane, Kathy Bates | A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic. | English, Swedish, Italian | USA     | Won 11 Oscars. Another 115 wins & 80 nominations. | <https://m.media-amazon.com/images/M/MV5BMDdmZGU3NDQtY2E5My00ZTliLWIzOTUtMTY4ZGI1YjdiNjk3XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg> | 75        | 7.8        | 983,627   | tt0120338 | movie | 10 Sep 2012 | N/A       | Paramount Pictures | N/A     |

``` r
head(several_movies) %>% kable()
```

| title                        | year | rated     | released    | runtime | genre                                       | director                   | writer                                                                                  | actors                                                             | plot                                                                                                                                                                                           | language                         | country           | awards                                            | poster                                                                                                                               | metascore | imdbRating | imdbVotes | imdbID    | type  | DVD         | boxoffice | production                   | website |
| :--------------------------- | :--- | :-------- | :---------- | :------ | :------------------------------------------ | :------------------------- | :-------------------------------------------------------------------------------------- | :----------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------- | :---------------- | :------------------------------------------------ | :----------------------------------------------------------------------------------------------------------------------------------- | :-------- | :--------- | :-------- | :-------- | :---- | :---------- | :-------- | :--------------------------- | :------ |
| Titanic                      | 1997 | PG-13     | 19 Dec 1997 | 194 min | Drama, Romance                              | James Cameron              | James Cameron                                                                           | Leonardo DiCaprio, Kate Winslet, Billy Zane, Kathy Bates           | A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.                                                                      | English, Swedish, Italian        | USA               | Won 11 Oscars. Another 115 wins & 80 nominations. | <https://m.media-amazon.com/images/M/MV5BMDdmZGU3NDQtY2E5My00ZTliLWIzOTUtMTY4ZGI1YjdiNjk3XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg> | 75        | 7.8        | 983,627   | tt0120338 | movie | 10 Sep 2012 | N/A       | Paramount Pictures           | N/A     |
| Titanic II                   | 2010 | Not Rated | 24 Aug 2010 | 90 min  | Action, Adventure, Drama, Romance, Thriller | Shane Van Dyke             | Shane Van Dyke                                                                          | Shane Van Dyke, Marie Westbrook, Bruce Davison, Brooke Burns       | On the 100th anniversary of the original voyage, a modern luxury liner christened “Titanic 2,” follows the path of its namesake. But when a tsunami hurls an iceberg into the new ship’s path… | English                          | USA               | N/A                                               | <https://m.media-amazon.com/images/M/MV5BMTMxMjQ1MjA5Ml5BMl5BanBnXkFtZTcwNjIzNjg1Mw@@._V1_SX300.jpg>                                 | N/A       | 1.6        | 10,161    | tt1640571 | movie | 24 Aug 2010 | N/A       | Metrodome Distribution       | N/A     |
| Titanic: The Legend Goes On… | 2000 | Not Rated | 15 Sep 2000 | 90 min  | Animation, Family, Fantasy, Romance         | Camillo Teti               | Bozenna Intrator (translation), Jymn Magon (consulting writer), Camillo Teti            | Lisa Russo, Mark Thompson-Ashworth, Gisella Mathews, Silva Belton  | A Cinderella meets her Prince Charming on the ill-fated Titanic. Along for the ride are a rapping dog, other talking animals, and an assortment of wacky humans.                               | Italian, English, Polish         | Italy             | N/A                                               | <https://m.media-amazon.com/images/M/MV5BMTg5MjcxODAwMV5BMl5BanBnXkFtZTcwMTk4OTMwMg@@._V1_SX300.jpg>                                 | N/A       | 2.1        | 8,825     | tt0330994 | movie | N/A         | N/A       | N/A                          | N/A     |
| Titanic                      | 1953 | Not Rated | 13 Jul 1953 | 98 min  | Drama, History, Romance                     | Jean Negulesco             | Charles Brackett, Walter Reisch, Richard L. Breen                                       | Clifton Webb, Barbara Stanwyck, Robert Wagner, Audrey Dalton       | An unhappily married couple struggle to deal with their problems while on board the ill-fated ship.                                                                                            | English, Basque, French, Spanish | USA               | Won 1 Oscar. Another 2 nominations.               | <https://m.media-amazon.com/images/M/MV5BMTU3NTUyMTc3Nl5BMl5BanBnXkFtZTgwOTA2MDE3MTE@._V1_SX300.jpg>                                 | N/A       | 7.0        | 5,909     | tt0046435 | movie | 02 Sep 2003 | N/A       | 20th Century Fox             | N/A     |
| Raise the Titanic            | 1980 | PG        | 01 Aug 1980 | 115 min | Action, Drama, Thriller, Adventure          | Jerry Jameson              | Adam Kennedy (screenplay), Eric Hughes (adaptation), Clive Cussler (novel)              | Jason Robards, Richard Jordan, David Selby, Anne Archer            | To obtain a supply of a rare mineral, a ship raising operation is conducted for the only known source, the R.M.S. Titanic.                                                                     | English                          | UK, USA           | 3 nominations.                                    | <https://m.media-amazon.com/images/M/MV5BM2MyZWYzOTQtMTYzNC00OWIyLWE2NWItMzMwODA0OGQ2ZTRkXkEyXkFqcGdeQXVyMjI4MjA5MzA@._V1_SX300.jpg> | N/A       | 4.9        | 3,634     | tt0081400 | movie | 21 Jan 2014 | N/A       | Associated Film Distribution | N/A     |
| The Legend of the Titanic    | 1999 | G         | 17 Apr 1999 | 84 min  | Animation, Family, Fantasy, Romance         | Orlando Corradi, Kim J. Ok | Clelia Castaldo, Orlando Corradi (story), Loris Peota, Ted Rusoff (dialogue adaptation) | Gregory Snegoff, Francis Pardeilhan, Jane Alexander, Anna Mazzotti | A grandfather mouse tells his grandchildren the “real” story of the Titanic disaster, including himself, evil sharks, a giant octopus, and an evil whaling scheme.                             | Italian                          | Italy, USA, Spain | N/A                                               | <https://m.media-amazon.com/images/M/MV5BMjMxNDU5MTk1MV5BMl5BanBnXkFtZTgwMDk5NDUyMTE@._V1_SX300.jpg>                                 | N/A       | 1.8        | 3,222     | tt1623780 | movie | N/A         | N/A       | N/A                          | N/A     |

## Get Detailed Information

We can observe that some fields have the information separated by commas
(director, writer, actors…). We can use some functions to get the
information in a vector.

``` r
ROMDB::get_omdb_item_actors(one_movie$imdbID)
```

    ## [1] "Leonardo DiCaprio" "Kate Winslet"      "Billy Zane"       
    ## [4] "Kathy Bates"

``` r
ROMDB::get_omdb_item_countries(one_movie$imdbID)
```

    ## [1] "USA"

``` r
ROMDB::get_omdb_item_directors(one_movie$imdbID)
```

    ## [1] "James Cameron"

``` r
ROMDB::get_omdb_item_genres(one_movie$imdbID)
```

    ## [1] "Drama"   "Romance"

``` r
ROMDB::get_omdb_item_writers(one_movie$imdbID)
```

    ## [1] "James Cameron"

We can also get the ratings of an item with the next function:

``` r
ROMDB::get_omdb_item_ratings(omdb_id = 'tt0120338')
```

    ## # A tibble: 3 x 2
    ##   Source                  Value 
    ##   <chr>                   <chr> 
    ## 1 Internet Movie Database 7.8/10
    ## 2 Rotten Tomatoes         89%   
    ## 3 Metacritic              75/100

## Item to Database

You can store an item in a database with the **item\_to\_database**
function. Firstly, you need to create a connection with some of the R
packages availables for this purpose (for example, RODBC or DBI). For
example, a connection to SQL Server database could looks like this:

``` r
con <- odbcDriverConnect('driver={SQL Server};
                         server=5CD930199B;
                         database=Example;
                         trusted_connection=true')
```

Once we have the con created, we can store our information in the
database:

``` r
ROMDB::item_to_database(con = con,
                        item = several_movies,
                        dbtable = 'T_SQL_TABLE',
                        append = TRUE)
```

# Issues

If you find some type of error, bug or doubt, please, let me know it
[here](https://github.com/AlbertoAlmuinha/ROMDB/issues) .

# License

ROMDB is licensed under the GNU General Public License v3.0.

> Permissions of this strong copyleft license are conditioned on making
> available complete source code of licensed works and modifications,
> which include larger works using a licensed work, under the same
> license. Copyright and license notices must be preserved. Contributors
> provide an express grant of patent rights.
