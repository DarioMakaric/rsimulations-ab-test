# R script for 10,000 simulated t-tests (A/B test)

Read the entire post on:
https://towardsdatascience.com/false-discovery-rate-type-m-and-type-s-errors-in-an-underpowered-a-b-test-d323df5271fa


beta_function.R is a script that will sample  20,000 values from two beta distributions. Then run a t-test for every estimate effect size. The output is a matrix of size 10,000x5. Five columns are sampleID, sample one, sameple two, difference, pvalue.

density_plots.R is a script for creating the plots used in the post linked above.
