
#---------------------------------------------------------------------------------------------------------------
#---------- This code separates the different tiers in the summary_table, change the unit to kgal for everything
#---------------------------------------------------------------------------------------------------------------

rm(list = ls()) #cleaning workspace, rm for remove
#dev.off() #clearing the plots
getwd()

my_packages <- c("rgeos","raster","tidyverse","magrittr","haven","readxl","tools","usethis","RColorBrewer","ggrepel","sf","tictoc","lubridate")
#install.packages(my_packages, repos = "http://cran.rstudio.com")
lapply(my_packages, library, character.only = TRUE)

map<-purrr::map #For the nice iterations
select<-dplyr::select

#All variables capitalized ; values str_to_title ; remove accents from all variables and values

#-----------------------------------------------------------------------------------------------------------------

summary_table <- read_csv("Data/summary_table.csv")

summary_table %<>%
  mutate(tier_starts = str_replace_all(tier_starts, "\n","-")) %>%
  separate(tier_starts,c("tier_0","tier_1","tier_2","tier_3","tier_4","tier_5","tier_6","tier_7","tier_8"),
           sep = "-", remove = FALSE) %>%
  mutate(tier_prices = str_replace_all(tier_prices, "\n","-")) %>%
  separate(tier_prices,c("block_1","block_2","block_3","block_4","block_5","block_6","block_7","block_8"),
           sep = "-", remove = FALSE)


glimpse(summary_table)

summary_table %<>%
  mutate_at(c("tier_1","tier_2","tier_3","tier_4","tier_5","tier_6","tier_7","tier_8"), ~as.numeric(.)) %>%
  mutate_at(c("block_1","block_2","block_3","block_4","block_5","block_6","block_7","block_8"), ~as.numeric(.))


#Convert to kgal
summary_table %<>%
  mutate_at(c("tier_1","tier_2","tier_3","tier_4","tier_5","tier_6","tier_7","tier_8"),
            funs(case_when(bill_unit == 'ccf' ~ .*.748052, 
                           TRUE ~ .))) %>%
  mutate_at(c("block_1","block_2","block_3","block_4","block_5","block_6","block_7","block_8"),
            funs(case_when(bill_unit == 'ccf' ~ .*.748052, 
                           TRUE ~ .)))




summary_table %<>%
  mutate(bill_unit = "converted to kgal")




#Gathering

summary_table %<>%
gather(one_of("tier_1","tier_2","tier_3","tier_4","tier_5","tier_6","tier_7","tier_8"), key = "Tier_number", value = "Tier_threshold") %>%
  gather(one_of("block_1","block_2","block_3","block_4","block_5","block_6","block_7","block_8"), key = "Block_number", value = "Block_price") 


write_csv(summary_table, "Data/summary_table_cleaned.csv")
