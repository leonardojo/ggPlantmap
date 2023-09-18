
# ggPlantmap <img src="man/figures/hex.png" align="right" height="200"/>

###### Version Beta.1

<!-- badges: start -->
<!-- badges: end -->

## Overview

ggPlantmap is an open-source R package with the goal of facilitating the
generation of informative ggplot maps from plant images to explore
quantitative cell-type specific data. When combined with external
quantitative data, ggPlantmap can be used for the visualization and
displaying of spatial profiles in distinct parts/cells of the plant.

Included in the package there is a set of pre-loaded maps created from
previously published plant images that can be directly inserted into a
ggplot coding workflow. ggPlantmap enables users to plot heatmap
signatures of gene expression or any spatial quantitative data onto
plant images providing a customizable and extensible platform for
visualizing, and analyzing spatial quantitative patterns within specific
plant regions This package uses the flexibility of the well-known
ggplot2 R package to allow users to tailor maps to their specific
research questions.
<img src="man/figures/ggPlantmap.example1.jpg" align="center" height="250"/>

## Installation

``` r
##install devtools (if you haven't already)
install.packages("devtools")
library(devtools)

## Installing from a github respository
install_github("leonardojo/ggPlantmap")
```

## ggPlantmap guides (HIGHLY RECOMMENDED!)

We created a step-by-step [user
guide](https://github.com/leonardojo/ggPlantmap/blob/main/ggPlantmap.userguide.md)
to help users navigate through the package.

We also created a [step-by-step guide with
tips](https://github.com/leonardojo/ggPlantmap/blob/main/Tutorial%20for%20XML%20file.pdf)
on how to create your ggPlantmap.

## What is a ggPlantmap?

Each unique ggPlantmap is a table (tibble) object with points
coordinates (x,y) of specific polygons extracted from plant images.

``` r
library(ggPlantmap)
head(ggPm.At.roottip.longitudinal)
#> # A tibble: 6 × 7
#>   ROI.name    Level1   Level2 ROI.id point     x     y
#>   <chr>       <chr>    <chr>   <int> <int> <dbl> <dbl>
#> 1 Meristem.QC Meristem QC          1     1  121. -323.
#> 2 Meristem.QC Meristem QC          1     2  127. -315.
#> 3 Meristem.QC Meristem QC          1     3  134. -315.
#> 4 Meristem.QC Meristem QC          1     4  149. -318.
#> 5 Meristem.QC Meristem QC          1     5  149. -329.
#> 6 Meristem.QC Meristem QC          1     6  134. -327.
```

<img src="man/figures/guide/Slide6.JPG" align="center" height="500"/>

## Pre-loaded ggPlantmaps

The package contain a series of pre-loaded ggPlantmaps created from
previously published plant images. We hope to update the package with
the contribution of the plant research community.

``` r
library(ggPlantmap)
head(ggPm.summary)
#> # A tibble: 6 × 9
#>   ggPlantmap.name    Species Tissue Type  Descr…¹ Layers Image…² Made.by Conta…³
#>   <chr>              <chr>   <chr>  <chr> <chr>   <chr>  <chr>   <chr>   <chr>  
#> 1 ggPm.At.roottip.c… Arabid… root   cros… Cross-… Cells  https:… Leonar… jo.leo…
#> 2 ggPm.At.roottip.l… Arabid… root   long… Longit… Cells  https:… Leonar… jo.leo…
#> 3 ggPm.At.3weekrose… Arabid… roset… top … Top vi… Leaves https:… Leonar… jo.leo…
#> 4 ggPm.At.leafepide… Arabid… leaf … top … Top vi… Cells  https:… Leonar… jo.leo…
#> 5 ggPm.At.leaf.cros… Arabid… leaves cros… Cross-… Cells  https:… Leonar… jo.leo…
#> 6 ggPm.At.seed.devs… Arabid… seed   deve… Diagra… Cells… https:… Leonar… jo.leo…
#> # … with abbreviated variable names ¹​Description, ²​Image.Reference,
#> #   ³​Contact.Info
```

<img src="man/figures/ggPm.someexamples.jpg" align="center" height="500"/>

## Color mapping

These maps can be easily loaded into a ggplot coding environment and
their color mapping changed based on the distinct layer classification
of each ggPlantmap.

![](man/figures/README-unnamed-chunk-5-1.png)<!-- -->

We created a series of pre-loaded ggPlantmaps

## Overlaying external quantitative data into a ggPlantmap

With ggPlantmap you can overlay quantitative data into your ggPlantmap
to visualize it as sort of a heatmap. To do so, you will need another
table with contains quantitative data attributed to your ROIs.
<img src="man/figures/guide/Slide7.JPG" align="center" width="1200"/><br />
his approach can be very helpful for R Shiny app developers to create
web interactive tools to visualize gene expression gene profiles.

Some examples of heatmaps generated from available published data:
<img src="man/figures/README-Slide2.PNG" align="center" width="1000"/><br />
<img src="man/figures/README-Slide3.PNG" align="center" width="1000"/><br />

## Is ggPlantmap only usefull for molecular expression data?

Not at all. ggPlantmap can also be used to produce many other type of
plots. Essentially anything that you can trace, you can create! Be
creative! We hope to build a community where people explore the usage of
ggPlantmap for the communication of Plant science.

<img src="man/figures/README-Slide4.PNG" align="center" width="1000"/><br />

## How can I create my own ggPlantmap?

The principle of creating a ggPlantmap is fairly simple. We generate a
list of ROIs (region of interests) in the Icy open-source software
(<https://icy.bioimageanalysis.org/>) from any image. These ROIs are
saved as XML files and later be converted into ggPlantmaps with the
XML.to.ggPlantmap() function. [We created step-by-step guide with
tips](https://github.com/leonardojo/ggPlantmap/blob/main/Tutorial%20for%20XML%20file.pdf).
on how to generate xml images from plant images.

<img src="man/figures/README-Slide1.PNG" align="center" width="600"/>

``` r
new.ggPlantmap <- XML.to.ggPlantmap("data/ggPm.sample.xml")
ggPlantmap.plot(new.ggPlantmap,ROI.name)
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="50%" />

## Can my ggPlantmap be included in the package?

YES!!! Any Plant map can be included in the package. If you create one,
please email me (<l.jo@uu.nl>) your ggPlantmap as tab-delimited table
and I’ll make sure to include in the package. You will be credited and
your information will be displayed in the summary file. I really hope
this becomes an organic package with the contribution of the plant
research community.

## Acknowledgements

We would like to acknowledge Kaisa Kajala, Lisa Oskam, Monica Garcia
Gomez, Pierre Gautrat and Kyra van der Velde for testing ggPlantmap. We
also would like to acknowledge Andres Romanowski for providing some data
for the initial tests of ggPlantmap.
