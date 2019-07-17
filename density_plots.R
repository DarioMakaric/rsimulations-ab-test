library(ggplot2)

#result <- beta_simulation()

# create data.frames for ggplot
data_diff <- data.frame(difference = rnorm(10000, 0.013, SEpooled))
data_null <- data.frame(difference = rnorm(10000, 0, SEpooled))

#create plot object for ggplot_build()
ggplot() + 
geom_density(aes(x = difference), data=data_diff, color = "blue") + 
geom_vline(xintercept = 0.013, size = 0.4, linetype = "dotted", color = "blue")+ 
geom_density(aes(x=difference), data=data_null) + 
geom_vline(xintercept = 0, size = 0.4, linetype = "dotted") + 
geom_vline(xintercept = 1.96*SEpooled, size = 0.4, linetype = "dotted", color = "red") + 
geom_vline(xintercept = -1.96*SEpooled, size = 0.4, linetype = "dotted", color = "red") + 
scale_x_continuous(breaks = c(-0.05, -1.96*SEpooled, 0, 0.013, 1.96*SEpooled, 0.0432), labels = c("-0.050", "-0.034", "0", "0.013", "0.034", "0.043")) +
geom_vline(xintercept = 0.0432, size = 0.3) -> distributions_plot

#plot null distribution and simulated differences on a single plot
distributions_plot

#call ggplot_build and extract data points for shading
plot_builder <- ggplot_build(distributions_plot)
x1 <- min(which(plot_builder$data[[1]]$x >= 0.043))
x2 <- max(which(plot_builder$data[[1]]$x >= 0.043))

#plot with power shaded
distributions_plot + 
geom_area(data=data.frame(x=plot_builder$data[[1]]$x[x1:x2], y=plot_builder$data[[1]]$y[x1:x2]), aes(x=x,y=y), fill="red")

#plot pvalues histogram
ggplot() + 
geom_histogram(data = data.frame(pvalues = result$result[, 5]), aes(x = pvalues), bins= 60, binwidth = 0.012) + 
scale_x_continuous(breaks = c(0.05, 0.50, 0.75, 1.00))

#plot differences that are found signifficant (i.e. pvalue <= 0.05)
ggplot() + 
geom_histogram(data = data.frame(differences = result$result[, 4][which(result$result[, 5] <= 0.05)]), aes(x = differences), bins= 120)
