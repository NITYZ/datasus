FROM rocker/r-ver:4.3.1

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

ENV R_REPOS="https://cloud.r-project.org"

COPY install.R /install.R
RUN Rscript /install.R

COPY plumber.R /plumber.R
COPY run_api.R /run_api.R

EXPOSE 8000

CMD ["Rscript", "run_api.R"]
