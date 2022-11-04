## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, dev.args=list(bg="gray80"))
library(ggbrain)
library(ggplot2)
library(patchwork)

# MNI 2009c anatomical underlay
underlay_3mm <- system.file("extdata", "mni_template_2009c_3mm.nii.gz", package = "ggbrain")

# onset of decision phase for learning task
decision_onset_3mm <- system.file("extdata", "decision_onset_zstat_3mm.nii.gz", package = "ggbrain")

# Parametric modulator: entropy change following feedback in learning task
echange_overlay_3mm <- system.file("extdata", "echange_overall_zstat_3mm.nii.gz", package = "ggbrain")

# Parametric modulator: signed reward prediction error following feedback in learning task
# thresholded to be whole-brain significant at FWE p < .05 using pTFCE
pe_overlay_3mm <- system.file("extdata", "pe_ptfce_fwep_0.05.nii.gz", package = "ggbrain")

# Parametric modulator: absolute reward prediction error following feedback in learning task
# thresholded to be whole-brain significant at FWE p < .05 using pTFCE
abspe_overlay_3mm <- system.file("extdata", "abspe_ptfce_fwep_0.05.nii.gz", package = "ggbrain")


## -----------------------------------------------------------------------------
print(c(underlay_3mm, decision_onset_3mm, echange_overlay_3mm, pe_overlay_3mm, abspe_overlay_3mm))

## ---- eval=FALSE--------------------------------------------------------------
#  install.packages("ggbrain")

## ---- eval=FALSE--------------------------------------------------------------
#  devtools::install_github("michaelhallquist/ggbrain")

## -----------------------------------------------------------------------------
gg_obj <- ggbrain()

## -----------------------------------------------------------------------------
plot(gg_obj)

## -----------------------------------------------------------------------------
gg_obj <- gg_obj + images(c(underlay = underlay_3mm))

## -----------------------------------------------------------------------------
gg_obj <- ggbrain() + 
  images(c(underlay = underlay_3mm, echange = echange_overlay_3mm))

## -----------------------------------------------------------------------------
gg_obj <- ggbrain() +
  images(c(underlay = underlay_3mm)) +
  images(c(echange = echange_overlay_3mm))

## -----------------------------------------------------------------------------
gg_obj <- gg_obj + slices(c("x = 10", "y = 70", "z = 15"))

## -----------------------------------------------------------------------------
gg_obj <- gg_obj + slices(c("x = 25%", "y = 50%", "z = 90%"))

## -----------------------------------------------------------------------------
gg_obj <- gg_obj +
  slices(
    c("x = 25%", "x = 50%"),
    bg_color = "gray25", xlab = "x axis", theme_custom = theme(axis.text.x = element_text(size = 24))
  )

## -----------------------------------------------------------------------------
gg_obj <- gg_obj + slices(montage("axial", 10, min = 0.1, max = 0.8))

## -----------------------------------------------------------------------------
gg_obj <- gg_obj + slices(montage("sagittal", 5, min_coord = -10, max_coord = 10))

## -----------------------------------------------------------------------------
# define a reusable object that has the same images and slices
gg_base <- ggbrain(bg_color = "gray80", text_color = "black") +
  images(c(underlay = underlay_3mm, overlay = echange_overlay_3mm)) +
  slices(c("x = 10", "y = 70", "z = 15"))


## -----------------------------------------------------------------------------
gg_obj <- gg_base +
  geom_brain(definition = "underlay", fill_scale = scale_fill_gradient(low = "grey8", high = "grey62"), show_legend = FALSE) +
  geom_brain(definition = "overlay", fill_scale = scale_fill_bisided(), show_legend = TRUE)

## ---- fig.width=8, fig.height=3.5---------------------------------------------
gg_obj$render()

## ---- fig.width=8, fig.height=3.5---------------------------------------------
gg_obj <- gg_base +
  geom_brain(definition = "overlay[abs(overlay) > 2.5]", fill_scale = scale_fill_bisided(), show_legend = TRUE)

plot(gg_obj)

## ---- fig.width=8, fig.height=3.5---------------------------------------------
gg_obj <- gg_base +
  geom_brain(definition = "underlay") +
  geom_brain(definition = "overlay[underlay > 10]", fill_scale = scale_fill_bisided(), show_legend = TRUE)

plot(gg_obj)

## ---- fig.width=8, fig.height=3.5---------------------------------------------
gg_obj <- gg_base +
  geom_brain(definition = "underlay") +
  geom_brain(
    definition = "overlay[abs(overlay) > 2.5 & underlay > 20]",
    fill_scale = scale_fill_bisided("z"), show_legend = TRUE
  )

