# =============================================================================
# theme_dsvar() — the course's ggplot theme.
#
# THE RULE THIS FILE EXISTS FOR: every chart on a slide and on the site is made
# in ggplot, with this theme, because students make their charts in ggplot too.
# A figure in the lecture that a student could not have produced undercuts the
# argument the course is making. Iconic historical originals (Minard,
# Nightingale, Snow) are the one exception — there the artefact is the point.
#
# The palette below is the SAME palette as assets/_dsvar-components.scss. The
# hexes are duplicated here rather than read from the SCSS, because knitr has no
# way to resolve a CSS custom property — so when a token changes there, change
# it here. The pairs are listed side by side to make that mechanical.
#
# Usage in a deck or page:
#     source(here::here("R", "theme-dsvar.R"))
#     ggplot(...) + theme_dsvar()
#     ... + scale_colour_dsvar_o()   # ordered variable, the move ramp
#     ... + scale_colour_dsvar_d()   # unordered categories
#
# Decks render on a light ground; set `dark = TRUE` for a {.dark} slide.
# =============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
})

# --- typography --------------------------------------------------------------
# The decks set their body face in CSS (IBM Plex Sans), but a ggplot chart is
# rendered by ragg, which can only use fonts INSTALLED ON THIS MACHINE. If the
# deck face is missing the chart comes out in a typeface that does not match the
# slide it sits on — on a course about design consistency, worse than it sounds.
#
#   macOS:  brew install --cask font-ibm-plex-sans
#   else:   https://fonts.google.com/specimen/IBM+Plex+Sans
#
# THE BOLD PROBLEM, and why this is more code than it looks like it should be.
# On systemfonts 1.1.0 under recent macOS, system_fonts() lists Helvetica Bold
# and Arial Bold correctly, and match_fonts() then hands back `unfont.ttf` — the
# empty-font placeholder — for EVERY family at bold weight. The visible symptom
# is one "No fonts detected on your system" warning and, much worse, chart
# titles that silently render at regular weight while the rest of the deck is
# bold. Nothing errors, so it is easy to ship a whole deck that way.
#
# The fix is to bypass CoreText matching: look the faces up in system_fonts(),
# which is correct, and bind them to a family name with register_font(), which
# ragg then uses directly. Registration is idempotent and harmless on machines
# where matching already works, so it runs unconditionally.
#
# If systemfonts gains a fix, this whole block can go — check whether
# match_fonts("Helvetica", weight = "bold")$path still ends in unfont.ttf.

# A second failure mode, met on this machine after the font WAS installed:
# system_fonts() enumerated 580 families and none of them was IBM Plex Sans,
# although the .otf files were sitting in ~/Library/Fonts. Enumeration and
# matching are both unreliable here, so the last resort is the file system —
# look for the four faces by filename and register those paths directly.
FONT_FILES <- list(
  "IBM Plex Sans" = c(plain      = "IBMPlexSans-Regular",
                      bold       = "IBMPlexSans-Bold",
                      italic     = "IBMPlexSans-Italic",
                      bolditalic = "IBMPlexSans-BoldItalic")
)

FONT_DIRS <- c("~/Library/Fonts", "/Library/Fonts", "/System/Library/Fonts",
               "~/.fonts", "~/.local/share/fonts", "/usr/share/fonts")

# Returns a register_font()-shaped list, or NULL if the faces are not on disk.
dsvar_font_files <- function(family) {
  stems <- FONT_FILES[[family]]
  if (is.null(stems)) return(NULL)
  dirs <- path.expand(FONT_DIRS)
  dirs <- dirs[dir.exists(dirs)]
  if (!length(dirs)) return(NULL)

  find_one <- function(stem) {
    hits <- list.files(dirs, pattern = paste0("^", stem, "\\.(otf|ttf)$"),
                       full.names = TRUE, ignore.case = TRUE, recursive = TRUE)
    if (length(hits)) hits[1] else NULL
  }
  faces <- lapply(stems, find_one)
  # Regular and bold are the two the theme actually asks for; without both,
  # registering is worse than falling back, because it half works.
  if (is.null(faces$plain) || is.null(faces$bold)) return(NULL)
  Filter(Negate(is.null), faces)
}

