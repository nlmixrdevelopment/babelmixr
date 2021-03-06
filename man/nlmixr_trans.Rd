% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nonmem.R
\name{nlmixr_trans}
\alias{nlmixr_trans}
\title{nlmixr translation function}
\usage{
nlmixr_trans(func)
}
\description{
nlmixr translation function
}
\examples{

f <- function(){
 ini({
 lCl <- 1.6      #log Cl (L/hr)
   lVc <- log(90)  #log Vc (L)
   lKA <- 0.1      #log Ka (1/hr)
   prop.err <- c(0, 0.2, 1)
   add.err <- 1
   #eta.Cl ~ 0.1 ## BSV Cl
   #eta.Vc ~ 0.1 ## BSV Vc
   eta.Cl + eta.Vc ~ c(1,0.01, 1)
   eta.KA ~ fix(0.1) ## BSV Ka
 })
 model({
   ## First parameters are defined in terms of the initial estimates
   ## parameter names.
   Cl <- exp(lCl + eta.Cl)
   Vc <- exp(lVc + eta.Vc)
   KA <- exp(lKA + eta.KA)
   ## After the differential equations are defined
   kel <- Cl / Vc;
   d/dt(depot)  = -KA*depot;
   d/dt(centr)  =  KA*depot-kel*centr;
   ## And the concentration is then calculated
   cp = centr / Vc;
   ## Last, nlmixr is told that the plasma concentration follows
   ## a proportional error (estimated by the parameter prop.err)
   cp ~ prop(prop.err) + add(add.err)
 })
}
# Run the function
nlmixr_trans(f)
}
\author{
Richard Hooijmaijers with contributions from Matt Fidler
}
