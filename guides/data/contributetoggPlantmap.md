
# Contribute to ggPlantmap

## Create your own ggPlantmap!

### Anything you can trace, you can create!

We created a [step-by-step guide with
tips](https://github.com/leonardojo/ggPlantmap/blob/main/guides/TutorialforXMLfile.pdf)
on how to create your own ggPlantmap. With our described method, users
can generate new ggPlantmaps without the necessity of high-resolution
images and advanced coding skills. The ggPlantmap package is an
open-source project, encouraging community contributions and creation of
maps that will be continuously loaded into the package. We encourage
users to extend its functionality to meet specific research requirements
and to better display plant biological data. Its compatibility with R,
one of the most comprehensive programing languages in plant biology,
makes it a versatile and accessible tool for the plant science
community.

## How can my ggPlantmap be included in the package?

<p>
<img src="https://github.com/leonardojo/ggPlantmap/blob/f7f426ecf5ee8f53a4603f125dcde6620c9f9edc/man/figures/hex.png" align="center" height="500"/>
</p>

If you create a new ggPlantmap and want it to be included in the
package, please save your new map as a tab-delimited text file using the
following code:

``` r
library(ggPlantmap)
your.ggPlantmap <- XML.to.ggPlantmap("data/ggPm.sample.xml")
write.table(your.ggPlantmap,"data/ggPm.Species.Tissue.Type.txt",sep="\t",col.names=T)
```

### We then ask you to send this table (<l.jo@uu.nl>) along with the following information:

##### Species:

##### Tissue: (Ex: Root, Leaf, Stem, Seed)

##### Type: (Ex: Cross-section, longitudinal view, diagram, top view)

##### Description: (Short summary of the ggPlantmap, Ex: Cross-section of maturation zone region of Arabidopsis thaliana roots)

##### Layer levels: (Ex: cell types, zones, etc)

##### DOI link to the reference image: (If the map was based on previous published data, we asked that you send the DOI link of the reference image)

##### Author name:

##### Author contact email:

We will test your ggPlantmap and include in the package in future
updates, If you have any suggestions or questions, please feel free to
contact us,

Thank you for your help!

Leonardo Jo (<l.jo@uu.nl>)
