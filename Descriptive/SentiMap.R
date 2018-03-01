
# remove all the variables in the environment
rm(list=ls())
#==========================================#
# import csv file 
#==========================================#
t2<-read.csv("twitter_file_with_text.csv",fill=T, sep=",", stringsAsFactors = FALSE)
class(t2)
names(t2)
# [1] "follow_request_sent"                "contributors"                      
# [3] "truncated"                          "profile_use_background_image"      
# [5] "profile_sidebar_fill_color"         "time_zone"                         
# [7] "in_reply_to_status_id"              "id"                                
# [9] "favorite_count"                     "verified"                          
# [11] "sentiment"                          "profile_text_color"                
# [13] "profile_image_url_https"            "retweeted"                         
# [15] "is_translator"                      "source"                            
# [17] "followers_count"                    "protected"                         
# [19] "in_reply_to_screen_name"            "in_reply_to_user_id"               
# [21] "default_profile_image"              "retweet_count"                     
# [23] "id_str"                             "favorited"                         
# [25] "utc_offset"                         "statuses_count"                    
# [27] "profile_background_color"           "friends_count"                     
# [29] "profile_background_image_url_https" "profile_link_color"                
# [31] "profile_image_url"                  "notifications"                     
# [33] "geo_enabled"                        "profile_banner_url"                
# [35] "in_reply_to_user_id_str"            "profile_background_image_url"      
# [37] "lang"                               "profile_background_tile"           
# [39] "favourites_count"                   "screen_name"                       
# [41] "url"                                "created_at"                        
# [43] "contributors_enabled"               "location"                          
# [45] "filter_level"                       "in_reply_to_status_id_str"         
# [47] "profile_sidebar_border_color"       "place"                             
# [49] "default_profile"                    "following"                         
# [51] "listed_count"   
# attach
attach(t2)
Size<-dim(t2)
#==========================================#
# Descriptive statistics
#==========================================#
lapply(t2, class)
# $follow_request_sent
# [1] "logical"
# 
# $contributors
# [1] "logical"
# 
# $truncated
# [1] "character"
# 
# $profile_use_background_image
# [1] "character"
# 
# $profile_sidebar_fill_color
# [1] "character"
# 
# $time_zone
# [1] "character"
# 
# $in_reply_to_status_id
# [1] "numeric"
# 
# $id
# [1] "integer"
# 
# $favorite_count
# [1] "integer"
# 
# $verified
# [1] "character"
# 
# $sentiment
# [1] "integer"
# 
# $profile_text_color
# [1] "character"
# 
# $profile_image_url_https
# [1] "character"
# 
# $retweeted
# [1] "character"
# 
# $is_translator
# [1] "character"
# 
# $source
# [1] "character"
# 
# $followers_count
# [1] "integer"
# 
# $protected
# [1] "character"
# 
# $in_reply_to_screen_name
# [1] "character"
# 
# $in_reply_to_user_id
# [1] "integer"
# 
# $default_profile_image
# [1] "character"
# 
# $retweet_count
# [1] "integer"
# 
# $id_str
# [1] "integer"
# 
# $favorited
# [1] "character"
# 
# $utc_offset
# [1] "integer"
# 
# $statuses_count
# [1] "integer"
# 
# $profile_background_color
# [1] "character"
# 
# $friends_count
# [1] "integer"
# 
# $profile_background_image_url_https
# [1] "character"
# 
# $profile_link_color
# [1] "character"
# 
# $profile_image_url
# [1] "character"
# 
# $notifications
# [1] "logical"
# 
# $geo_enabled
# [1] "character"
# 
# $profile_banner_url
# [1] "character"
# 
# $in_reply_to_user_id_str
# [1] "integer"
# 
# $profile_background_image_url
# [1] "character"
# 
# $lang
# [1] "character"
# 
# $profile_background_tile
# [1] "character"
# 
# $favourites_count
# [1] "integer"
# 
# $screen_name
# [1] "character"
# 
# $url
# [1] "character"
# 
# $created_at
# [1] "character"
# 
# $contributors_enabled
# [1] "character"
# 
# $location
# [1] "character"
# 
# $filter_level
# [1] "character"
# 
# $in_reply_to_status_id_str
# [1] "numeric"
# 
# $profile_sidebar_border_color
# [1] "character"
# 
# $place
# [1] "character"
# 
# $default_profile
# [1] "character"
# 
# $following
# [1] "logical"
# 
# $listed_count
# [1] "integer"

