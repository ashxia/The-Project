library(rvest)
library(tidyverse)
library(dplyr)

##this is the url for all the displayed cars on the first page in "used cars"

url1 <- "https://www.kijiji.ca/b-cars-trucks/calgary/used/c174l1700199a49"

#this is a sample car page 
#if the add is removed the link will no longer exist

url2 <- "https://www.kijiji.ca/v-cars-trucks/calgary/2020-gmc-sierra-1500-sle-5-3l-v8-backup-camera/1512603313"

#calgary symbole in Kijiji
calgary <- "c174l1700199a49"

#read the pages 
page1 <- read_html(url1)
page2 <- read_html(url2)


#collect car information 

#collect car specifications unnamed

car_details <- page2 %>% 
  html_nodes("dd.attributeValue-2574930263 ") %>%
  html_text()

#car filling form mandatory fields are (year, make, model, condition, kilometers, price)
#other fields are not always filled

car_form <- page2 %>% 
  html_nodes(".attributeLabel-240934283 ") %>% 
  html_text ()

#all car info with car form in text 

car_full_info <- page2 %>% 
  html_nodes(".itemAttributeWrapper-37588635") %>% 
  html_text ()

#collect price

collect_price <- function(page2) {
  page2 %>% 
    html_nodes(".priceContainer-1419890179") %>% 
    html_text() %>% 
    parse_number()
}

#-------------

#collect all links for all the cars desplayed in page1

collect_links <- function(page1) {
  all_links <- page1 %>% 
    html_nodes("a.title") %>% 
    html_attr("href") %>% 
    na.omit()
  
  paste("https://www.kijiji.ca/", all_links)
  
}

#----------------------------------


#this is to creat every page we need to parse in order to collect the links for car details, wwe can probably creat a thousand links and paste in a txt file coz these links wont change

number <- 4

for (i in 1:number){
    links <- paste0("https://www.kijiji.ca/b-cars-trucks/calgary/used/page-", i, "/c174l1700199a49")
    list <- append(list,links )
  }

############

