## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
require(simDNAmixtures)

## -----------------------------------------------------------------------------
freqs <- read_allele_freqs(system.file("extdata","FBI_extended_Cauc.csv",
                                       package = "simDNAmixtures"))
data(gf)

sampling_parameters <- list(min_template = 50., max_template = 10000.,
                            degradation_shape = 2.5, degradation_scale = 1e-3)

## -----------------------------------------------------------------------------
set.seed(1)
mixtures <- sample_mixtures(n = 2, contributors = c("U1", "U2"), freqs = freqs,
                            sampling_parameters = sampling_parameters,
                            model_settings = gf$log_normal_bwfw_settings,
                            sample_model = sample_log_normal_model)

## -----------------------------------------------------------------------------
knitr::kable(mixtures$parameter_summary[1:5])

## ---- results='asis'----------------------------------------------------------
knitr::kable(head(mixtures$samples[[1]]$mixture, 10))

## -----------------------------------------------------------------------------
gamma_sampling_parameters <- list(min_mu = 50., max_mu = 5e3,
                            min_cv = 0.05, max_cv = 0.35,
                            degradation_shape1 = 10, degradation_shape2 = 1)

## -----------------------------------------------------------------------------
set.seed(2)
mixtures <- sample_mixtures(n = 2, contributors = c("U1", "U2"), freqs = freqs,
                            sampling_parameters = gamma_sampling_parameters,
                            model_settings = gf$gamma_settings_no_stutter,
                            sample_model = sample_gamma_model)

## -----------------------------------------------------------------------------
knitr::kable(mixtures$parameter_summary[1:4]) 

## -----------------------------------------------------------------------------
knitr::kable(mixtures$parameter_summary[c(1,5:7)])

## ---- results='asis'----------------------------------------------------------
knitr::kable(head(mixtures$samples[[1]]$mixture, 10))