dsvar_font <- local({
  resolved <- NULL

  # A family is usable only if it has a real regular AND a real bold. Checked
  # against system_fonts(), never against match_fonts(), for the reason above.
  faces_of <- function(family, fonts) {
    rows <- fonts[fonts$family == family, , drop = FALSE]
    pick <- function(bold, italic) {
      w <- as.character(rows$weight)
      want <- if (bold) c("bold", "semibold", "heavy", "black", "ultrabold")
              else      c("normal", "regular")
      r <- rows[rows$italic == italic & w %in% want, , drop = FALSE]
      if (!nrow(r)) NULL else list(r$path[1], r$index[1])
    }
    out <- list(plain      = pick(FALSE, FALSE),
                bold       = pick(TRUE,  FALSE),
                italic     = pick(FALSE, TRUE),
                bolditalic = pick(TRUE,  TRUE))
    if (is.null(out$plain) || is.null(out$bold)) NULL else out
  }

  function(prefer = c("IBM Plex Sans", "Helvetica", "Arial")) {
    if (!is.null(resolved)) return(resolved)
    if (!requireNamespace("systemfonts", quietly = TRUE)) {
      resolved <<- "sans"
      return(resolved)
    }

    fonts <- systemfonts::system_fonts()
    for (fam in prefer) {
      # Enumeration first, then the file system. On a healthy machine the first
      # one answers; on this one, the preferred family only ever turns up via
      # the second.
      faces <- faces_of(fam, fonts)
      if (is.null(faces)) faces <- dsvar_font_files(fam)
      if (is.null(faces)) next

      # Registered under a stable alias, so every chart in the course asks for
      # the same family name regardless of which machine it renders on.
      do.call(systemfonts::register_font,
              c(list(name = "DSVAR Sans"), Filter(Negate(is.null), faces)))
      resolved <<- "DSVAR Sans"

      if (!identical(fam, prefer[1])) {
        message("theme_dsvar(): '", prefer[1], "' is not installed, falling back to '",
                fam, "'. Chart text will not match the deck's prose. ",
                "Install it: brew install --cask font-ibm-plex-sans")
      }
      return(resolved)
    }

    message("theme_dsvar(): none of ", paste(prefer, collapse = ", "),
            " resolved with both a regular and a bold face; using the device default.")
    resolved <<- "sans"
    resolved
  }
})

# --- tokens ------------------------------------------------------------------
# Mirrors :root and body.quarto-dark in assets/_dsvar-components.scss.

dsvar_light <- list(
  paper    = "#faf8f4",
  surface  = "#ffffff",
  hairline = "#e7e3d9",
  ink      = "#1a1a17",
  ink_2    = "#3a3a34",
  ink_3    = "#5a5a52",
  muted    = "#7a7a70",
  green    = "#2a8558",
  deep     = "#01653d"
)

dsvar_dark <- list(
  paper    = "#002a26",
  surface  = "#003732",
  hairline = "#184d47",
  ink      = "#e7ebea",
  ink_2    = "#ccd8d6",
  ink_3    = "#a2c5c0",
  muted    = "#73a29b",
  green    = "#63ba8a",
  deep     = "#01653d"
)

# The five-stop move ramp. SEQUENTIAL by construction: lightness descends
# monotonically at near-constant chroma and hue drifts only 176 to 140 degrees.
# Use it for anything ordered. It is deliberately NOT a categorical palette —
# adjacent stops are meant to be hard to tell apart out of order, which is the
# property that makes it honest for an ordered variable.
dsvar_ramp_light <- c("#2d9e87", "#1d8d6b", "#1e7c50", "#266937", "#2b5622")
dsvar_ramp_dark  <- c("#1e947e", "#44ab87", "#69c090", "#90d49c", "#b7e7ac")

# Unordered categories need hue separation, not lightness separation, and they
# need to survive colour vision deficiency. This is Okabe-Ito, reordered so the
# first colour is the one closest to the course's green. Use it whenever the
# variable has no order — and if you find yourself wanting a sixth colour, the
# chart probably wants faceting instead.
dsvar_cat <- c(
  "#009E73", # bluish green
  "#0072B2", # blue
  "#D55E00", # vermillion
  "#CC79A7", # reddish purple
  "#E69F00", # orange
  "#56B4E9", # sky blue
  "#F0E442"  # yellow — last on purpose, it is the weakest on light paper
)

dsvar_tokens <- function(dark = FALSE) if (dark) dsvar_dark else dsvar_light

