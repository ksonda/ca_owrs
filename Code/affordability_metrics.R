---------------------------------------------------------------------------------------------------------------
  #---------- This code merges in census data for counts of households by size and income, calculates "resonable
  #---------- levels of consumption by household size, and constructs affordability metrics
  #---------------------------------------------------------------------------------------------------------------

rm(list = ls()) #cleaning workspace, rm for remove
#dev.off() #clearing the plots
getwd()


my_packages <- c("rgeos","raster","tidyverse","magrittr","haven","readxl","tools","usethis","RColorBrewer","ggrepel","sf","tictoc","lubridate","tidycensus")
install.packages(my_packages, repos = "http://cran.rstudio.com")
lapply(my_packages, library, character.only = TRUE)


# read in summary table (wide form)
d <- read_csv("Data/OWRS/summary_table_cleaned_wide_formatv2.csv")
View(d)

# Calculate reasonable consumption: Let's say reasonable consumption is residential consumption in most efficient urban areas in CA 
# e.g. San Francisco, which is 42 gpcd http://www2.pacinst.org/gpcd/map/#)

hh_sizes<-c(1:7) #household sizes in census go from 1 to 7
gpcd<-42 # set gpcd for affordability threshold

d<-crossing(d,hh_sizes)
d%<>%mutate(reasonable_consumption_kgal=(gpcd*hh_sizes*365/12)/1000)


reasonable_consumption_kgal<-(gpcd*hh_sizes*365/12)/1000


#Calculate monthly water bill at each consumption level

volRevCalc<-function(data,vol){
  vol1<-pmax(pmin(vol,tier_0),0)
  vol2<-pmax((pmin(vol-tier_0,tier_1-tier_0)),0)
  vol3<-pmax((pmin(vol-tier_1,tier_2-tier_1)),0)
  vol4<-pmax((pmin(vol-tier_2,tier_3-tier_2)),0)
  vol5<-pmax((pmin(vol-tier_3,tier_4-tier_3)),0)
  vol6<-pmax((pmin(vol-tier_4,tier_5-tier_4)),0)
  vol7<-pmax((pmin(vol-tier_5,tier_6-tier_5)),0)
  vol8<-pmax((pmin(vol-tier_6,tier_7-tier_6)),0)
  vol9<-pmax((pmin(vol-tier_7,tier_8-tier_7)),0)



  
}