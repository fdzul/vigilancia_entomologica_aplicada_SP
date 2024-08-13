
# Step 1.0 load the ovitraps coordinates datasets ####
load("~/Library/CloudStorage/OneDrive-Personal/automatic_read_ovitraps/8.RData/ovitraps_coordinates/coord_2024.RData")

# Step 1.1 tranform the df to sf object ####
coord_2024 <- coord_2024 |>
    sf::st_as_sf(coords = c("Pocision_X", "Pocision_Y"),
                 crs = 4326)

# Step 2. load the municipalities & extract the mun with  ovitraps####
mun <- rgeomex::AGEM_inegi19_mx
mun_ovi <- mun[coord_2024,]

# Step 3. load the urban areas of mexico ####
load("/Users/fdzul/Library/CloudStorage/OneDrive-Personal/automatic_read_meta_datasets/8.RData/Global_Urban_Areas/urban_areas_mexico.RData")

urban_areas_ovitraps <- urban_areas[coord_2024, ]
length(unique(urban_areas$id))
length(unique(urban_areas_ovitraps$id))

#  Step 4. load the localities 
loc_urb <- rgeomex::loc_inegi19_mx |>
    sf::st_make_valid()

#  extract the localities with ovitraps 
loc_urb_ovi <- loc_urb[coord_2024,]


# Step 5. load the high risk localities 
high_risk_loc <- readRDS("/Users/fdzul/Downloads/hotspots_paper/8.RData/loc_temp_geocoded.rds")

# Step 5.1 convert th df to sf ####
high_risk_loc  <- high_risk_loc  |>
    sf::st_as_sf(coords = c("long", "lat"),
                 crs = 4326)
#  extract the localities with high risk with ovitraps ####
high_risk_loc_ovi <- high_risk_loc[loc_urb_ovi, ]

mapview::mapview(urban_areas_ovitraps,
                     col.regions = "#ECB32D",
                     label.name = "areas urbanas con Ovitrampa",
                     legend = FALSE) +
    mapview::mapview(loc_urb_ovi,
                     col.regions = "#0E54B6FF", 
                     label.name = "areas urbanas con Ovitrampa",
                     legend = FALSE) +
mapview::mapview(high_risk_loc,
                     col.regions = "#E01A59", # "#34A74BFF",# "#558934FF",
                     label.name = "areas urbanas con Ovitrampa",
                     legend = FALSE) +
        mapview::mapview(high_risk_loc_ovi,
                     col.regions = "#34A74BFF",
                     label.name = "areas urbanas con Ovitrampa",
                     legend = FALSE)








