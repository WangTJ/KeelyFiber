# scripts written for z=1 50um Dataset.

library(readxl)
TACS3 <- read_excel("Trentham - Is TACS-3 there.xlsx")
colnames(TACS3) <- c("pid", "sid" , "TN" , "TACS3")
TACS3 <- data.frame(TACS3)
TACS3$TACS3[is.na(TACS3$TACS3)] = "N"

library(stringi)
library(stringr)
fibfilelist <- system("ls *fibFeatures.csv", intern = TRUE)

# Initialization
library(dplyr)

# get fiber
z150umData <- data.frame()
for (i in 1:length(fibfilelist))
{
  TN <- ifelse(str_detect(fibfilelist[i] , "normal"), "N" , "T")
  if (TN=="N")
  {
    pid = as.numeric( strsplit(fibfilelist[i], " ")[[1]][2] )
    sid = as.numeric( substr(strsplit(fibfilelist[i], " ")[[1]][3] ,2,3) )
  } else
  {
    pid = as.numeric( strsplit(fibfilelist[i], " ")[[1]][1] )
    sid = as.numeric( substr(strsplit(fibfilelist[i], " ")[[1]][2] ,2,3) )
  }
  raw <- read.csv(fibfilelist[i] , header=FALSE)
  raw <- raw[,1:28]
  colnames(raw) <- c("fid", "epr", "epc" , "faa", "fw" , "tl" , "eel" , "c" , "w" , "dn2" , "dn4" , 
                    "dn8" , "dn16" , "mnd" , "sdnd" , "bd32" , "bd64" , "bd128" , "an2" , "an4" , 
                    "an8" , "an16" , "mna" , "sdna" , "ba32" , "ba64" , "ba128", "ndb")
  raw <- data.frame(pid,sid,TN,raw)
  z150umData <- rbind(z150umData , raw)
  print(i)
}

# get pixels

pix <- data.frame(read_excel("DCIS.xlsx", sheet = "CAcombined", range = cell_cols("B")) , read_excel("DCIS.xlsx", sheet = "CAcombined", range = cell_cols("AS:AU")))
pix <- select(mutate(pix ,
                     pid = sapply(image.label,function(x) as.numeric( strsplit(x, " ")[[1]][1] )),
                     sid = sapply(image.label,function(x) as.numeric( substr(strsplit(x, " ")[[1]][2] ,2,3) )),
                     TN = "T"),
              pid, sid , TN , red.pixels , yellow.pixels , green.pixels)

pix2 <- data.frame(read_excel("normal.xlsx", sheet = "CAcombined", range = cell_cols("B")) , read_excel("normal.xlsx", sheet = "CAcombined", range = cell_cols("AS:AU")))
pix2 <- select(mutate(pix2 ,
                     pid = sapply(image.label,function(x) as.numeric( strsplit(x, " ")[[1]][2] )),
                     sid = sapply(image.label,function(x) as.numeric( substr(strsplit(x, " ")[[1]][3] ,2,3) )),
                     TN = "N"),
              pid, sid , TN , red.pixels , yellow.pixels , green.pixels)
pix <- rbind(pix,pix2)

TACS3<- left_join(TACS3, pix)

z150umData <- left_join(z150umData, TACS3 ,by= c("pid", "sid" , "TN"))

# get AB data
ABfilelist <- system("ls *values.csv", intern = TRUE)
ABz150umData <- data.frame()
for (i in 1:length(ABfilelist))
{
  TN <- ifelse(str_detect(ABfilelist[i] , "normal"), "N" , "T")
  if (TN=="N")
  {
    pid = as.numeric( strsplit(ABfilelist[i], " ")[[1]][2] )
    sid = as.numeric( substr(strsplit(ABfilelist[i], " ")[[1]][3] ,2,3) )
  } else
  {
    pid = as.numeric( strsplit(ABfilelist[i], " ")[[1]][1] )
    sid = as.numeric( substr(strsplit(ABfilelist[i], " ")[[1]][2] ,2,3) )
  }
  raw <- read.csv(ABfilelist[i] , header=FALSE)
  raw <- raw[,1]
  raw <- data.frame(pid,sid,TN,AB=raw)
  ABz150umData <- rbind(ABz150umData , raw)
  print(i)
}



save(RawData=z150umData, ABData=ABz150umData, file = "z150umData.Rdata")
