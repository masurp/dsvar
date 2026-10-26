# The course datasets

> Licences are summarised here for working purposes. The **published** statement,
> which is what the CC BY conditions actually attach to, is the site colophon at
> `credits.qmd`. Keep the two in step.

Every dataset any gallery exhibit uses is committed in `data/raw/`, cleaned only
as far as subsetting and renaming. Nothing here is fetched at render time — the
site builds offline, and an exhibit cannot silently change because an upstream
file was revised. To refresh: `Rscript R/fetch-gallery-data.R`.

These are also the pool to draw on for **lecture slides and work group
exercises**. Each one is small, open, and already has a worked exhibit showing
what it can carry.

## Publishing these files

**Serving a file is publishing it.** `_quarto.yml` lists, file by file, which
of these the site serves at a public URL; the *Served* column below says the
same. A file added here is not served until it is added there, and it should
not be added there until its row below names a licence that permits
redistribution — showing a chart under the citation right is a different and
weaker permission than handing out the data.

The site's own CC BY 4.0 does **not** cover these files. Each keeps the licence
in its row, and three of them carry share-alike conditions that travel with
the file: `hyg-stars.csv` and `vdem-indices.csv` (CC BY-SA 4.0) and
`cp1919-pulsar.csv` (CC BY-NC-SA 4.0). Licences were checked against each
source's own terms on 2026-10-09.

**HadCRUT5's licence names its own acknowledgement**, which must appear
wherever the data are used:

> HadCRUT.5.0.2.0 data were obtained from http://www.metoffice.gov.uk/hadobs/hadcrut5
> on 16 September 2026 and are © British Crown Copyright, Met Office 2020,
> provided under an Open Government License,
> http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/

with the citation Morice, C. P. et al. (2021), *JGR Atmospheres* 126(3),
doi:10.1029/2019JD032361. The generic OGL line is not the right one here.

## What is here

