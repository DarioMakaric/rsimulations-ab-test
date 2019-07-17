beta_simulation <- function(){
     # set seed for reproducability
     set.seed(222)
     # create an empty matrix that will contain 10,000 simulation results
     result <- matrix(nrow = 10000, ncol = 5)
     for (sim in c(1:10000)){
         verA <- rbeta(n = 1, shape1 = 2, shape2 = 131)
         verB <- rbeta(n = 1, shape1 = 4, shape2 = 137)
         #calculate the pooled standard error
         SEpooled <- sqrt((0.015*0.985/133) + (0.028*0.972/141)) 
         # if B is greater than A (i.e. the difference is positive) pvalue will be the right tail of the distribution
         # if it's negative pvalue will be the left tail
         d <- verB - verA
         if (d < 0) {
             pvalue <- 2 * pt(d/SEpooled, df = 273)
         }
         else {
             pvalue <- 2 * (1 - pt(d/SEpooled, df = 273))
         }
         #store the values in the matrix
         result[sim, 1] <- sim
         result[sim, 2] <- verA
         result[sim, 3] <- verB
         result[sim, 4] <- d
         result[sim, 5] <- pvalue
     }
     result <- list(result)
     names(result) <- c("result") 
     return (result)
 }
