% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functions.R
\name{ggPlantmap.merge}
\alias{ggPlantmap.merge}
\title{ggPlantmap.merge}
\usage{
ggPlantmap.merge(map, value, id.x, id.y = id.x)
}
\arguments{
\item{value}{The value table you want to combine with the ggPlantmap tibble. For simplicity, it would be better if this value table is pre-processed so the only information within it are the level ids (Ex: ROI.name) and the value column (Ex: A specific gene expression values in all the different level ids).}

\item{id.x}{Character string. The name of the column in your ggPlantmap tibble where you want to match to the value table. IMPORTANT: It is important to write as a character string, so in between quotes #' @param id.x The name of the column in your ggPlantmap tibble where you want to match to the value table (Ex: "ROI.name").}

\item{id.y}{Character string. The name of the column in your value table where you want to match to the ggPlantmap table (Ex: ROI.name). By default, this function will consider that the column names are exactly the same. In this case you don't need to specify id.y. In case of a different column name, you need to specify the column in the value table that correspond to the one in your ggPlantmap. Also as a character string (Ex: "Cell names").}

\item{data}{The ggPlantmap tibble}
}
\value{
A merged tibble with values assigned to specific levels of your ggPlantmap
}
\description{
combine a ggPlantmap with a table that contain quantitative data for specific ROIs of your ggPlantmap.
}
\examples{
ggPlantmap.merge(map=ggPm.At.seed.devseries,value=ggPm.seed.expression.sample,id.x="ROI.name")
}
