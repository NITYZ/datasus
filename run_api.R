library(plumber)

# Captura a porta do ambiente (Render)
port <- as.integer(Sys.getenv("PORT", unset = 8000))

# Verifica se a porta foi corretamente lida
if (is.na(port)) {
  stop("❌ Porta inválida. Verifique a variável de ambiente PORT.")
}

# Verifica se o script plumber.R existe
if (!file.exists("plumber.R")) {
  stop("❌ Arquivo plumber.R não encontrado no diretório atual.")
}

# Carrega e inicia a API
cat("🚀 Iniciando PubMack API na porta", port, "\n")

pr <- plumber::plumb("plumber.R")
pr_set_debug(TRUE)  # Ativa debug mode pro Render logar erros e requisições
pr$run(host = "0.0.0.0", port = port)
