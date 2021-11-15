# UCCCReporter 0.1.4

* Added new cancer cell line ancestry resource.

# UCCCReporter 0.1.3

* Fixed the `census_tract_zip_crosswalk()` resource to allow mapping from tract
to zip. Note that the source data are not reversible; to map from zip to
tract will require a different input. See [documentation](https://www.huduser.gov/portal/datasets/usps_crosswalk.html#codebook).

# UCCCReporter 0.1.2

* Added `cdc_social_vulnerability_index()`. The function reads from a local
download of the data for convenience. 

# UCCCReporter 0.1.1

* Added a `NEWS.md` file to track changes to the package.
