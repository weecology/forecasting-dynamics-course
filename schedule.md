---
layout: page
title: Schedule
---
Activity days when laptops are required are noted in italics. Discussion leaders are listed below each topic.

* August 20: Introduction. Can we forecast in ecology?
    * Discussion Leader: Ethan and Morgan

* August 22: Introduction to ecological forecasting (reading)
    * Video: [NEON: Forecasting](https://www.youtube.com/watch?v=Lgi_e7N-C8E)
    * Reading: [Ecological forecasting and data assimilation in a data-rich era](https://esajournals.onlinelibrary.wiley.com/doi/full/10.1890/09-1275.1) **(through end of the Uses of Models for Ecological Forecasting section)**
    * [Discussion questions]({{ site.baseurl }}/discussion/intro-to-forecasting)

* August 27: Paleo dynamics - Pleistocene/Holocene transition
    * Reading: Just the Introduction of [Ecological Change, Range Fluctuations and Population Dynamics during the Pleistocene](https://doi.org/10.1016/j.cub.2009.06.030) (i.e. stop when you reach the section titled "The Glacial Refugium Theory")
    * Reading: Read all of [Novel climates, no-analog communities, and ecological surprises](https://doi.org/10.1890/070037)
    * Discussion leader: Morgan
        * [Discussion questions]({{ site.baseurl }}/discussion/paleodynamics)
 
* *August 29: Time series data*

* September 3: CANCELLED DUE TO HURRICANE

* *September 5:  Working with time series data in R*
    * Before class install R Packages: ggplot2, lubridate, dplyr
    * Download the following files:
          * [NEON_HarvardForest_date.csv]({{ site.baseurl }}/data/NEON_Harvardforest_date_2001_2006.csv)
            * [NEON_HarvardForest_datetime.csv]({{site.baseurl }}/data/NEON_Harvardforest_datetime.csv)

* September 10: Community Dynamics – Species Composition and Richness 
    * Reading: [Assemblage time series reveal biodiversity change but not systematic loss](https://doi.org/10.1126/science.1248484)
    * Discussion leader: Morgan
    * [Discussion questions]({{ site.baseurl }}/discussion/dornelas) 

* *September 12: Basics of Time Series – Time Series Decomposition*
      * Bring computers. Install the R package: forecast
      * Data file: [portal_timeseries.csv]({{ site.baseurl }}/data/portal_timeseries.csv)
     
* September 17: Changes in phenology
    * Reading [Shifting plant phenology in response to global change](https://doi.org/10.1016/j.tree.2007.04.003)
    * Discussion leader: Morgan
    * [Discussion questions]({{ site.baseurl }}/discussion/phenology)

* *September 19: Basics of Time Series – Time Series Autocorrelation*
     
* September 24: Regime shifts
    * Reading: [Repeated regime shifts in a desert rodent community](https://doi.org/10.1002/ecy.2373)
    * Discussion leader: Morgan
    * [Discussion questions]({{ site.baseurl }}/discussion/rapidtransitions)

* *September 26: Introduction to time-series modeling*
 
* October 1: Introduction to forecasting
    * Reading: [Forecasting Principles & Process Chapter 1](https://www.otexts.org/fpp/1)
    * Discussion leader: Ethan
    * [Discussion questions]({{ site.baseurl }}/discussion/fpp_1_questions)
 
* *October 3: Introduction to forecasting in R*
       
* October 8: Importance of uncertainty
    * Reading: [Dietze Chapter 2](https://ebookcentral.proquest.com/lib/UFL/detail.action?docID=4866481#goto_toc)
    * Discussion leader: Ethan
    * [Discussion questions]({{ site.baseurl }}/discussion/dietz-ch2-questions)

* *October 10: Evaluating forecasts*

* October 15: Forecasting using State-space model [quantitative]
    * Reading: [Forecasting climate change impacts on plant populations over large spatial extents](https://doi.org/10.1002/ecs2.1525)
    * Discussion leader: Ethan
    * [Discussion Questions]({{ site.baseurl }}/discussion/treddenick)

* *October 17: State-space model*

* October 22: Near-term Iterative Forecasting
    * Reading: [Iterative near-term ecological forecasting: Needs, opportunities, and challenges](https://doi.org/10.1073/pnas.1710231115 )
    * Discussion Leader: Morgan
    * Discussion [Questions]({{ site.baseurl }}/discussion/iterative)

* *October 24: State-space model pt 2*

* October 29:  Forecasting using Species Distribution Models
    * Reading: [Species Distribution Models:Ecological Explanation and Prediction Across Space and Time](http://eurobasin.dtuaqua.dk/eurobasin/documents/Training%20ISM/Elith_and_Leathwick_2009.pdf)
    * Discussion Leader: Ethan

[//]: #    * [Discussion Questions]({{ site.baseurl }}/discussion/SDMs)
    
* *October 31: Species Distribution Models* 

* November 5: How do other fields forecast - Hurricane Forecasting
    * [Types of Hurricane Forecast Models](http://www.hurricanescience.org/science/forecast/models/modeltypes/)
    * [Statistical, Statistical-Dynamic, Trajectory Models](http://www.hurricanescience.org/science/forecast/models/modeltypes/statistical/)
    * [Dynamical Models](http://www.hurricanescience.org/science/forecast/models/modeltypes/dynamicalmodels/)
    * [Numerical Weather Predictions/Ensemble Forecasting Explained](https://www.weather.gov/media/ajk/brochures/NumericalWeatherPrediction.pdf)
    * [How Hurricane Forecast Models Work](http://www.hurricanescience.org/science/forecast/models/modelswork/)
    * [Ensemble or Consensus Models](http://www.hurricanescience.org/science/forecast/models/modeltypes/ensemble/)
    * Other interesting reading:
        * For fun: With your new knowledge on hurricane forecasting, you might find these articles about forecast accuracy of Hurricane Michael and Hurricane Florence interesting. These are not required for class.
        * [Hurricane Michael and why it’s so hard to predict storm intensity](https://www.vox.com/energy-and-environment/2018/10/11/17963958/hurricane-michael-forecast-track-intensity-category)
        * [Surprise! The American weather model had the best forecasts for Hurricane Florence](https://www.washingtonpost.com/weather/2018/09/26/surprise-american-weather-model-had-best-forecasts-hurricane-florence/?utm_term=.b1cb011d15e4)
    * Discussion leader: Morgan

[//]: #    * [Discussion questions]({{ site.baseurl }}/discussion/weather)
     
* November 7: How do other fields forecast - Elections
    * Reading:[A User's Guide to FiveThirtyEight's 2016 Election Forecast](https://fivethirtyeight.com/features/a-users-guide-to-fivethirtyeights-2016-general-election-forecast/)
    * Reading: [Which election forecast should you trust](http://www.slate.com/articles/news_and_politics/politics/2016/08/fivethirtyeight_vs_the_upshot_who_should_you_trust_to_forecast_the_2016.html)
    * Discussion leader: Morgan?

[//]: #    * [Discussion questions]({{ site.baseurl }}/discussion/elections)
    
* November 12: Data-driven models for forecasting [quantitative]
    * Reading: [Equation-free mechanistic ecosystem forecasting using empirical dynamic modeling](https://doi.org/10.1073/pnas.1417063112) 
    * YouTube video: https://www.youtube.com/watch?v=fevurdpiRYg
    * Discussion leader: Ethan

[//]: #    * [Discussion questions]({{ site.baseurl }}/discussion/edm)

* *November 14:  Empirical Dynamic Modeling Tutorial*
    * [Code]({{ site.baseurl }}/lectures/rEDM_primer)    

* November 19: Operational Forecasting
    * Reading: [Lonnie Gonsalves talk](https://www.youtube.com/watch?v=04CbfDvXjUc)

* November 21: Scenario based foreasting
    * Reading: [Why global scenarios need ecology](https://doi.org/10.1890/1540-9295(2003)001[0322:WGSNE]2.0.CO;2)
    * Discussion leader: Ethan

[//]: #    * [Discussion questions]({{ site.baseurl }}/discussion/scenarios)

* November 26: Ethics of Forecasting
    * Reading: [Ethical considerations and unanticipated consequences associated with ecological forecasting for marine resources](https://academic.oup.com/icesjms/advance-article/doi/10.1093/icesjms/fsy210/5303214)
    * Discussion Leader: ??
 
* December 3: Can we forecast in ecology (and what can we forecast)?
    * Reading: [Prediction, precaution, and policy under global change](https://doi.org/10.1126/science.1261824)

[//]: #    * Discussion Leader: Ethan and Morgan
