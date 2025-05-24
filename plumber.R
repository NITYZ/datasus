library(plumber)
library(microdatasus)
library(dplyr)

#* @apiTitle PubMack microdatasus API

#* @get /sih
#* @param uf Estado (ex: "SP")
#* @param ano Ano (ex: 2022)
sih <- function(uf, ano) {
  df <- fetch_datasus(as.integer(ano), as.integer(ano), uf, "SIH-RD")
  head(df, 10)
}

#* @get /sim
#* @param uf Estado (ex: "SP")
#* @param ano Ano (ex: 2022)
sim <- function(uf, ano) {
  df <- fetch_datasus(as.integer(ano), as.integer(ano), uf, "SIM-DO")
  head(df, 10)
}

#* @get /sinasc
#* @param uf Estado (ex: "SP")
#* @param ano Ano (ex: 2022)
sinasc <- function(uf, ano) {
  df <- fetch_datasus(as.integer(ano), as.integer(ano), uf, "SINASC")
  head(df, 10)
}

#* @get /sia
#* @param uf Estado (ex: "SP")
#* @param ano Ano (ex: 2022)
sia <- function(uf, ano) {
  df <- fetch_datasus(as.integer(ano), as.integer(ano), uf, "SIA-PA")
  head(df, 10)
}

#* @get /cnes
#* @param uf Estado (ex: "SP")
#* @param ano Ano (ex: 2022)
cnes <- function(uf, ano) {
  df <- fetch_datasus(as.integer(ano), as.integer(ano), uf, "CNES-ST")
  head(df, 10)
}

# Start da API para Render
port <- as.integer(Sys.getenv("PORT", unset = 8000))
pr <- plumber::plumb("plumber.R")
pr$run(host = "0.0.0.0", port = port)
