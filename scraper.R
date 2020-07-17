library(jsonlite)
library(rvest)
library(tidyverse)
my_data <- read_html("http://export.arxiv.org/list/cs.CL/recent")
write_html(my_data, "/Users/elenawiegelmann/Desktop/inputs/raw_data.html") 
text_data <- my_data %>%
  html_nodes("dt") %>%
  html_text()
text_data

baseurl <- "https://arxiv.org/list/cs.CL/19" 
#2019, or 2019-2020?
#2019
months <- c('01?show=500','02?show=500','03?show=500','04?show=500','05?show=500','06?show=500','07?show=500','08?show=500','09?show=500','10?show=500','11?show=500','12?show=500')
months_url <- paste0(baseurl, months)


#only january, aka: months_url[1] , having mindblock and every attempt at iterating 1-12 has failed
links <-months_url[1] %>% read_html() %>% 
    html_nodes('dt')  %>%
    html_nodes(xpath ='//*[@id="dlpage"]/dl/dt/span/a[2]')  %>%
    html_attr('href')

links
View(links)


#slow this down (right now only january, so also add all months first)
newbase <- ("http://export.arxiv.org")
my_urls <- paste0(newbase, links) 
save_here <- paste0("document_", 1:25, ".pdf")
mapply(download.file, my_urls, save_here)

