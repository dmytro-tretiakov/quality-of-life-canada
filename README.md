# Canada Quality of Life Analysis
## Prosperity, Mental Health, Future Outlook & Sense of Meaning Analysis
### R | Power BI
### Team Member: Dmytro Tretiakov

## Project Overview
This group project is a comprehensive analysis of Canadian quality of life indicators, using data from the Statistics Canada Quality of Life Hub. The study examines the following key dimensions:
1. **Prosperity & Poverty**
2. **Mental Health**
3. **Future Outlook (My Focus)**
4. **Sense of Meaning and Purpose**

While the full team report covers all four areas, this repository specifically highlights the data pipeline and analysis I developed for **Future Outlook**. I built a modular R system and an interactive Power BI visualization to analyze how future outlook indicators changed across provinces and demographic groups between 2021 and 2025.

## How to View 
* **Analysis & Data:** Navigate to the `/scripts` folder to see the R processing steps or the `/data` folder for the datasets. 
* **Interactive Visualization:** Download the `.pbix` file from the `/powerbi` folder and open it with **Power BI Desktop**. 
* **Final Report:** The full group report with final conclusions is available in the `/report` folder.

## Tech Stack
- **Platform:** RStudio / Power BI Desktop
- **Languages:** R (Tidyverse, ggplot2)
- **Data Source:** Statistics Canada (Quality of Life Hub)
- **Visualizations:** R-based Plotting, Power BI Interactive Charts

## My Contributions (Future Outlook)
- **Data Preparation and Cleaning:** Created an efficient R pipeline (`01_data_cleaning.R`) to standardize raw survey data, handle missing values, and prepare dataset for analysis.
- **Trend Analysis:** Developed R scripts to analyze future outlook over a 3-year period, identifying key shifts in public sentiment.
- **Power BI Visualization** Designed and built an interactive histogram in Power BI using R to visualize the distribution of indicators.
- **Demographic Comparison:** Identified and compared patterns in future outlook across different provinces and age groups to highlight regional differences.
- **Insights Development:** Created a comprehensive summary for the Future Outlook section, identifying key indicators and major trends to support the project's final conclusions.

## Skills Demonstrated
- **R Programming & Tidyverse**
- **Business Intelligence (Power BI)**
- **Data Preparation and Cleaning**
- **Statistical Visualization**
- **Public Data Analysis**

## Group Members
- **Nouman Ahmed Shah Khan** (Prosperity & Poverty)
- **Thi Mong Thuy Vo** (Mental Health)
- **Dmytro Tretiakov** (Future Outlook)
- **Yu-Shen Ma** (Sense of Meaning and Purpose)

## Files Included
- **`/data`** – raw and cleaned CSV datasets from Statistics Canada
- **`/powerbi`** – `future_outlook_histogram.pbix` (Interactive visualization)
- **`/report`** – `quality_of_life_canada_report.pdf` (Full team report)
- **`/scripts`** – 8 numbered R scripts containing the full data pipeline and analysis
- **`README.md`** – project documentation

