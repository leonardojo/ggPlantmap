% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functions.R
\name{ggPlantmap.plot}
\alias{ggPlantmap.plot}
\title{ggPlantmap.plot}
\usage{
ggPlantmap.plot(data, layer = ROI.name, linewidth = 0.5, show.legend = T)
}
\arguments{
\item{data}{The ggPlantmap tibble to be displayed}

\item{layer}{The level in which you want to distinguish the different ROIs. For example ROI.name,ROI.id or any other classifier you determined (Default: ROI.name).}

\item{show.legend}{logical. Should a legend for the levels to be included in the plot? If there are too many levels, legends can overwhelm the image. In this case, change to FALSE (Default: TRUE).}

\item{linewdith}{The line width of the tracing lines of your ggplot (Default = 0.5).}
}
\value{
A ggplot generated map of your ggPlantmap object with colors separated by layers.
}
\description{
create a ggplot sample from a ggPlantmap table object
}
\examples{
ggPlantmap.plot(data=ggPm.At.3weekrosette.topview,layer=ROI.name,linewdith=1,show.legend=T)
}
