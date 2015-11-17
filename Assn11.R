#Assn 11

library(dplyr)
library(DBI)
library(RSQLite)

#read in data and take care of missing values
mammal_sizes<-read.csv("MOMv3.3.txt",header=FALSE,sep="\t",stringsAsFactors=FALSE,na.strings="-999")

#add column headings
colnames(mammal_sizes) <- c("continent", "status", "order", 
                            "family", "genus", "species", "log_mass", "combined_mass", 
                            "reference")

#calculate mean mass of extinct species
mean_mass_extinct<-mean(mammal_sizes[mammal_sizes$status=="extinct",8],na.rm=TRUE)

#calculate mean mass of extant species
mean_mass_extant<-mean(mammal_sizes[mammal_sizes$status=="extant",8],na.rm=TRUE)

#connect to sql database for further queries
conn<-dbConnect(SQLite(), "msom.sqlite")
dbListTables(conn)
dbListFields(conn,"MOMv3")

#for extinct species
mass_by_continent_extinct<-"SELECT continent, AVG(combined_mass) AS mass_extinct
                    FROM MOMv3 
                    WHERE status='extinct'
                    GROUP BY continent;"
extinct<-dbGetQuery(conn,mass_by_continent_extinct) 

#for extant species
mass_by_continent_extant<-"SELECT continent, AVG(combined_mass) AS mass_extant
                    FROM MOMv3 
                    WHERE status ='extant'
                    GROUP BY  continent;"
extant<-dbGetQuery(conn,mass_by_continent_extant) 

#Merge the two tables above
table_to_export<-merge(extinct,extant,by="continent")

#export to csv
write.csv(table_to_export,file="continent_mass_differences.csv",sep=",",row.names=FALSE)
