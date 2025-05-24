library(plumber)
library(microdatasus)
library(dplyr)
library(checkmate)

#* @apiTitle PubMack microdatasus API

validate_inputs <- function(uf, ano) {
  if (!test_string(uf) || nchar(uf) != 2) {
    stop("UF inválido. Use siglas como 'SP', 'RJ', etc.")
  }
  if (!test_integerish(as.integer(ano)) || as.integer(ano) < 1990 || as.integer(ano) > as.integer(format(Sys.Date(), "%Y"))) {
    stop("Ano inválido. Use um ano entre 1990 e o atual.")
  }
}

# Utilitário comum
resposta_padrao <- function(uf, ano, sistema) {
  tryCatch({
    validate_inputs(uf, ano)
    df <- fetch_datasus(as.integer(ano), as.integer(ano), uf, sistema)
    head(df, 10)
  }, error = function(e) {
    res$status <- 400
    list(erro = e$message)
  })
}

#* @get /sih
#* @param uf Estado (ex: "SP")
#* @param ano Ano (ex: 2022)
sih <- function(uf, ano, res) {
  resposta_padrao(uf, ano, "SIH-RD")
}

#* @get /sim
#* @param uf Estado (ex: "SP")
#* @param ano Ano (ex: 2022)
sim <- function(uf, ano, res) {
  resposta_padrao(uf, ano, "SIM-DO")
}

#* @get /sinasc
#* @param uf Estado (ex: "SP")
#* @param ano Ano (ex: 2022)
sinasc <- function(uf, ano, res) {
  resposta_padrao(uf, ano, "SINASC")
}

#* @get /sia
#* @param uf Estado (ex: "SP")
#* @param ano Ano (ex: 2022)
sia <- function(uf, ano, res) {
  resposta_padrao(uf, ano, "SIA-PA")
}

#* @get /cnes
#* @param uf Estado (ex: "SP")
#* @param ano Ano (ex: 2022)
cnes <- function(uf, ano, res) {
  resposta_padrao(uf, ano, "CNES-ST")
}

#* @get /healthcheck
#* Rota para ver se o serviço está ativo
healthcheck <- function() {
  list(status = "ok", message = "PubMack API operacional 🚀")
}

# Start da API para Render
port <- as.integer(Sys.getenv("PORT", unset = 8000))
pr <- plumber::plumb("plumber.R")

# Ativa modo debug pra ver tudo nos logs da Render
pr_set_debug(TRUE)

# Inicia
pr$run(host = "0.0.0.0", port = port)