# --- the theme ---------------------------------------------------------------
# base_size is in points and assumes a figure sized for a 1280x720 deck. The
# site renders the same charts smaller; pass base_size = 11 there.

theme_dsvar <- function(base_size = 14,
                        base_family = dsvar_font(),
                        dark = FALSE,
                        grid = "y") {
  p <- dsvar_tokens(dark)

  th <- theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      # The ground is transparent, not paper: a chart sits on whatever slide or
      # page it lands on, and a hardcoded white box on a dark slide is the most
      # common way a deck stops looking like one deck.
      plot.background   = element_rect(fill = NA, colour = NA),
      panel.background  = element_rect(fill = NA, colour = NA),

      # The title carries the claim. It is the most-read line on any chart, so
      # it gets the weight — and it is left-aligned to the panel, not centred
      # over it, so a long claim does not drift.
      plot.title.position = "plot",
      plot.title    = element_text(colour = p$ink, face = "bold",
                                   size = rel(1.15), hjust = 0,
                                   margin = margin(b = 4)),
      plot.subtitle = element_text(colour = p$ink_3, size = rel(0.92), hjust = 0,
                                   margin = margin(b = 12)),

      # The caption is where n, source and the uncertainty note live. Every
      # chart in this course carries one.
      plot.caption.position = "plot",
      plot.caption  = element_text(colour = p$muted, size = rel(0.72), hjust = 0,
                                   margin = margin(t = 12)),

      axis.title    = element_text(colour = p$ink_3, size = rel(0.85)),
      axis.text     = element_text(colour = p$muted, size = rel(0.8)),
      axis.ticks    = element_blank(),
      axis.line.x   = element_line(colour = p$hairline, linewidth = 0.4),

      panel.grid.major = element_line(colour = p$hairline, linewidth = 0.35),
      panel.grid.minor = element_blank(),

      legend.position   = "top",
      legend.justification = "left",
      legend.title      = element_text(colour = p$ink_3, size = rel(0.82)),
      legend.text       = element_text(colour = p$ink_2, size = rel(0.82)),
      legend.key        = element_blank(),

      strip.text    = element_text(colour = p$ink_2, face = "bold",
                                   size = rel(0.85), hjust = 0,
                                   margin = margin(b = 5)),

      plot.margin   = margin(4, 4, 4, 4)
    )

  # Gridlines are a claim about which comparison matters. Default to horizontal
  # only, because most charts here compare values along y.
  if (grid == "y")      th <- th + theme(panel.grid.major.x = element_blank())
  else if (grid == "x") th <- th + theme(panel.grid.major.y = element_blank())
  else if (grid == "none") th <- th + theme(panel.grid.major = element_blank())

  # ggplot2 4 lets a theme set what geoms draw in, not only the text around
  # them. Two things only: the ACCENT is what geom_smooth() and friends use for
  # a fitted line, which is ggplot's blue unless told otherwise, and the FAMILY
  # puts geom_text() and geom_label() in the same type as the axes. Ink stays
  # ggplot's default, so a plain geom_point() still looks like one. Guarded,
  # because element_geom() does not exist before ggplot2 4.0 and the course
  # supports 3.5. Week 7 opens this function up; this is one of the things in it.
  if (utils::packageVersion("ggplot2") >= "4.0.0") {
    th <- th + theme(geom = element_geom(accent = p$green, family = base_family))
  }

  th
}

# --- scales ------------------------------------------------------------------

scale_colour_dsvar_o <- function(dark = FALSE, ...) {
  ggplot2::scale_colour_gradientn(
    colours = if (dark) dsvar_ramp_dark else dsvar_ramp_light, ...)
}
scale_fill_dsvar_o <- function(dark = FALSE, ...) {
  ggplot2::scale_fill_gradientn(
    colours = if (dark) dsvar_ramp_dark else dsvar_ramp_light, ...)
}

scale_colour_dsvar_d <- function(...) ggplot2::scale_colour_manual(values = dsvar_cat, ...)
scale_fill_dsvar_d   <- function(...) ggplot2::scale_fill_manual(values = dsvar_cat, ...)

# British and American spellings both, so nobody has to remember which.
scale_color_dsvar_o <- scale_colour_dsvar_o
scale_color_dsvar_d <- scale_colour_dsvar_d

# One accent colour, for the single-series case — which is most charts.
dsvar_accent <- function(dark = FALSE) dsvar_tokens(dark)$green
