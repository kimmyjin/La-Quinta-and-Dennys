library(rvest)
dennys_info_LA = read_html("data/dennys/LA.xml") 
dennys_info_Durham = read_html("data/dennys/Durham.xml")
dennys_info_Utah = read_html("data/dennys/Utah.xml")
dennys_info_Washington = read_html("data/dennys/Washington.xml")

location_name = dennys_info_LA %>% 
  html_nodes("name") %>% 
  html_text() %>% 
  str_trim()
address = dennys_info_LA %>%
  html_nodes("address1") %>% 
  html_text() %>% 
  str_trim()
zipcode = dennys_info_LA %>% 
  html_nodes("postalcode") %>%
  html_text() %>% 
  str_trim()
city = dennys_info_LA %>% 
  html_nodes("city") %>% 
  html_text() %>% 
  str_trim()
state = dennys_info_LA %>% 
  html_nodes("state") %>% 
  html_text() %>%
  str_trim()
latitude = dennys_info_LA %>% 
  html_nodes("latitude") %>% 
  html_text() %>% 
  str_trim()
longitude = dennys_info_LA %>% 
  html_nodes("longitude") %>% 
  html_text() %>% 
  str_trim()
phone = dennys_info_LA %>%
  html_nodes("phone") %>% 
  html_text() %>% 
  str_trim()

res = list()
for(j in seq_along(address))
{
  res[[j]] = data_frame(
    location_name = location_name[j],
    address = paste(address[j],city[j], paste(state[j],zipcode[j]), sep =", \n"),
    phone = phone[j],
    lat = latitude[j],
    long = longitude[j]
  )
}
dennys.Durham = bind_rows(res)


location_name = dennys_info_Utah %>% 
  html_nodes("name") %>% 
  html_text() %>% 
  str_trim()
address = dennys_info_Utah %>%
  html_nodes("address1") %>% 
  html_text() %>% 
  str_trim()
zipcode = dennys_info_Utah %>% 
  html_nodes("postalcode") %>%
  html_text() %>% 
  str_trim()
city = dennys_info_Utah %>% 
  html_nodes("city") %>% 
  html_text() %>% 
  str_trim()
state = dennys_info_Utah %>% 
  html_nodes("state") %>% 
  html_text() %>%
  str_trim()
latitude = dennys_info_Utah %>% 
  html_nodes("latitude") %>% 
  html_text() %>% 
  str_trim()
longitude = dennys_info_Utah %>% 
  html_nodes("longitude") %>% 
  html_text() %>% 
  str_trim()
phone = dennys_info_Utah %>%
  html_nodes("phone") %>% 
  html_text() %>% 
  str_trim()

res = list()
for(j in seq_along(address))
{
  res[[j]] = data_frame(
    location_name = location_name[j],
    address = paste(address[j],city[j], paste(state[j],zipcode[j]), sep =", \n"),
    phone = phone[j],
    lat = latitude[j],
    long = longitude[j]
  )
}
dennys.Utah = bind_rows(res)


location_name = dennys_info_Washington %>% 
  html_nodes("name") %>% 
  html_text() %>% 
  str_trim()
address = dennys_info_Washington %>%
  html_nodes("address1") %>% 
  html_text() %>% 
  str_trim()
zipcode = dennys_info_Washington %>% 
  html_nodes("postalcode") %>%
  html_text() %>% 
  str_trim()
city = dennys_info_Washington %>% 
  html_nodes("city") %>% 
  html_text() %>% 
  str_trim()
state = dennys_info_Washington %>% 
  html_nodes("state") %>% 
  html_text() %>%
  str_trim()
latitude = dennys_info_Washington %>% 
  html_nodes("latitude") %>% 
  html_text() %>% 
  str_trim()
longitude = dennys_info_Washington %>% 
  html_nodes("longitude") %>% 
  html_text() %>% 
  str_trim()
phone = dennys_info_Washington %>%
  html_nodes("phone") %>% 
  html_text() %>% 
  str_trim()

res = list()
for(j in seq_along(address))
{
  res[[j]] = data_frame(
    location_name = location_name[j],
    address = paste(address[j],city[j], paste(state[j],zipcode[j]), sep =", \n"),
    phone = phone[j],
    lat = latitude[j],
    long = longitude[j]
  )
}
dennys.Washington = bind_rows(res)

merge <- union(dennys.Utah, dennys.Washington)
merge <- union(merge, dennys.Durham)
