#' @title Item to Database
#' @name item_to_database
#' @description This function stores an item into a database table.
#' @author Alberto Almuiña
#' @param con Conecction to some database made with the RODBC package or some other.
#' @param item Tibble returned for some of the functions of the ROMDB package.
#' @param dbtable Name of the database table to insert the results.
#' @param rownames either logical or character. If logical, save the row names as the first column rownames in the table? If character, the column name under which to save the rownames. Default: FALSE
#' @param colnames logical: save column names as the first row of table? Default: FALSE
#' @param append logical. Should data be appended to an existing table? Default: TRUE
#' @export
#' @examples
#' \dontrun{
#' item_to_database(con, tibble_df, 'M_SQL_TABLE')
#' }

item_to_database<-function(con, item, dbtable, rownames = F, colnames = F, append = T){

  sqlSave(con, item, dbtable, rownames = rownames, colnames = colnames, append = append, safer = T)

  odbcClose(con)

}
