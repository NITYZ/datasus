# Define repositório CRAN confiável
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Lista de pacotes CRAN necessários
cran_packages <- c(
  "remotes",
  "plumber",
  "dplyr",
  "jsonlite",
  "readr",
  "checkmate"
)

# Instala somente os que ainda não estão presentes
installed <- rownames(installed.packages())
to_install <- setdiff(cran_packages, installed)
if (length(to_install) > 0) {
  install.packages(to_install, dependencies = TRUE)
}

# Instala microdatasus do GitHub (força reinstalação só se ausente)
if (!"microdatasus" %in% installed) {
  remotes::install_github("rfsaldanha/microdatasus", dependencies = TRUE)
}

cat("✅ Todos os pacotes instalados com sucesso.\n")
