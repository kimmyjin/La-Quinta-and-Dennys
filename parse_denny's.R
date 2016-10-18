library(rvest)
de.files = dir("data/dennys/", "xml", full.names = TRUE)
dennys = list()
for(i in seq_along(de.files)){
  file = de.files[i]
  
  dennys_info = read_html(file)
  
  location_name = dennys_info %>% 
    html_nodes("name") %>% 
    html_text() %>% 
    str_trim()
  address = dennys_info %>%
    html_nodes("address1") %>% 
    html_text() %>% 
    str_trim()
  zipcode = dennys_info %>% 
    html_nodes("postalcode") %>%
    html_text() %>% 
    str_trim()
  city = dennys_info %>% 
    html_nodes("city") %>% 
    html_text() %>% 
    str_trim()
  state = dennys_info %>% 
    html_nodes("state") %>% 
    html_text() %>%
    str_trim()
  country = dennys_info %>% 
    html_nodes("country") %>% 
    html_text() %>%
    str_trim()
  latitude = dennys_info %>% 
    html_nodes("latitude") %>% 
    html_text() %>% 
    str_trim()
  longitude = dennys_info %>% 
    html_nodes("longitude") %>% 
    html_text() %>% 
    str_trim()
  phone = dennys_info %>%
    html_nodes("phone") %>% 
    html_text() %>% 
    str_trim()
  
  res = list()
  for(j in seq_along(address))
  {
    res[[j]] = data_frame(
      location_name = location_name[j],
      address = paste(address[j],city[j], paste(state[j],zipcode[j]), sep =", \n"),
      country = country[j],
      phone = phone[j],
      lat = latitude[j],
      long = longitude[j]
    )
  }
  dennys <- union(dennys, res)
}
dennys = bind_rows(dennys)

dennys.US <- dennys %>%
  filter(dennys$country == "US")


save(dennys.US,file="data/dennys.Rdata")
