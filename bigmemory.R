# install.packages('bigmemory')
library(bigmemory)
n0 = 2^15
m0 = 2^15

# Check vector (Norm)
# Ram drive (Jason)
# bigmemory - shared and file based
# library use (David)

# Time difference of 59.30802 secs (MacAir)
# Time difference of 58.14366 secs (Ledger)
t0=Sys.time(); 
a.matrix = matrix(nrow=2^16,ncol=2^16); 
Sys.time()-t0

# Time difference of 3.551736 mins (MacAir)
# Time difference of 1.410767 mins (Ledger)
t0=Sys.time(); 
a.big.matrix = big.matrix(nrow=2^16,ncol=2^16); 
Sys.time()-t0

t0=Sys.time(); 
a.matrix[n0,m0] = 1
Sys.time()-t0
# Time difference of 4.76923 mins (MacAir)
# Time difference of 1.26127 mins (Ledger)
# Time difference of 41.0511 secs (Ledger)

t0=Sys.time(); 
a.big.matrix[n0,m0] = 1
Sys.time()-t0
# Time difference of 37.10874 secs (MacAir)
# Time difference of  0.01183 secs (Ledger)

# Time difference of 1.430479 mins (MacAir)
# Time difference of 1.297428 mins (Ledger)
t0=Sys.time(); 
a.file.matrix = 
  filebacked.big.matrix(2^16, 
                        2^16, 
                        type='double', 
                        init=NULL,
                        backingpath='/mnt/ramdisk/',
                        backingfile="Mat32GB.bin",
                        descriptorfile="Mat32GB.desc")
Sys.time()-t0

# Time difference of 15.69226 secs
t0=Sys.time(); 
a.file.matrix = 
  filebacked.big.matrix(2^15, 
                        2^15, 
                        type='double', 
                        init=1,
                        backingfile="Mat8GB.bin",
                        descriptorfile="Mat8GB.desc")
Sys.time()-t0

start.time=Sys.time(); 
a.file.matrix[n0,m0] = 1
Sys.time()-start.time
# Time difference of 0.005546808 secs (MacAir, Ledger)

rm(a.file.matrix)
a.file.matrix
a.file.matrix = attach.big.matrix("Mat32GB.desc")

a.file.matrix[n0,m0]

# Time difference of 23.82744 secs
# Time difference of 46.74579 secs
# Time difference of 0.01596069 secs
start.time=Sys.time(); 
a.file.matrix[n0,]=4 # faster
a.file.matrix[,m0]=5 # slower
Sys.time()-start.time

# Time difference of 4.853491 secs
# Time difference of 0.043221 secs
start.time=Sys.time(); 
a.file.matrix[,m0+0]=1:2^16
a.file.matrix[,m0+1]=runif(2^16)
a.file.matrix[,m0+2]=runif(2^16)
a.file.matrix[,m0+3]=runif(2^16)
Sys.time()-start.time

a.file.matrix[n0,m0] # OK
a.file.matrix[n0,m0+1] # OK
a.file.matrix[n0,m0:(m0+1)] # OK PRECEDENCE!

# Time difference of 4.853491 secs
# Time difference of 0.0122726 secs
start.time=Sys.time(); 
an.order = morder(x=a.file.matrix, 
                  cols=n0, 
                  decreasing=TRUE)
Sys.time()-start.time

an.order[1:10]

start.time=Sys.time(); 
mpermute(a.file.matrix, order=an.order)
Sys.time()-start.time

