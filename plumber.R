# plumber.R
library(plumber)
library(microdatasus)
library(dplyr)

#* @get /ping
function() {
  list(status = "ok", msg = "pong")
}

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

# No final do arquivo:
pr() %>% pr_run(host = "0.0.0.0", port = as.numeric(Sys.getenv("PORT", 8000)))
