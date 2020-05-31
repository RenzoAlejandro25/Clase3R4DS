#### Datos y libreria ####
setwd("C:/Users/Usuario/Desktop/Clases_de_R/Clase3R4DS")
library(dplyr) #esto es para saber si tenemos instalado dplyr
# dplyr ha sido desarrollado por Hadley Wikhan (Rstudio)
# dplyr es una gramática para manipulación de datos, hay mejores librerias que dplyr en cuanto 
# a grandes paquetes de datos se trata.

#### Cargar data: storms, pollution, tb ####
storms <- read.csv("https://raw.githubusercontent.com/robintux/Datasets4StackOverFlowQuestions/master/storms.csv")
# En una read.csv siempre se pone una dirección, en este caso es 
# Esta data es de las velocidades máximas de vientos de 6 huracanes.

pollution <- read.csv("https://raw.githubusercontent.com/robintux/Datasets4StackOverFlowQuestions/master/pollution.csv")
# Nivel promedio de contaminación del aire por particular (esta por ciudades).

# NOTA: el profe tiene las direcciones de las paginias originales de las bases de datos de arriba

tb <- read.csv("https://raw.githubusercontent.com/robintux/Datasets4StackOverFlowQuestions/master/tb.csv")
# Es el número de casos de tuberculósis: 1995-2013

#### Algunas funciones de dplyr ####
class(storms) #Es un dataframe
dim(storms) #tiene 6 filas y 4 columnas
dim(storms)[1] #Para acceder a las filas
head(storms, n=2) #Para ver las 2 primeras dos filas
tail(storms, n=3) #para ver las tres últimas filas
colnames(storms)
names(storms) 
str(storms)
# storm: es una variable tipo caracter

# es notorio que la variable $date deber ser un variable que represente a la linea de tiempo
class(storms$date)
storms$date <- as.Date(storms$date)#Pasamos del tipo character a tipo date

#### Función select ####
# esta función permite seleccionar columnas de un dataframe
# Seleccionar las variables storm y pressure(select para columnas)
help("select")
select(storms, storm, pressure)
select(storms, colnames(storms)[1], colnames(storms)[3]) #otra forma de hacer lo mismo
storms[,c(1,3)] #otra forma de obtener lo mismo utilizando notación matricial

# Verefiquemos que el resultdo sigue siendo un objeto dataframe
class(select(storms, storm, pressure))#Sigue siendo un dataframe

# Para excluir una columnas utilizamos el operador (unario)
select(storms, -storm) #mi dataframe sin visualizar storm
storms[,-1] #notación matricial
storms[,-c(1,3)] #para eliminar más columnas

# podemos utilizar los dos puntos para seleccionar un rango de columnas
select(storms, wind:date)

# utilizando los operadores ":" y "-" podemos hacer más cosas.
select(storms, -(storm:wind))

# Seleccionar columnas cuyo nombre contiene un patron
select(storms, starts_with("w"))

# Seleccionar las columnas cuyo nombre termina con la letra "e"
select(storms, ends_with("e"))

# seleccionar todas las columnas
select(storms, everything())

# Selecciona columnas cuyo nombre contiene un string
select(storms, contains("essur"))

# Algunas funciones de select son bastante utiles
# "-", ":", "contains()", "star_with()", etc
help("contains")

#### filter ####
# Nos permite filtrar por filas según una condición 
filter(storms, wind >= 50) #todas las filas cuya variable wind es por lo menos 50
filter(storms, wind >=50, storm%in%c("Alberto", "Alex","Allison"))#esto es una unión

# el siguiente ejemplo filtra aquellas filas con wind>=50 y pressure<1010
filter(storms, wind>=50 & pressure<1010) #esto es una intersepción

#### arrange ####
# Esta función se utiliza para ordenar las filas de un dataframe, de a cuerdo a una o
# varias columnas. Por defecto ordena las filas en orden ascendente. 
# Para ordenar las filas por la variable wind de forma ascendente
arrange(storms, wind)

# ahora queremos ordenar de forma descendente
arrange(storms, desc(wind))

#### rename ####
names(storms) #los nombres de mis columnas
rename(storms, tormenta=storm, viento=wind, presión=pressure, fecha=date) #cambiar los nombres

#### mutate ####
# con esta función podemos computar/calcular transformaciones de las variables de un dataframe
# A menudo tendremos la necesidad de calcular nuevas variables, pero estas se 
# calculan a partir de variables existentes, mutate() proporciona una interface para realzat
# este tipo de operaciones

# Deseo calcular una variable ratio que sea definida como el cociente de presion y viento
mutate(storms, ratio=pressure/wind) #me crea una nueva columna

StormsNuevo <- mutate(storms, ratio=pressure/wind) #creamos un nuevo dataframe

# mutate nos permite encadenar varias expresiones
stormsNuevo <- mutate(storms, ratio=pressure/wind, inverse =ratio^-1)
mean(stormsNuevo$wind)

#### summarise ####
summary(StormsNuevo)#funciona de forma análoga a la función mutate, excepto que en lugar
# de añadir  nuevas columnas crea un nuevo dataframe

# por ejemplo para calcular la mediana y la varianza de la variable ammount del dataframe
# pollution
summarise(pollution, mediana=median(amount), variance=var(amount))
class(summarise(pollution, mediana=median(amount), variance=var(amount))) #esun dataframe

#### Operador pipe ####
# El uso es bastante sencillo y sirve para concatener expresiones de la gramática dplyr

pollution %>% summarise(mediana2=median(amount), varianza=var(amount))
# esto %>% es el operador pipe
class(pollution %>% summarise(mediana2=median(amount), varianza=var(amount)))#dataframe

# Funciones que trabajan con summarise
# base:min, max, median, mean, sum, var, sd
# funciones propias de dplyr: firts, last, n, n_distinct, nth

#### group_by ####
pollution
group_by(pollution, city) 
class(group_by(pollution, city)) #entre otras cosas es un dataframe
# Además de tener información de dataframe tiene información de "tbl", "tbl_df"

pollution %>% group_by(city)%>% summarise(media=mean(amount), 
suma=sum(amount), n=n()) #Vas a tener que ver el video para entender esta parte:2h,41min

Info <- pollution %>% group_by(city)%>% summarise(media=mean(amount), 
                                                  suma=sum(amount), n=n())
class(Info)





