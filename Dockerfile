FROM rocker/r-ver:4.3.1

# Instalar libs de sistema necessárias
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libv8-dev \
    libfontconfig1-dev \
    pandoc \
    make \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Configura repositório do R
ENV R_REPOS="https://cloud.r-project.org"

# Copia script de instalação
COPY install.R /install.R
RUN Rscript /install.R

# Copia código da API
COPY plumber.R /plumber.R
COPY run_api.R /run_api.R

# Expor porta dinâmica para Render
EXPOSE 8000

# Rodar a API
CMD ["Rscript", "run_api.R"]
