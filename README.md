# CA OWRS: Exploring California Drinking Water Rates, Affordability, and Safety using the Open Water Rate Specification

Water utility managers and regulators face many competing priorities when setting retail water rates, including, but not limited to, cost recovery, affordability and conservation. Utility managers often site cost recovery (necessary to maintain water supply and distribution infrastructure, plan for future growth, and maintain water quality) and affordability (to ensure access to services, whether for deontological reasons such as realizing the Human Right to Water or to meet regulatory requirements), in particular as competing priortites. Many intuit a hypothesis from this basic competition that water affordability may negatively correlate with water quality. However, there are innumerable possible water rate structures, and determining the relationship between different rates and the propensity for utilities to meet any one of these goals is difficult due to low availability of water rate data that can be used to compare utility performance. In California, thanks to the efforts of the [California Data Collaborative](http://californiadatacollaborative.org/) and their [Open Water Rate Specification (OWRS)](https://github.com/California-Data-Collaborative/Open-Water-Rate-Specification), consistently formatted [water rates are available](https://github.com/California-Data-Collaborative/Open-Water-Rate-Specification/tree/master/full_utility_rates) for 2017 and 2018 for hundreds of California and Nevada utilities. 

This exploratory, descriptive effort will leverage the OWRS data as well as drinking water quality monitoring data from [SDWIS](https://sdwis.waterboards.ca.gov/PDWW/) and the [U.S. Census](https://www.census.gov/data/developers/updates/new-discovery-tool.html) to:

1. Construct and visualize affordability metrics for water utilities
⋅⋅* The industry-standard "water bill at mean consumption as a percentage of the community median household income (%MHI Standard)"
⋅⋅* The [Affordability Ratio](https://awwa.onlinelibrary.wiley.com/doi/full/10.5942/jawwa.2018.110.0002)
⋅⋅* The [Weighted Average Residential Index](https://awwa.onlinelibrary.wiley.com/doi/full/10.5942/jawwa.2017.109.0060)
⋅⋅* Our own novel metric that accounts for an essential level of water consumption, and the distribution of household size and income within communities
2. Visualise relationships between affordability, rate structures, water consumption, and water quality

