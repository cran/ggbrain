## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(ggbrain)
library(ggplot2)
library(patchwork)
library(RNifti)

# MNI 2009c anatomical underlay
underlay_3mm <- system.file("extdata", "mni_template_2009c_3mm.nii.gz", package = "ggbrain")

# Schaefer 200-parcel atlas of cortex
schaefer200_atlas_3mm <- system.file("extdata", "Schaefer_200_7networks_2009c_3mm.nii.gz", package = "ggbrain")

## -----------------------------------------------------------------------------
schaefer_img <- readNifti(schaefer200_atlas_3mm)
sort(unique(as.vector(schaefer_img)))

## -----------------------------------------------------------------------------
gg_obj <- ggbrain() +
  images(c(underlay = underlay_3mm, atlas = schaefer200_atlas_3mm)) +
  slices(c("z = 30", "z=40")) +
  geom_brain(definition = "underlay") +
  geom_brain(definition = "atlas")

plot(gg_obj)

