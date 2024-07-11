# functions for the app

# Querying the API - including 6 parameters



sunrise_sunset_query <- function(latitude, longitude, date, tzid, callback=NULL, format=1){
  
  # using the unchanging part of the url as the base
  base_URL <- "https://api.sunrise-sunset.org/json"
  
  # to create 'url' object we need to combine all the parts 
  
  url <- paste0(base_URL,
                
                # in decimal degrees  
                
                "?lat=", latitude,
                
                # in decimal degrees
                
                "&lng=", longitude,
                
                # Date in YYYY-MM-DD format
                
                "&date=", date,
                
                # Specified Time Zone that you can find here         
                # https://www.php.net/manual/en/timezones.php
                
                "&tzid=", tzid,
                
                # 0 or 1, 1 is default, for the standard of time (ISO 8601)
                
                "&formatted=", format)
  
  # CALLBACK - Optional. Any valid JavaScript method name can be used as the callback value.  
  # The complete JSON API response will be wrapped in the callback function requested.
  
  # "&callback=", callback)
  
  # if (!is.null(callback)) {
  #     url <- paste0(url, "&callback=", callback)
  # }
  
  # creating an object for the response to the API call
  response <- GET(url)
  
  
  # Parsing the response content from JSON
  content_text <- content(response, "text", encoding = "UTF-8")
  parsed <- fromJSON(content_text)
  
  # Checking the structure of the parsed data
  str(parsed)
  
  # creating a tibble
  my_requested_data <- as_tibble(parsed$results)
  my_requested_data$date <- as.Date(date)
  my_requested_data$latitude <- latitude
  my_requested_data$longitude <- longitude
  
  return(my_requested_data)
}

# function for generating my subset



api_query <- function(chosen_cities, chosen_date ){
  capital_cities <- read.csv("https://gist.githubusercontent.com/ofou/df09a6834a8421b4f376c875194915c9/raw/355eb56e164ddc3cd1a9467c524422cb674e71a9/country-capital-lat-long-population.csv")
  capital_cities$tz <- tz_lookup_coords(capital_cities$Latitude, capital_cities$Longitude)
  
  result_list <- tibble()
  if (length(chosen_cities) <1) chosen_cities = capital_cities$Capital.City
  chosen_cities_tb <- capital_cities[capital_cities$Capital.City %in% chosen_cities,]
  for (i in 1:nrow(chosen_cities_tb)) {
    lat <- chosen_cities_tb$Latitude[i]
    lon <- chosen_cities_tb$Longitude[i]
    date <- day_of_choice
    tz <- chosen_cities_tb$tz[i]
    result <- sunrise_sunset_query(lat, lon, chosen_date, tz)
    
    result_list <- append(result_list, list(result))
  }
  
  # Combine the list of tibbles into one larger dataframe
  combined_results <- bind_rows(result_list)
  
  user_subset <- inner_join(capital_cities, combined_results, 
                         by = join_by(Latitude==latitude, Longitude==longitude))
  
  
  cols_to_reformat <- c("sunrise", "sunset", "solar_noon","civil_twilight_begin",  "civil_twilight_end", 
                        "nautical_twilight_begin","nautical_twilight_end","astronomical_twilight_begin", 
                        "astronomical_twilight_end")
  
  user_subset[,cols_to_reformat] <- lapply(user_subset[,cols_to_reformat], function(x)
    hms::as_hms(format(strptime(x, "%I:%M:%S %p"),format= "%H:%M:%S")) )
  
  
  user_subset$day_length=hms::as_hms(user_subset$day_length)
  
  return(user_subset)

  }


