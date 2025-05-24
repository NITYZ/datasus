library(plumber)

# Porta injetada automaticamente pelo Render
port <- as.integer(Sys.getenv("PORT", unset = 8000))

# Carrega o arquivo plumber
pr <- plumber::plumb("plumber.R")

# Inicia a API
pr$run(host = "0.0.0.0", port = port)
