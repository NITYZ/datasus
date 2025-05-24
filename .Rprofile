options(repos = c(CRAN = "https://cloud.r-project.org"))

if (file.exists("plumber.R")) {
  tryCatch({
    source("plumber.R")
  }, error = function(e) {
    message("Erro ao carregar plumber.R: ", e$message)
  })
}
