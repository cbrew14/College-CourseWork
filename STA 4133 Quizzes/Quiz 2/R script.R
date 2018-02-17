#Create Data
x <- seq(-4,4,0.1)
norm = dnorm(x)
norm_x = dnorm(x, mean = mean(x), sd = sd(x))
t = dt(x, df=1)
norm_df = as.data.frame(norm)
t_df = as.data.frame(t)

#plot the comparison
ppi=50000
plot(x, norm, type="n", ylab="f(x)", las=1)
lines(x, norm, lty=1, lwd=2)
lines(x, t, lty=2, lwd=2)
legend(1.1, .395, lty=1:2, lwd=2,bty = 'n',
         legend=c(expression(N(mu == 0,sigma == 1)),
                  paste("t with ", 1," df", sep="")))