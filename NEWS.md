# faux 0.0.0.9017 (2019-12-26)

* Added `rep` argument to `sim_design()` and `sim_data()`. If rep > 1, returns a nested data frame with `rep` simulated datasets.
* Fixed warnings on `get_params()`
* Improved `make_id()` function

# faux 0.0.0.9016 (2019-12-10)

* Removed ANOVApower

# faux 0.0.0.9015 (2019-07-22)

* Added distribution conversion functions (still experimental)

# faux 0.0.0.9014 (2019-06-09)

* More flexible parameter specification
* Set plotting default as a global option `faux_options(plot = TRUE)`
* Minor bug fixes and efficiency increases

# faux 0.0.0.9013 (2019-05-27)

* multi-factor cell names now in a more intuitive order (**will break old code that inputs parameters with unnamed vectors**)
* More flexible plotting styles (violin, jitter, box, pointrange with SD or SE, and combos)
* Minor bug fixes

# faux 0.0.0.9012 (2019-05-22)

* More flexible plots and data plots
* Setting seed doesn't change the seed in your global environment
* Plot labels for dv and id (set them like `dv = list(colname = "Name for Plots")`)

# faux 0.0.0.9011 (2019-05-19)

* Changed default DV column name from 'val' to 'y'
* Changed default ID column name from 'sub_id' to 'id'
* `sim_design()` can take intercept-only designs
* `rnorm_multi()` can take vars = 1 for intercept-only designs
* `json_design()` to output or save design specs in JSON format
* Added functions for converting between distributions

# faux 0.0.0.9010

* Fixed bugs in interactive specification
* Added `messy()` (thanks Emily)
* Better interactive specification (thanks Daniël)

# faux 0.0.0.9009

* Bug fix for `long2wide()` (handle designs with no between or no within factors)
* `sim_df()` returns subject IDs and takes data in long format
* Renamed `check_sim_stats()` to `get_params()`, which now returns the design
* Added interactive option to `sim_design()`

# faux 0.0.0.9008

* added `sim_mixed_cc()` to simulate null cross-classified mixed effect designs by subject, item and error SDs
* `sim_design()`, `sim_df()`, `sim_mixed_cc()` and `sim_mixed_df()` take a `seed` argument now for reproducible datasets

# faux 0.0.0.9007

* Added a plot option to `check_design()` and `sim_design()`
* Design lists returned by `check_design()` have a more consistent format 
    - n, mu, and sd are all data frames with between-cells as rows and within-cells as columns
    - `within` and `between` are named lists; factors and labels are no longer separately named

# faux 0.0.0.9006

* Changes to argument order and names (more consistent, but may break old scripts)
* Updated vignettes

# faux 0.0.0.9005

* Bug fixes for `sim_design()` (failed when within or between factor number was 0)

# faux 0.0.0.9004

* Added a `NEWS.md` file to track changes to the package.
* Added `sim_design()` to simulate data for mixed ANOVA designs.

