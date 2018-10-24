year <- sub("-.*", "", meta$Date)
note <- sprintf("R package version %s", meta$Version)

bibentry(bibtype = "Manual",
         title = "{ectotemp}: Quantitative Estimates of Small Ectotherm Temperature Regulation Effectiveness",
         author = c(person("Wouter", "Beukema")),
         year = year,
         note = note,
         url = "https://CRAN.R-project.org/package=ectotemp")
