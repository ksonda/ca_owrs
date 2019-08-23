summary <- read.csv("Data/OWRS/summary_table.csv")
deliveries <- read.csv("Data/EAR/EAR 2013-2016 DELIVERIES FINAL 06-22-2018.csv")
production1 <- read.csv("Data/EAR/EAR 2013-2016 PRODUCTION FINAL 06-22-2018_1.csv")
production2 <- read.csv("Data/EAR/EAR 2013-2016 PRODUCTION FINAL 06-22-2018_2.csv")
production_all <- rbind(production2, production2)

production_all$PWSID<- as.character(production_all$PWSID)
production_all$PWSID<- gsub(" ", "", production_all$PWSID)

colnames(summary)[2] <- "PWSID"

unique(deliveries$PWSID)
summary_delivery_merged <- merge(summary, deliveries, by="PWSID")

all_merged <- merge(production_all, summary_delivery_merged, by="PWSID")

saveRDS(all_merged, "Data/owrs_ear_merged.rds")