summary(favorite_count)

#==============
# Sentiment
#==============
summary(sentiment)
table(sentiment)

jpeg("sentiment_hist.jpeg")
hist(sentiment, freq=F, main="Sentiment Histogram", breaks=seq(from=-12.5,to=9.5,by=1), col=c(2,3), xlab="Sentiment")
# Add the line of density, "col" for color, "lwd" for line width
lines(density(sentiment),col=2,lwd=3)
dev.off()
#==============
# Followers count
#==============
# use the excellent fitdistrplus package which offers some nice functions for distribution fitting. We will use the functiondescdist to gain some ideas about possible candidate distributions.
summary(followers_count)
quantile(followers_count)

followers_count2<-log(followers_count[followers_count!=0])
summary(followers_count2)
quantile(followers_count2)

install.packages("fitdistrplus")
library(fitdistrplus)
install.packages("logspline")
library(logspline)
#
jpeg("CF_graph.jpeg")
descdist(followers_count, discrete = FALSE)
dev.off()
#
jpeg("CF_graph2.jpeg")
descdist(followers_count2, discrete = FALSE)
dev.off()
#
jpeg("log_folloer_count_hist.jpeg")
hist(followers_count2, freq=F, main="Sentiment Histogram", breaks=seq(from=0,to=15,by=1), col=c(2,3), xlab="log(#Follower)")
# Add the line of density, "col" for color, "lwd" for line width
lines(density(followers_count2),col=2,lwd=3)
dev.off()

fit.norm <- fitdist(followers_count2, "norm")
plot(fit.norm)

# percentage of followers number that exceeds 1000
sum(followers_count>1000)/Num


boxplot(followers_count)
hist(followers_count, freq=F, main="Follower Count Histogram", col=c(2,3), xlab="Sentiment")
# Add the line of density, "col" for color, "lwd" for line width
lines(density(followers_count),col=2,lwd=3)


summary(statuses_count)

summary(friends_count)

summary(favourites_count)

summary(listed_count)


sum(lang=="en")/Size[1]


sum(geo_enabled == "True")/Size[1]

sum(location[lang=="en"]=="")/Size[1]
#==========================================#

#==========================================#
# Time Zone
#==========================================#

#==============
# Get geographical data
#==============
# Check version of R, becasue ggmap require R version higher than 3.4.3
#R.Version()
#install.packages("ggmap")
library(ggmap)
#install.packages("tidyverse")
#library(tidyverse)
# Check the version info of ggmap
#sessionInfo()
temp <-time_zone[geo_enabled == "True"]
ntime_zone <-temp[temp!=""]
Num = length(ntime_zone)
# Initialize the data frame
lon <- vector(mode="numeric", length=Num)
lat <- vector(mode="numeric", length=Num)
geoAddress <- vector(mode="character", length=Num)
# Loop through the addresses to get the latitude and longitude of each address and add it to the
# origAddress data frame in new columns lat and lon
#for(i in 1:Num)
for(i in 1:Num)
{
  result <- tryCatch(geocode(ntime_zone[i], output = "latlona", source = "google"),
                     warning = function(w) data.frame(lon = NA, lat = NA, address = NA))
  lon[i] <- as.numeric(result[1])
  lat[i] <- as.numeric(result[2])
  geoAddress[i] <- as.character(result[3])
}

geocoded <- data.frame(ntime_zone, lon, lat, geoAddress)

#==============
# Save geographical data
#==============

# Write a CSV file containing origAddress to the working directory
write.csv(geocoded, "geocoded.csv", row.names=FALSE)

#==============
# Plot Map
#==============
#install.packages("rworldmap")
library(rworldmap)
# high quality plot need rworldxtra package
#install.packages("rworldxtra")
library(rworldxtra)
newmap <- getMap(resolution = "high")
jpeg('geoplot.jpeg')
plot(newmap, asp = 1)
points(geocoded$lon, geocoded$lat, col = "red", cex = .6)
dev.off()
