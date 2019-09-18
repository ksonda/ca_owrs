
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

summary_table <- read_csv("Data/OWRS/summary_table.csv")

#Change billing frequency to monthly
unique(summary_table$bill_frequency)

#Going to normalize usage, tier thresholds and total bill by the bill frequency to get in month
summary_table %<>%
  mutate(service_charge = case_when(bill_frequency == "Annually" ~ service_charge/12,
                                    bill_frequency == "Bi-Monthly" | bill_frequency == "Bimonthly" | bill_frequency == "bimonthly" ~ service_charge/2,   
                                    bill_frequency == "Quarterly" ~ service_charge/3,
                                    TRUE ~ service_charge))


summary_table %<>%
  mutate(commodity_charge = case_when(bill_frequency == "Annually" ~ commodity_charge/12,
                          bill_frequency == "Bi-Monthly" | bill_frequency == "Bimonthly" | bill_frequency == "bimonthly" ~ commodity_charge/2,   
                          bill_frequency == "Quarterly" ~ commodity_charge/3,
                          TRUE ~ commodity_charge))

summary_table %<>%
  mutate(bill = case_when(bill_frequency == "Annually" ~ bill/12,
                                    bill_frequency == "Bi-Monthly" | bill_frequency == "Bimonthly" | bill_frequency == "bimonthly" ~ bill/2,   
                                    bill_frequency == "Quarterly" ~ bill/3,
                                    TRUE ~ bill))


summary_table %<>%
  mutate(check = ifelse(signif(service_charge,2)+signif(commodity_charge,2)==signif(bill,2) ,1,0))

summary_table$check #differences are due to OWRS data

summary_table %<>%
  mutate(bill_frequency_update = "Monthly")



#Separating the different tiers
summary_table %<>%
  mutate(tier_starts = str_replace_all(tier_starts, "\n","-")) %>%
  separate(tier_starts,c("tier_0","tier_1","tier_2","tier_3","tier_4","tier_5","tier_6","tier_7","tier_8"),
           sep = "-", remove = FALSE) %>%
  mutate(tier_prices = str_replace_all(tier_prices, "\n","-")) %>%
  separate(tier_prices,c("tier_1_price","tier_2_price","tier_3_price","tier_4_price","tier_5_price","tier_6_price","tier_7_price","tier_8_price"),
           sep = "-", remove = FALSE)


glimpse(summary_table)

summary_table %<>%
  mutate_at(c("tier_1","tier_2","tier_3","tier_4","tier_5","tier_6","tier_7","tier_8"), ~as.numeric(.)) %>%
  mutate_at(c("tier_1_price","tier_2_price","tier_3_price","tier_4_price","tier_5_price","tier_6_price","tier_7_price","tier_8_price"), ~as.numeric(.))

#Convert tiers to correct bill frequency
summary_table %<>%
  mutate_at(c("tier_1","tier_2","tier_3","tier_4","tier_5","tier_6","tier_7","tier_8"), funs(case_when(bill_frequency == "Annually" ~ ./12,
                                                                                                       bill_frequency == "Bi-Monthly" | bill_frequency == "Bimonthly" | bill_frequency == "bimonthly" ~ ./2,   
                                                                                                       bill_frequency == "Quarterly" ~ ./3,
                                                                                                       TRUE ~ .))
            )
    




#Convert everything to kgal
summary_table %<>%
  mutate_at(c("tier_1","tier_2","tier_3","tier_4","tier_5","tier_6","tier_7","tier_8"),
            funs(case_when(bill_unit == 'ccf' ~ .*.748052, 
                           TRUE ~ .))) %>%
  mutate_at(c("tier_1_price","tier_2_price","tier_3_price","tier_4_price","tier_5_price","tier_6_price","tier_7_price","tier_8_price"),
            funs(case_when(bill_unit == 'ccf' ~ .*.748052, 
                           TRUE ~ .)))




summary_table %<>%
  mutate(bill_unit = "converted to kgal")


write_csv(summary_table, "Data/OWRS/summary_table_cleaned_wide_format.csv")



#Gathering to get in long format

summary_table %<>%
gather(one_of("tier_1","tier_2","tier_3","tier_4","tier_5","tier_6","tier_7","tier_8"), key = "Tier_number", value = "Tier_threshold") %>%
  gather(one_of("tier_1_price","tier_2_price","tier_3_price","tier_4_price","tier_5_price","tier_6_price","tier_7_price","tier_8_price"), key = "Block_number", value = "Block_price") 


write_csv(summary_table, "Data/OWRS/summary_table_cleaned.csv")
