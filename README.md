# covid19-data-analysis-WHO

An R-based data analysis project that aggregates individual patient line-list data to calculate, summarize, and visualize global COVID-19 metrics across different countries using a dataset from the World Health Organiation (WHO).

# Analytical Insights & Key Findings
* Overall Mortality: cleans patient outcomes into binary logic (0 for survival, 1 for death) to establish baseline infection fatality rates.
* Age Disparity: evaluates the claim that deceased patients were older than survivors. A  Two Sample t-test reveals an approximate 20-year age gap that is highly statistically significant (p=0, 0<0.5).
* Gender Risk Factors: compares mortality rates between male and female patients. The analysis reveals an obvious difference in the mortality percentage, approx. 8.5% for men vs. 3.7% for women, which a t-test proves is statistically significant (p = 0.02$, 0.02<0.5).
* Country-Level Summaries: generates a summarised table breaking down total cases, total deaths, and case fatality rates mapped out across all unique countries in the dataset.

# Repository Structure
* `COVID19_line_list_data.csv`: The raw input dataset containing individual patient tracking rows.
* `covid_analysis.R`: The complete script containing cleaning routines, t-test operations, table merges, and plotting syntax.
* `topCases.png`: An export (800x600 px) displaying a cleanly scaled bar chart of the top 5 global hotspots by volume of reported cases.

# Code Breakdown & Methodologies
1. Data Cleaning: using numeric evaluations to compress varying data entries into binary factors (`0` or `1`).
2. Statistical Inference: implementing `t.test()` with a strict 99% confidence level (`conf.level=0.99`) to confirm clinical claims.
3. The Split-Apply-Combine pattern: `aggregate()` was used with varying operational functions (`length`, `sum`, `mean`) to transform raw patient logs into clear metric segments.
4. Multi-Way Data Merging: combines `merge()` seperate tables using the common `"Country"` key variable.
5. Custom Graphical Layouts: overrides default graphing canvas structures via `yaxt="n"` and `axis(side=2, at=seq(0, 200, by=20))` to provide dense axis scales.