| File | Rows | What it is | Licence | Served | Used by |
|---|---|---|---|---|---|
| `hadcrut5-global-annual.csv` | 176 | Global mean temperature anomaly, 1850–2025, with 95% CIs | Open Government Licence v3; the Met Office's acknowledgement wording is required (see below) | yes | week 1 and week 5 lectures; warming-stripes |
| `gistemp-glb.csv` | 147 | NASA GISTEMP global means, monthly + annual, 1880– | US public domain (NASA); credit NASA GISS/GISTEMP | yes | vendored, read by nothing yet (see planning/data-map.md) |
| `hadcrut5-global-monthly.csv` | 2,102 | Same series, monthly, 1850-01– , with 95% CIs | Open Government Licence v3; acknowledgement as for the annual file | yes | week 5 lecture (the climate spiral) |
| `cpc-nino34-weekly.csv` | 2,350 | Niño 3.4 sea surface temperature **and** anomaly, weekly, 1981-09– | US public domain (NOAA CPC); reshaped here, not official NOAA output | yes | week 5 lecture (the NYT ENSO tracker; trend vs noise) |
| `knmi-de-bilt-monthly.txt` | 126 | De Bilt monthly mean temperature, 1901–, **as KNMI serves it**: 13-line preamble, months as columns, tenths of a degree | Free to use with the source acknowledged: KNMI (file header); CC BY 4.0 on the KNMI Data Platform | yes | work group 1 |
| `knmi-stations-monthly.csv` | 11,745 | Ten Dutch stations, one row per station-month, in °C, 1901– | As above; reshaped and converted to °C here | yes | work group 5 |
| `owid-covid-deaths-2020.csv` | 4,719 | COVID deaths, 13 countries, 2020 | CC BY 4.0 (WHO via Our World in Data; JHU CSSE before 2023, also CC BY 4.0) | yes | pandemic-trajectories |
| `owid-extreme-poverty-1820-2015.csv` | 24 | World population living and not living in extreme poverty, 1820–2015 | Ravallion, Bourguignon & Morrisson, and World Bank, processed by Our World in Data; World Bank part CC BY 4.0, the pre-1981 part an insubstantial extract of published figures | yes | extreme-poverty |
| `gapminder.csv` | 1,704 | Income, life expectancy, population; 142 countries, 1952–2007 | CC BY 4.0 (Gapminder); required wording "Based on free material from GAPMINDER.ORG, CC-BY LICENSE" | yes | work groups 3 and 4; gapminder |
| `gapminder-world-2015.csv` | 193 | Income (2011 PPP), life expectancy, population and Gapminder's four regions, 2015, as Gapminder had them on 2016-10-31: the Gapminder World 2015 poster's own data | CC BY 4.0 (Gapminder, open-numbers repository); same required wording | yes | gapminder (the recreation only) |
| `openbible-cross-references.csv` | 117,200 | Bible cross-references, verse to verse, with readers' votes; links with 5 votes or more, from the export of 2026-10-12 | CC BY 4.0 (OpenBible.info); mostly from the public-domain *Treasury of Scripture Knowledge* | yes | bible-cross-references |
| `openbible-chapters.csv` | 1,189 | The Bible's chapters in canonical order, with verse counts (highest verse cited in OpenBible's full file) | CC BY 4.0 (derived from OpenBible.info) | yes | bible-cross-references |
| `florida-firearm-murders.csv` | 48 | Florida murders by firearm, 1971–2020 | Florida public record (FDLE); counts are facts | yes | week 1 lecture; gun-deaths-florida |
| `iraq-body-count-yearly.csv` | 15 | Documented civilian deaths, 2003–2017 | © Iraq Body Count; free for not-for-profit use citing iraqbodycount.org, written agreement for institutional use. **Not served** | no | iraq-bloody-toll |
| `hyg-stars.csv` | 67,074 | Stars within 250 pc: magnitude, colour index, distance | **CC BY-SA 4.0** (astronexus); this subset is CC BY-SA too | yes | week 4 lecture; hertzsprung-russell |
| `cp1919-pulsar.csv` | 80 × 300 | Radio pulses from CP 1919, digitised from Craft (1970) | **CC BY-NC-SA 4.0** (Þorsteinsson, after Zöllner's CC BY-NC-SA 3.0 tracing); non-commercial, share alike | yes | week 3 lecture (the ridgeline); unknown-pleasures |
| `datasaurus.csv` | 1,846 | 13 datasets with identical summary statistics | MIT (`datasauRus` package); no licence from Autodesk, which welcomed redistribution | yes | week 1 and week 3 lectures; datasaurus |
| `nightingale.csv` | 24 | Crimean War mortality by month and cause | Public domain source (1858); extracted from `HistData` (GPL) | yes | week 7 lecture; nightingale |
| `snow-deaths.csv`, `snow-pumps.csv`, `snow-streets.csv` | 578 / 13 / 1,241 | Broad Street cholera outbreak, digitised | Public domain source (1855); Dodson & Tobler digitisation via `HistData` (GPL) | yes | week 6 lecture (the cold open); snow |
| `polblogs-nodes.csv`, `polblogs-edges.csv` | 1,490 / 19,090 | The 2004 US political blogosphere: blogs with a hand-coded lean, and the links between them | No formal licence: "free for scientific use" (Newman, with Adamic's permission); cite Adamic & Glance (2005) | yes | week 6 lecture (layout); media-ecosystem |
| `minard-troops.csv`, `minard-cities.csv`, `minard-temp.csv` | 51 / 20 / 9 | Napoleon's 1812 campaign, digitised by Wilkinson | Public domain source (1869); Wilkinson's digitisation via `HistData` (GPL) | yes | minard |
| `playfair-wheat.csv` | 53 | Playfair's price of a quarter of wheat (shillings) and a good mechanic's weekly wage (shillings), every five years 1565–1821; wages end in 1810. Digitised from his 1821 Chart No. 1 (`HistData::Wheat`) | Public domain source (1821); GPL in `HistData` | yes | playfair-wheat; week 5 lecture |
| `playfair-monarchs.csv` | 12 | Reigns from Elizabeth to George IV, as drawn along the top of the chart (`HistData::Wheat.monarchs`) | Public domain source (1821); GPL in `HistData` | yes | playfair-wheat |
| `langren-1644.csv` | 12 | Twelve estimates of the longitude from Toledo to Rome, from Ptolemy to van Langren's contemporaries, digitised from his 1644 graph (`HistData::Langren1644`) | Public domain source (1644); digitisation by Friendly et al., CC BY-NC 3.0 at datavis.ca and GPL in `HistData` | yes | van-langren |
| `lakner-milanovic-gic-1988-2008.csv` | 21 | The elephant curve: real income growth 1988–2008 by global income percentile, digitised from Figure 1(a) of Lakner & Milanovic (2013) by `R/digitise-elephant.R` | CC BY 3.0 IGO (World Bank, WPS 6719) | yes | elephant-curve |
| `rozado-headline-sentiment.csv` | 679 | Mean headline sentiment per outlet and year, 47 US outlets, 2000–2019, from two classifiers, with headline counts (Rozado et al. 2022) | CC BY 4.0 (Zenodo 10.5281/zenodo.5144113); aggregated here | yes | headline-sentiment |
| `pisa-2022-math.csv` | 81 | PISA 2022 mathematics: mean, standard error, coverage and caution flags, comparison with the US, and counts of significantly higher, lower and not-different systems | OECD data terms (free reuse with credit to the OECD, and that credit requirement passed on); NCES pages US public domain | yes | pisa-league-table |
| `silberzahn-effects.csv` | 29 | 29 analysis teams' effect estimates | CC0 1.0 (osf.io/gvm2z) | yes | week 3 lecture (twenty nine teams); many-analysts |
| `pairfam-synth.csv` | 3,132 | **Synthetic** stand-in for one wave of pairfam: adolescent media use, self esteem, depression, life and friend satisfaction | CC BY 4.0 (ccs-amsterdam/r-course-material); **synthetic, not real survey data**; `id` replaced by row number here | yes | week 3 lecture (cold open; the normal fit; bandwidth and heaping; the specification curve); specification-curve |
| `rpp-replications.csv` | 168 | Reproducibility Project: Psychology, original vs replication | CC0 1.0 (osf.io/ezcuj) | yes | week 4 lecture (the diagonal); replication |
| `bcg-trials.csv` | 13 | BCG vaccine trials: TB counts by arm, absolute latitude, allocation method (`dat.bcg`) | GPL ≥ 2 (`metadat`); trial counts from Colditz et al. (1994) | yes | forest-plot |
| `masur-parry-study1_data.csv` | 590 | Masur & Parry (2026) study 1 | CC BY 4.0 (osf.io/zw6pb). **Not served**: raw export, OSF holds the public copy | no | week 3 lecture (binwidth; the intervals; the ceiling; the build); conditional-effects |
| `masur-parry-study2_data.csv` | 1,714 | Masur & Parry (2026) study 2, feed experiment | CC BY 4.0 (osf.io/zw6pb). **Not served**: raw export, OSF holds the public copy | no | vendored, read by nothing yet |
| `us-county-2020-president.csv` | 3,152 | 2020 presidential election by county: votes, shares, margin | MIT (Tony McGovern), scraped from Fox News, Politico and the New York Times; vote counts are facts | yes | week 1 and week 6 lectures; cartograms |
| `worldbank-indicators.csv` | 117 | World Development Indicators: life expectancy, GDP per capita, tertiary enrolment, urbanisation, fertility, female labour, internet use, over-65 share, growth, Gini | CC BY 4.0 (World Bank WDI); every indicator used is CC BY 4.0 in the WDI metadata | yes | work groups 2 and 6; week 7's demonstration |
| `fred-us-annual.csv` | 98 | CPI-U (annual mean), median household income nominal and real, real GDP, federal minimum wage; 1929– | US public domain (BLS, Census, BEA, DOL), via FRED; cite as "Source: <agency> via FRED" | yes | week 2 lecture (cold open; real vs nominal; the minimum wage) |
| `fred-us-monthly.csv` | 284 | CPI-U and Federal Reserve total assets, monthly, 2002-12– | US public domain (BLS, Federal Reserve Board), via FRED | yes | week 2 lecture (the dual axis) |
| `fred-state-income.csv` | 2,142 | Median household income for the 50 states and DC, nominal and real, 1984– | US public domain (Census), via FRED | yes | week 2 lecture (the ranking; the build; the slopegraph); week 3 lecture (the ridgeline) |
| `fred-gdp-per-capita.csv` | 528 | GDP per capita, constant 2015 US$, eight countries, 1960– | CC BY 4.0 (World Bank WDI), via FRED | yes | week 2 lecture (log against linear) |
| `bis-house-prices.csv` | 1,405 | BIS real residential property price index, quarterly, six countries, 2010 = 100 | BIS statistics, unrestricted use with the BIS cited as source (data.bis.org/help/legal); national sources, via FRED | yes | week 2 lecture (index to 100) |
| `vdem-indices.csv` | 535 | V-Dem's five high-level democracy indices and regime type, 179 countries, 2005 / 2015 / 2025 | **CC BY-SA 4.0** (V-Dem); this extract is CC BY-SA too. Dataset **v16** (Coppedge et al. 2026) | yes | week 2 lecture (rank depends on the index) |

## Not in this folder

Two exhibits use data that ships with R, so there is nothing to vendor and
nothing that can go stale:

- **sankey** — `datasets::Titanic`
- **outbreak-simulation** — generates its own data, seeded for reproducibility

**cartograms** vendors its results file but takes the county and state outlines
from `ggplot2::map_data()` and `maps::county.fips`, which also ship with R.

## Notes for reuse

**The work groups never run on the lecture's data.** Weeks 1 and 5 lecture on
HadCRUT5 and Niño 3.4; their Thursdays get the KNMI station record. Week 2
lectures on FRED and V-Dem; its Thursday gets the World Bank file. Keep it that
way when adding a dataset: if a file is in a deck, it is not for the lab.
`planning/data-map.md` is the file-by-file record, generated from the code.

`knmi-de-bilt-monthly.txt` is deliberately not cleaned. `read_csv(skip = 13)`
reads it; the months are in tenths of a degree; the current year's later months
are blank. Week 1 meets those three facts as its first exercise. The station
record is the raw one — KNMI publishes a separately homogenised De Bilt series
because instruments and surroundings changed, most sharply around 1950 — so a
claim about 1901 versus today should say so. In `knmi-stations-monthly.csv` the
stations start in different years (De Bilt 1901, four more from 1906, the rest
from 1951 or 1957): a naive all-station mean changes composition in 1951.

`iraq-body-count-yearly.csv` was transcribed by hand from IBC's database page
(IBC now offers a CSV download there too); check it against the site before
using it in anything assessed. **It is not served.** IBC's material is free for
not-for-profit use citing iraqbodycount.org, but its conditions ask research
organisations for a written agreement before institutional use of the data. The
exhibit draws nine annual totals at render time with IBC named, which is the
kind of brief citation IBC allows without permission; handing out the file is
not.

`florida-firearm-murders.csv` was parsed from a PDF served via the Internet
Archive because FDLE's live site refuses connections. The gaps are of two
kinds, and they are not the same kind: **1988 is present with `NA`** in both
murder columns, while **2016 and 2018 are absent as rows entirely**. So a span
is not the same as a count here — 1990 to 2020 is 31 calendar years and 29
observations. Anything stating an n off this file should count rows rather than
subtract years.

`masur-parry-*` are the raw Qualtrics exports, byte-identical to the files on
OSF (osf.io/zw6pb, CC BY 4.0). The scale means and experimental condition
variables are constructed in the exhibit pages, not here, so a lab using these
has the same work to do that the exhibits show — which is probably what you
want for an exercise. **They are not served**: they carry second-level
timestamps and free-text answers, and study 2's `id` joins to the app log on
OSF, so the site points to OSF rather than adding a second public copy. One
study 1 respondent reports age 12, and ages above 100 are birth years typed
into the age field.

Two properties of `masur-parry-study1_data.csv` that week 4's lecture is built
on, and which the published paper does not report, because they are teaching
material rather than findings. The descriptive-norm measure is a **three-item
mean on a seven-point scale**, so it takes exactly **19 values, spaced 1/3
apart**, and a histogram with bins finer than 1/3 has empty bins for that
reason alone. And **17.8% of the sample sits exactly on the 7 ceiling** (29.5%
in the high-prevalence condition), so a mean and an SD describe a shape the
scale cannot hold. Both are properties of this sample.

`pairfam-synth.csv` is **synthetic**. It was built to have properties close to
one wave of the real pairfam survey and it is not data about any real
adolescent — nothing off it is a fact about German teenagers, and every chart
in the course that uses it says so on the slide. It is here because the real
survey cannot be redistributed and because the synthetic version has the
properties the teaching needs: `sns_use` is genuinely bimodal (373 at zero,
1,102 at five, and only 15.8% of the sample within half a point of the mean),
and `internet_use` and `tv_use` carry realistic **digit heaping** — 55% of
internet-use answers are multiples of five where precise answering would give
20%.

Its `id` column is **not** the upstream one. The ccs-amsterdam file carries IDs
up to 749,731,000, all multiples of 1,000 and 2,000 distinct over 3,132 rows —
the shape of real pairfam person IDs — so `R/fetch-gallery-data.R` replaces it
with the row number. Nothing reads `id`.

`worldbank-indicators.csv` is one row per country at the most recent year each
indicator is available, which means the rows are **not all the same year**. That
is fine for a cross-sectional comparison and wrong for anything about change
over time; a chart off this file should say "most recent year available" rather
than name one. `iso3` is carried so charts too small for country names have
something to label bars with.

**The FRED files** (`fred-*.csv`, `bis-house-prices.csv`) all come off one URL
pattern with no API key — `fredgraph.csv?id=<SERIES>` — and FRED is a *host*,
not a source: the licence follows the originating agency, which every caption
names. FRED's own terms restrict republishing "FRED Content", but its legal
page lets the series marked "Public Domain: Citation Requested" (every US one
here, and the World Bank's) be used without permission, cited as "Source:
<agency> via FRED". The BIS series is "Copyrighted: Citation Required", and
BIS's terms for its statistics allow unrestricted use with the BIS cited as
source. If FRED ever tightens this, the clean fix is to refetch from the
agencies themselves. Nothing was deflated or indexed in the fetch on purpose; week 3 teaches
both as `mutate()` steps and the slides do the work visibly. Two things worth
knowing before reuse: the real income series (`*A672N`) is stated in the
*latest* year's CPI-U-RS dollars, so real equals nominal in that year and the
whole series shifts when Census adds a year; and `fred-us-annual.csv` is a
merge of series with different spans, so most columns are `NA` before 1984.
No stock index is vendored — the exchanges' series on FRED are copyrighted —
and the dual-axis case runs on the Fed's balance sheet against the CPI instead.

**`vdem-indices.csv`** is 535 rows cut from the 34 MB `vdem.RData` in the
`vdemdata` GitHub package, which is how V-Dem distributes the dataset to R
users. It carries point estimates only; V-Dem publishes a credible interval on
every index, and a chart ranking countries off this file should say that
adjacent ranks are not distinguishable. It is **v16**: the file has rows for
2025, which v15 does not reach. Citation: Coppedge, M. et al. (2026), *V-Dem
Dataset v16*, Varieties of Democracy (V-Dem) Project,
doi:10.23696/vdemds26. Licensed CC BY-SA 4.0, so this extract is too.

`cp1919-pulsar.csv` is **not a digitisation of Craft's plot**. It is
byte-identical to `pulsar.csv` in igorol/unknown_pleasures_plot, which took it
from Borgar Þorsteinsson's gist (CC BY-NC-SA 4.0), which approximates Michael
Zöllner's hand tracing of the *album cover* (CC BY-NC-SA 3.0). Its licence is
therefore CC BY-NC-SA: fine on a non-commercial teaching site, with both named,
but it cannot sit under the site's CC BY. The igorol repository's MIT licence
does not relicense it.

`us-county-2020-president.csv` is the compiler's own tally rather than an
official federal source — there is no single federal county-level file. Its
national totals match the certified result (81,264,994 to 74,208,196), which is
the check worth repeating before using it for anything assessed. McGovern's
README says the 2020 numbers were scraped from Fox News, Politico and the New
York Times; it is not MIT Election Lab data, and captions should not say so.

Sizes: `data/raw/` is about 6.2 MB in total, of which `hyg-stars.csv` is 3.3 MB.
