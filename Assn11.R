#Assn 11

#read in data and take care of missing values
mammal_sizes<-read.csv("MOMv3.3.txt",header=FALSE,sep="\t",stringsAsFactors=FALSE,na.strings="-999")

#add column headings
colnames(mammal_sizes) <- c("continent", "status", "order", 
                            "family", "genus", "species", "log_mass", "combined_mass", 
                            "reference")

