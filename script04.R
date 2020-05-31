rm(list=ls())
dir()

####Cargamos la data ####
Oro <- read.csv("GOLDAMGBD228NLBM (1).csv")

Oro$DATE
Oro$GOLDAMGBD228NLBM
colnames(Oro)
colnames(Oro) <- c("Fecha", "Precio")
class(Oro)
str(Oro)#Fecha es de tipo character, se tiene que cambiar. Precio tambien se tiene que modificar
Oro$Fecha <- as.Date(Oro$Fecha) #Modifico la clase o tipo de variable
Oro$Precio <- as.double(Oro$Precio) 

# Cantidad de elementos NAs
is.na(Oro$Precio) #No es la mejor opción

# Aprovecho que: TRUE=1, FALSE=0
# Calculo la cantidad de elementos TRUE, esto corresponde con la cantidad de elementos NA
sum(is.na(Oro$Precio))
sum(is.na(Oro$Fecha))

# Notamos que existen 