plot(gg_obj)

## ---- fig.width=8, fig.height=3.5---------------------------------------------
gg_obj <- ggbrain(bg_color = "gray80", text_color = "black") +
  images(c(underlay = underlay_3mm, pe = pe_overlay_3mm, abspe = abspe_overlay_3mm)) +
  slices(c("x = 10", "y = 50", "z = 15")) +
  define("diff := pe - abspe") +
  geom_brain(definition = "underlay") +
  geom_brain(definition = "diff", fill_scale = scale_fill_bisided(symmetric = FALSE), show_legend = TRUE)

plot(gg_obj)

## -----------------------------------------------------------------------------
gg_obj <- ggbrain(bg_color = "gray80", text_color = "black") +
  images(c(underlay = underlay_3mm, pe = pe_overlay_3mm, abspe = abspe_overlay_3mm)) +
  slices(c("x = 10", "y = 50", "z = 15")) +
  geom_brain(definition = "diff := pe - abspe", fill_scale = scale_fill_bisided(symmetric = FALSE), show_legend = TRUE)

## ---- fig.width=8, fig.height=3.5---------------------------------------------
gg_obj <- ggbrain(bg_color = "gray80", text_color = "black") +
  images(c(underlay = underlay_3mm, pe = pe_overlay_3mm, abspe = abspe_overlay_3mm)) +
  slices(c("x = 10", "y = 50", "z = 15")) +
  define("diff := pe - abspe") +
  geom_brain(definition = "underlay") +
  geom_brain(definition = "diff[diff > 3]", fill_scale = scale_fill_distiller("PE > absPE", palette="Reds"), show_legend = TRUE)

plot(gg_obj)

## ---- warning=FALSE, message=FALSE, fig.width=8, fig.height=3.5---------------
gg_obj <- ggbrain() +
  slices(c("x = -2", "x=2", "y = 40", "z = 15")) +
  images(c(underlay = underlay_3mm, onset = decision_onset_3mm)) +
  geom_brain(definition = "underlay") +
  geom_outline(definition = "onset[abs(onset) > 3]", size = 1, outline = "cyan")

plot(gg_obj)

## ---- warning=FALSE, message=FALSE--------------------------------------------
# without a render step
gg_obj <- ggbrain() +
  slices(c("x = -2", "x=2", "y = 40", "z = 15")) +
  images(c(underlay = underlay_3mm, onset = decision_onset_3mm)) +
  geom_brain(definition="underlay") +
  geom_outline(definition = "onset[abs(onset) > 3]", size=1, outline="cyan")

class(gg_obj)

# note the different class after render
gg_obj <- ggbrain() +
  slices(c("x = -2", "x=2", "y = 40", "z = 15")) +
  images(c(underlay = underlay_3mm, onset = decision_onset_3mm)) +
  geom_brain(definition="underlay") +
  geom_outline(definition = "onset[abs(onset) > 3]", size=1, outline="cyan") +
  render()

class(gg_obj)

## ----  warning=FALSE, message=FALSE, fig.width=8, fig.height=3.5--------------

# add a different theme to all panels and add an overall title
gg_obj + plot_annotation(title="Overall title") & theme_minimal()


## ---- warning=FALSE, message=FALSE, fig.width=8, fig.height=3.5---------------
gg_obj <- ggbrain() +
  slices(c("x = -2", "x=2", "y = 40", "z = 15")) +
  images(c(underlay = underlay_3mm, onset = decision_onset_3mm)) +
  geom_brain(definition="underlay") +
  geom_outline(definition = "onset[abs(onset) > 3]", size=1, outline="cyan")

plot(gg_obj) + plot_annotation(title = "Overall")

## ---- warning=FALSE, message=FALSE--------------------------------------------
td <- tempdir()
ggsave(filename=file.path(td, "my_brain_plot.pdf"), gg_obj$render(), width=15, height=10)

## ---- warning=FALSE, message=FALSE--------------------------------------------
pdf(file.path(td, "my_brain_plot_2.pdf"), width=10, height=10)
plot(gg_obj)
dev.off()

## ----warning=FALSE, message=FALSE---------------------------------------------
pdf(file.path(td, "my_brain_plot_2.pdf"), width=10, height=10, bg="gray80")
plot(gg_obj)
dev.off()

## ----cleanup, include=FALSE, message=FALSE------------------------------------
unlink(file.path(td, c("my_brain_plot_2.pdf", "my_brain_plot.pdf")))

