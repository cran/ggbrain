## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(ggbrain)

## -----------------------------------------------------------------------------
# MNI 2009c anatomical underlay
underlay_3mm <- system.file("extdata", "mni_template_2009c_3mm.nii.gz", package = "ggbrain")

# onset of decision phase for learning task
decision_onset_3mm <- system.file("extdata", "decision_onset_zstat_3mm.nii.gz", package = "ggbrain")

# Parametric modulator: entropy change following feedback in learning task
echange_overlay_3mm <- system.file("extdata", "echange_overall_zstat_3mm.nii.gz", package = "ggbrain")

# Schaefer 200-parcel atlas of cortex
schaefer200_atlas_3mm <- system.file("extdata", "Schaefer_200_7networks_2009c_3mm.nii.gz", package = "ggbrain")

print(c(underlay_3mm, decision_onset_3mm, echange_overlay_3mm, schaefer200_atlas_3mm))

## ----eval=FALSE---------------------------------------------------------------
# # TODO: make this in geom_brain
# gg_obj <- gg_obj + images(echange=echange_overlay_3mm)

## ----eval=FALSE---------------------------------------------------------------
# # TODO: make this in geom_Brain
# gg_obj <- gg_obj + images(echange=echange_overlay_3mm)

## ----eval=FALSE---------------------------------------------------------------
# a <- ggbrain(bg_color = "gray60", text_color = "black") +
#   images(c(underlay = "template_brain.nii.gz")) +
#   images(c(dan_clust = dan_clust), fill_holes = TRUE, clean_specks = 20, labels = dan_labels) +
#   # slices(paste0("x = ", seq(10, 90, 10), "%")) +
#   slices(montage("axial", 10, min = 0.1, max = 0.8)) +
#   # add_slice("y=50%", title = "hello", xlab = "testx", border_size = 1, border_color = "blue") +
#   geom_brain(definition = "underlay", fill_scale = scale_fill_gradient(low = "grey8", high = "grey62"), show_legend = FALSE) +
#   geom_brain(definition = "dan_clust", mapping = aes(fill = label), fill_scale = scale_fill_brewer("DAN 17 label", palette = "Set1"), show_legend = TRUE) +
#   geom_outline(definition = "dan_clust", mapping = aes(group = roi_label), show_legend = TRUE, outline = "black") + # fill_scale = scale_fill_discrete("hello"),
#   # geom_outline(definition = "dan_clust", show_legend = TRUE, mapping=aes(group=label), size=2, outline="cyan") + #fill_scale = scale_fill_discrete("hello"),
# 
#   # geom_outline(definition = "dan_clust", show_legend = TRUE, outline = "cyan") + #fill_scale = scale_fill_discrete("hello"),
# 
#   geom_region_label_repel(image = "dan_clust", label_column = "roi_label", min.segment.length = 0, size = 1.5, color = "black", force_pull = 0.2, max.overlaps = Inf) +
#   render() + plot_layout(guides = "collect")

