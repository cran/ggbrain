## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(ggbrain)
library(ggplot2)
library(patchwork)
library(RNifti)
library(dplyr)

# MNI 2009c anatomical underlay
underlay_file <- system.file("extdata", "mni_template_2009c_2mm.nii.gz", package = "ggbrain")

# Schaefer 200-parcel atlas of cortex
schaefer200_atlas_file <- system.file("extdata", "Schaefer_200_7networks_2009c_2mm.nii.gz", package = "ggbrain")

# Automated labels of 200 parcels
schaefer200_atlas_labels <- read.csv(system.file("extdata", "Schaefer_200_7networks_labels.csv", package = "ggbrain"), na.strings=c("", "NA"))

# Parametric modulator: absolute reward prediction error following feedback in learning task
# thresholded to be whole-brain significant at FWE p < .05 using pTFCE
abspe_overlay_3mm <- system.file("extdata", "abspe_ptfce_fwep_0.05_2mm.nii.gz", package = "ggbrain")


## -----------------------------------------------------------------------------
schaefer_img <- readNifti(schaefer200_atlas_file)
length(unique(as.vector(schaefer_img)))

## ----fig.height=4, fig.width=6------------------------------------------------
gg_obj <- ggbrain() +
  images(c(underlay = underlay_file, atlas = schaefer200_atlas_file)) +
  slices(c("z = 30", "z=40")) +
  geom_brain(definition = "underlay", show_legend = TRUE, name="Anatomical") +
  geom_brain(definition = "atlas", name = "Parcel number")

plot(gg_obj)


## ----fig.height=4.5, fig.width=7----------------------------------------------
gg_obj <- ggbrain() +
  images(c(underlay = underlay_file, atlas = schaefer200_atlas_file)) +
  slices(c("z = 30", "z=40")) +
  geom_brain(definition = "underlay") +
  geom_brain(definition = "atlas", name = "Parcel number", 
             mapping = aes(fill = factor(value)), fill_scale = scale_fill_hue())

plot(gg_obj)

## ----fig.height=3, fig.width=6------------------------------------------------
gg_obj <- ggbrain() +
  images(c(underlay = underlay_file, atlas = schaefer200_atlas_file)) +
  slices(c("z = 30", "z=40")) +
  geom_brain(definition = "underlay") +
  geom_brain(definition = "atlas[atlas < 20]", name = "Parcel number", 
             mapping = aes(fill = factor(value)), fill_scale = scale_fill_hue()) +
  render()

plot(gg_obj)

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(head(schaefer200_atlas_labels, select(roi_num, hemi, x, y, z, network, MNI_Glasser_HCP_v1.0), n=6))

## -----------------------------------------------------------------------------
schaefer200_atlas_labels <- schaefer200_atlas_labels %>%
  dplyr::rename(value = roi_num)

## ----fig.height=3, fig.width=6------------------------------------------------
gg_base <- ggbrain() +
  images(c(underlay = underlay_file)) +
  images(c(atlas = schaefer200_atlas_file), labels=schaefer200_atlas_labels) +
  slices(c("z = 30", "z=40")) +
  geom_brain(definition = "underlay")

gg_obj <- gg_base +
  geom_brain(definition = "atlas[atlas < 20]", name = "Parcel number", 
             mapping = aes(fill = factor(value)), fill_scale = scale_fill_hue())

plot(gg_obj)

## ----fig.height=3, fig.width=6------------------------------------------------
gg_obj <- gg_base +
  geom_brain(definition = "atlas[atlas < 20]", name = "Eickhoff-Zilles Label", 
             mapping = aes(fill = CA_ML_18_MNI), fill_scale = scale_fill_hue()) +
  render()

plot(gg_obj)

## -----------------------------------------------------------------------------
schaefer200_atlas_labels %>% filter(value %in% c(12, 13, 14, 18)) %>% select(value, CA_ML_18_MNI)

## ----fig.height=3, fig.width=6------------------------------------------------
gg_obj <- gg_base +
  geom_brain(definition = "atlas", name = "Yeo 7 Assignment", 
             mapping = aes(fill = network))

plot(gg_obj)

## ----fig.height=3, fig.width=6------------------------------------------------
yeo_colors <- read.table(system.file("extdata", "Yeo2011_7Networks_ColorLUT.txt", package = "ggbrain")) %>%
  setNames(c("index", "name", "r", "g", "b", "zero")) %>% slice(-1)

# Convert RGB to hex. Also, using a named set of colors with scale_fill_manual ensures accurate value -> color mapping
yeo7 <- as.character(glue::glue_data(yeo_colors, "{sprintf('#%.2x%.2x%.2x', r, g, b)}")) %>%
  setNames(c("Vis", "SomMot", "DorsAttn", "SalVentAttn", "Limbic", "Cont", "Default"))

