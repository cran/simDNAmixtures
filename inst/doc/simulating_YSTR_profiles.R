## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
  require(simDNAmixtures)
  data_dir <- system.file("extdata", package = "simDNAmixtures")
  kit_filename <- file.path(data_dir, "YFiler_Plus_3500_FSSA.xml")
  YSTR_kit <- read_STRmix_kit_settings(kit_filename, data_dir, include_y_loci = TRUE)

## -----------------------------------------------------------------------------
y_refs_with_names <- as.data.frame(readxl::read_excel(path = system.file("extdata","South_Australia_YSTRs.xlsx",
                                                                         package = "simDNAmixtures"), 
                                                      col_types = rep("text", 27)))

x <- y_refs_with_names[1:2, -c(1, 2)]
rownames(x) <- c("K1", "K2")
genotypes <- simDNAmixtures:::.wide_YSTR_references_to_allele_tables(x)

## ----echo=FALSE, results='asis'-----------------------------------------------
knitr::kable(genotypes)

## -----------------------------------------------------------------------------
sampling_parameters <- list(min_template = 250., max_template = 5000.,
                            degradation_shape = 2.5, degradation_scale = 5e-4)

mixtures <- sample_mixtures_from_genotypes(n = 10, genotypes = genotypes, sampling_parameters = sampling_parameters, 
                               model_settings = YSTR_kit, sample_model = sample_log_normal_model, 
                               number_of_replicates = 3, tag = "YSTR 2P")
length(mixtures)
# add results_directory="..." to save results to disk

