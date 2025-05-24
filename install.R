options(repos = c(CRAN = "https://cloud.r-project.org"))

# Lista de pacotes obrigatórios
cran_packages <- c("remotes", "plumber", "dplyr", "checkmate", "jsonlite", "readr")

# Verifica o que falta
installed <- rownames(installed.packages())
to_install <- setdiff(cran_packages, installed)

# Instala com log
if (length(to_install) > 0) {
  cat("📦 Instalando pacotes CRAN faltantes:\n", paste(to_install, collapse = ", "), "\n")
  tryCatch({
    install.packages(to_install, dependencies = TRUE)
  }, error = function(e) {
    cat("❌ Erro ao instalar pacotes CRAN:\n", e$message, "\n")
    quit(status = 1)
  })
}

# Instala microdatasus via GitHub com tratamento de erro
if (!"microdatasus" %in% installed) {
  cat("📦 Instalando microdatasus do GitHub...\n")
  tryCatch({
    remotes::install_github("rfsaldanha/microdatasus", dependencies = TRUE)
  }, error = function(e) {
    cat("❌ Erro ao instalar microdatasus:\n", e$message, "\n")
    quit(status = 1)
  })
}

cat("✅ Todos os pacotes instalados com sucesso.\n")