gg_obj <- gg_base +
  geom_brain(definition = "atlas", name = "Yeo 7 Assignment", 
             mapping = aes(fill = network), fill_scale = scale_fill_manual(values=yeo7))

plot(gg_obj)

## ----fig.height=5, fig.width=7.5----------------------------------------------
gg_obj <- gg_base +
  geom_brain(definition = "DAN Region := atlas[atlas.network == 'DorsAttn']", 
             mapping=aes(fill=CA_ML_18_MNI), show_legend = TRUE) +

  geom_outline(definition = "atlas", name = "Yeo 7 Assignment",
               mapping = aes(outline = network), 
               outline_scale = scale_fill_manual(values=yeo7), show_legend = TRUE)
  
plot(gg_obj)

## ----dan_overlay, fig.height=4, fig.width=7-----------------------------------

# first, divide relevant DAN parcels into groups
dan_labels <- schaefer200_atlas_labels %>%
  filter(network=="DorsAttn") %>%
  mutate(
    dan_group=case_when(
      value %in% c(31, 32, 135, 136) ~ "MT+",
      value %in% c(33:40, 137:144) ~ "PPC",
      value %in% c(41:43, 145:147) ~ "Premotor"
    )
  )

abspe_gg <- ggbrain(bg_color = "gray90", text_color = "black", 
                    base_size = 16, title = "Absolute reward prediction error\n(feedback phase)") +
  images(c(underlay = underlay_file, overlay=abspe_overlay_3mm)) +
  images(c(atlas = schaefer200_atlas_file), labels=dan_labels) +
  slices(c("x = -42", "z = 49")) +
  geom_brain(definition = "underlay") +
  geom_brain(definition = "overlay", fill_scale = scale_fill_gradient("z", low="#006837", high="#d9f0a3"), 
             breaks = range_breaks()) +
  geom_outline(definition = "atlas", mapping = aes(outline = dan_group), 
               outline_scale = scale_fill_brewer("DAN", palette = "Dark2"), show_legend = TRUE, size=2) +
  annotate_coordinates(hjust = 1, color = "black", x = "right", y = "bottom")
  
render(abspe_gg) + plot_layout(nrow = 1, ncol = 2)

## ----fig.height=4, fig.width=7------------------------------------------------

ann <- abspe_gg +
  annotate_slice(x=20, y=20, slice_index=1, geom="text", label="slice1", color="gray40", size=11, hjust=0) +
  annotate_slice(x=20, y=40, slice_index=2, geom="text", label="slice2", color="gray40", size=11, hjust=0)

plot(ann)

## ----fig.height=4, fig.width=7------------------------------------------------

ann <- abspe_gg +
  annotate_slice(x="left", y="top", slice_index=1, geom="text", label="slice1", color="gray40", size=11, hjust=0, vjust=1) +
  annotate_slice(x="right", y="bottom", slice_index=2, geom="text", label="slice2", color="gray40", size=11, hjust=1, vjust=0)

plot(ann)

## ----fig.height=4, fig.width=7------------------------------------------------
ann <- abspe_gg +
  annotate_slice(x="q30", y="q60", slice_index=1, geom="text", label="slice1", color="gray40", size=11, hjust=0, vjust=1) +
  annotate_slice(x="q35", y="q70", slice_index=2, geom="text", label="slice2", color="gray40", size=11, hjust=0.5, vjust=0)

plot(ann)


## ----fig.height=4, fig.width=7------------------------------------------------
ann <- abspe_gg +
  annotate_slice(xmin="q0", xmax="q38", ymin="q25", ymax="q59", slice_index=1, geom="rect", 
                 color="blue", fill="transparent", linewidth=1.5)
plot(ann)


## ----fig.height=4, fig.width=7------------------------------------------------
ann <- abspe_gg +
  geom_region_label(image="atlas", label_column="MNI_Glasser_HCP_v1.0", size=3, color="black")
# 
#   geom_region_label_repel(image = "dan_clust", label_column = "value", min.segment.length = 0, size=3,
#                           color="black", force_pull=0, force=1.5, max.overlaps=Inf, box.padding = 0.5, label.padding=0.15, min_px = 20) +

plot(ann)


## ----echo=FALSE---------------------------------------------------------------
knitr::kable(schaefer200_atlas_labels %>%
  filter(!is.na(custom_label)) %>% select(c(MNI_Glasser_HCP_v1.0, custom_label))) %>% head(n=6)

## ----fig.height=4, fig.width=7------------------------------------------------
ann <- abspe_gg +
  geom_region_label(image="atlas", label_column="custom_label", size=3, color="black")
# 
#   geom_region_label_repel(image = "dan_clust", label_column = "value", min.segment.length = 0, size=3,
#                           color="black", force_pull=0, force=1.5, max.overlaps=Inf, box.padding = 0.5, label.padding=0.15, min_px = 20) +

plot(ann)


