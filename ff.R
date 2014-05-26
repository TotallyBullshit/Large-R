# install.packages('ff')
library(ff)

ff.vector = ff(vmode='double', 
               length=10, 
               filename="ff.vector")
ff.vector
ff.vector[1] = 1
ff.vector
rm(ff.vector)
ff.vector
ff.vector = ff(vmode='double', length=10, filename="ff.vector")
ff.vector

t0=Sys.time(); 
# maximum length is 2^30 (approx. 4 billion) elements
ff.matrix = ff(vmode='double', 
               dim=c(2^16,2^15), 
               initdata=1,
               filename="ff.matrix", 
               overwrite=TRUE)
Sys.time()-t0
# Time difference of 35 to 56 secs (Ledger)

t0=Sys.time(); 
ff.matrix[2^14,2^14-100] = 4
Sys.time()-t0
# Time difference of 0.005964041 secs (Ledger)

as.ff(1:10)
as.ff(c('a','b','c'))
a.ffdf = ffdf(zero=as.ff(0:9), one=as.ff(10:19), two=as.ff(20:29))

