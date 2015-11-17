#Assn 11

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