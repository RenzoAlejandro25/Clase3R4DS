rm(list=ls())
library(ggplot2)
library(car)
help("Salaries")
data("Salaries")
str(Salaries)
summary(Salaries)

# Gráfico 1 
ggplot(Salaries, aes(x=salary))
ggplot(Salaries, aes(x=salary, y=..density..))+
  geom_histogram(colour='grey60', fill='cornsilk')+
  geom_density(colour=NA, fill='blue', alpha=0.2)+
  geom_density(stat="density", colour="red")

range(Salaries$salary)#mínimo 57800

ggplot(Salaries, aes(x=salary, y=..density..))+
  geom_histogram(colour='grey60', fill='cornsilk')+
  geom_density(colour=NA, fill='blue', alpha=0.2)+
  geom_density(stat="density", colour="red")+
  xlim(45000,250000)

# ///////////////////////////////////////////////////////////////////////////////
# Los intervalos de clase
Hs <- hist(Salaries$salary)
Hs$breaks
Hs$counts

hist(Salaries$salary, breaks = seq(40000,240000, 5*1000))
Hs2 <- hist(Salaries$salary, breaks = seq(40000,240000, 15*1000))
# Hs2$breaks
bwidth = Hs2$breaks[2]-Hs2$breaks[1]
ggplot(Salaries, aes(x=salary, y=..density..))+
  geom_histogram(binwidth =bwidth , colour='grey60', fill='cornsilk')+
  geom_density(colour=NA, fill='blue', alpha=0.1)+
  geom_density(stat="density", colour="red")+
  xlim(45000,250000)


