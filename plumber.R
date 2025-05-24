# plumber.R
library(plumber)
library(microdatasus)
library(dplyr)

#* @apiTitle PubMack microdatasus API

#* @get /sih
#* @param uf Estado (ex: "SP")
#* @param ano Ano (ex: 2022)
function(uf, ano) {
  df <- fetch_datasus(
    year_start = as.integer(ano),
    year_end = as.integer(ano),
    uf = uf,
    information_system = "SIH-RD"
  )
  head(df, 10)
}

#* @get /sim
#* @param uf Estado (ex: "SP")
#* @param ano Ano (ex: 2022)
function(uf, ano) {
  df <- fetch_datasus(
    year_start = as.integer(ano),
    year_end = as.integer(ano),
    uf = uf,
    information_system = "SIM-DO"
  )
  head(df, 10)
}

#* @get /sinasc
#* @param uf Estado (ex: "SP")
#* @param ano Ano (ex: 2022)
function(uf, ano) {
  df <- fetch_datasus(
    year_start = as.integer(ano),
    year_end = as.integer(ano),
    uf = uf,
    information_system = "SINASC"
  )
  head(df, 10)
}

#* @get /sia
#* @param uf Estado (ex: "SP")
#* @param ano Ano (ex: 2022)
function(uf, ano) {
  df <- fetch_datasus(
    year_start = as.integer(ano),
    year_end = as.integer(ano),
    uf = uf,
    information_system = "SIA-PA"
  )
  head(df, 10)
}

#* @get /cnes
#* @param uf Estado (ex: "SP")
#* @param ano Ano (ex: 2022)
function(uf, ano) {
  df <- fetch_datasus(
    year_start = as.integer(ano),
    year_end = as.integer(ano),
    uf = uf,
    information_system = "CNES-ST"
  )
  head(df, 10)
}

# Start API (obrigatório pro Render)
pr() %>% pr_run(host = "0.0.0.0", port = as.numeric(Sys.getenv("PORT", 8000)))
