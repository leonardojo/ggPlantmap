#' XML.to.ggPlantmap
#'
#' @description Open an Icy generated XML file and extract x and y coordinates of ROIs
#'
#' @param data XML file name (character string; e.g. "arabidopsis.root.crosssection.xml").
#'
#' @return A tibble table with x,y coordinates of individual ROIs (ROI.id) and the name of the ROI (ROI.name)
#' @import dplyr XML
#' @importFrom dplyr tibble
#' @export
#'
#' @examples
#' XML.to.ggPlantmap("ggPm.sample.xml")
XML.to.ggPlantmap <- function(data) {
  xml.ROI <- XML::xmlToList(data)
  final.ROI <- NULL
  for (x in 1:length(xml.ROI)) {
    ROI <- xml.ROI[x]
    for (k in 1:length(ROI$roi$points)) {
      x <- as.numeric(ROI$roi$points[k]$point$pos_x)
      y <- as.numeric(ROI$roi$points[k]$point$pos_y)
      final.ROI2 <- dplyr::tibble(point=k,x=x,y=y*-1,ROI.name=ROI$roi$name,id=ROI$roi$id)
      final.ROI <- rbind(final.ROI,final.ROI2)
    }
  }

  final.ROI3 <-  dplyr::tibble(id = as.numeric(unique(final.ROI$id))) %>%
    dplyr::arrange(id) %>%
    dplyr::mutate(ROI.id = seq(1,length(unique(final.ROI$id)))) %>%
    merge(final.ROI,by="id") %>%
    dplyr::arrange(ROI.id,point) %>%
    dplyr::select(ROI.name,ROI.id,point,x,y)
  dplyr::tibble(final.ROI3)
}

#' ggPlantmap.plot
#'
#' @description create a ggplot sample from a ggPlantmap table object
#'
#' @param data The ggPlantmap tibble to be displayed
#' @param layer The level in which you want to distinguish the different ROIs. For example ROI.name,ROI.id or any other classifier you determined (Default: ROI.name).
#' @param linewdith The line width of the tracing lines of your ggplot (Default = 0.5).
#' @param show.legend logical. Should a legend for the levels to be included in the plot? If there are too many levels, legends can overwhelm the image. In this case, change to FALSE (Default: TRUE).
#' @return A ggplot generated map of your ggPlantmap object with colors separated by layers.
#' @import ggplot2
#' @export
#'
#' @examples
#' ggPlantmap.plot(data=ggPm.At.3weekrosette.topview,layer=ROI.name,linewdith=1,show.legend=T)
ggPlantmap.plot <- function(data,layer=ROI.name,linewidth=0.5,show.legend=T) {
  ggPlantmap <- data
  ggplot(data,aes(x,y)) +
    geom_polygon(aes(group=ROI.id,fill=factor({{layer}})),colour="black",linewidth=linewidth,show.legend={{show.legend}}) +
    theme_void() +
    theme(panel.grid = element_blank(),legend.position="right") +
    coord_fixed()
}

#' ggPlantmap.merge
#'
#' @description combine a ggPlantmap with a table that contain quantitative data for specific ROIs of your ggPlantmap.
#'
#' @param data The ggPlantmap tibble
#' @param value The value table you want to combine with the ggPlantmap tibble. For simplicity, it would be better if this value table is pre-processed so the only information within it are the level ids (Ex: ROI.name) and the value column (Ex: A specific gene expression values in all the different level ids).
#' @param id.x Character string. The name of the column in your ggPlantmap tibble where you want to match to the value table. IMPORTANT: It is important to write as a character string, so in between quotes #' @param id.x The name of the column in your ggPlantmap tibble where you want to match to the value table (Ex: "ROI.name").
#' @param id.y Character string. The name of the column in your value table where you want to match to the ggPlantmap table (Ex: ROI.name). By default, this function will consider that the column names are exactly the same. In this case you don't need to specify id.y. In case of a different column name, you need to specify the column in the value table that correspond to the one in your ggPlantmap. Also as a character string (Ex: "Cell names").
#' @return A merged tibble with values assigned to specific levels of your ggPlantmap
#' @import dplyr
#' @export
#'
#' @examples
#' ggPlantmap.merge(map=ggPm.At.seed.devseries,value=ggPm.seed.expression.sample,id.x="ROI.name")
ggPlantmap.merge <- function(map,value,id.x,id.y=id.x) {
  map %>%
    merge(value,by.x={{id.x}},by.y={{id.y}},all.x=T) %>%
    arrange(ROI.id,point) %>%
    tibble()
}

#' ggPlantmap.heatmap
#'
#' @description produce a heatmap from a ggPlantmap that contains quantitative values for specific ROI levels.
#'
#' @param map.quant The ggPlantmap tibble with quantitative values.
#' @param value.quant The name of the column that contains the quantitative values (Ex: Gene.expression).
#' @param linewdith The line width of the tracing lines of your ggplot (Default = 0.5).
#' @param show.legend logical. Should a legend for the levels to be included in the plot? If there are too many levels, legends can overwhelm the image. In this case, change to FALSE (Default: TRUE).
#' @return A ggplot generated heatmap of your ggPlantmap with colors that depicts the continuous values of your quantitative data. You can integrate this with a ggplot gradient scale (Example: + scale_fill_gradient())
#' @import ggplot2
#' @export
#'
#' @examples
#' quant.data <- ggPlantmap.merge(map=ggPm.At.seed.devseries,value=ggPm.seed.expression.sample,id.x="ROI.name")
#' ggPlantmap.heatmap(map.quant=quant.data,value.quant=AT5G47670.expression,linewdith=1,show.legend=T)
ggPlantmap.heatmap <- function(map.quant,value.quant=value.quant,show.legend=T,linewidth=0.5) {
  ggPlantmap <- map.quant
  ar <- (max(ggPlantmap$y) - min(ggPlantmap$y))/(max(ggPlantmap$x) - min(ggPlantmap$x)) ## recording the aspect ratio of the whole image to adjust it in the final plot.
  ggplot2::ggplot(ggPlantmap, aes(x = x, y = y)) +
    geom_polygon(aes(group=ROI.id,fill={{value.quant}}),colour="black",linewidth=linewidth,show.legend={{show.legend}}) +
    theme_void() +
    theme(panel.grid = element_blank(),legend.position="right") +
    theme(aspect.ratio = ar)
}
