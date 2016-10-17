library(rvest)
dennys_info_LA = read_html("data/dennys/LA.xml") 
dennys_info_Durham = read_html("data/dennys/Durham.xml")

location_name = dennys_info_LA %>% html_nodes("name") %>% html_text() %>% str_trim()
address = dennys_info %>% html_nodes("address1") %>% html_text() %>% str_trim()
zipcode = dennys_info_LA %>% html_nodes("postalcode") %>% html_text() %>% str_trim()
city = dennys_info_LA %>% html_nodes("city") %>% html_text() %>% str_trim()
state = dennys_info_LA %>% html_nodes("state") %>% html_text() %>% str_trim()
latitude = dennys_info_LA %>% html_nodes("latitude") %>% html_text() %>% str_trim()
longitude = dennys_info_LA %>% html_nodes("longitude") %>% html_text() %>% str_trim()
phone = dennys_info_LA %>% html_nodes("phone") %>% html_text() %>% str_trim()

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

dennys = bind_rows(res)

