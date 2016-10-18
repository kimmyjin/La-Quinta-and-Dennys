library(rvest)
library(stringr)
library(tibble)
library(dplyr)

files = dir("data/lq/", "html", full.names = TRUE)

res = list()

for(i in seq_along(files))
{
  file = files[i]
  
  page = read_html(file)
  
  hotel_info = page %>% 
    html_nodes(".hotelDetailsBasicInfoTitle p") %>%
    html_text() %>% 
    str_split("\n") %>% 
    .[[1]] %>% 
    str_trim() %>%
    .[. != ""]
  
  location_name = page %>% html_nodes("h1") %>%
    html_text() %>% str_trim()
  
  n_rooms = page %>% 
    html_nodes(".hotelFeatureList li:nth-child(2)") %>%
    html_text() %>%
    str_trim() %>%
    str_replace("Rooms: ", "") %>%
    as.integer()
  
  features = page %>%
    html_nodes(".pptab_contentL li") %>%
    html_text() %>%
    paste(collapse=" ")

  swim = features %>% str_detect("Swimming Pool")       #swimming pools
  internet = features %>% str_detect("Internet")        #internet availability

  floors = page %>%                                     #floors
    html_nodes(".hotelFeatureList li:nth-child(1)") %>%
    html_text() %>%
    str_replace("Floors:","") %>%
    as.numeric()
  
  # Google link includes latitude first then longitude
  lat_long = page %>%
    html_nodes(".minimap") %>%
    html_attr("src") %>%
    str_match("\\|(-?[0-9]{1,2}\\.[0-9]+),(-?[0-9]{1,3}\\.[0-9]+)&")
  
  res[[i]] = data_frame(
    location_name = location_name,
    address = paste(hotel_info[1:2],collapse="\n"),
    phone = hotel_info[3] %>% str_replace("Phone: ", ""), 
    fax   = hotel_info[4] %>% str_replace("Fax: ", ""),
    n_rooms = n_rooms,
    swimming_pool = ifelse(swim==TRUE,"Yes","No"),
    internet = ifelse(internet==TRUE,"Yes","No"),
    floors,
    lat   = lat_long[,2],
    long  = lat_long[,3]
  )
}

hotels = bind_rows(res)

dir.create("data/",showWarnings = FALSE)
save(hotels, file="data/lq.Rdata")