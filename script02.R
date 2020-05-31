# NOTA: La mejor manera de entender algo es observarlo, es más fácil de aprender
#### Limpiamos memoria ####
rm(list=ls())
#### Setear el directorio de trabajo ####
getwd() #Está donde lo dejé.
dir()

#### Cargar la data ####
library(ggplot2)
library(car)
help("Salaries")
data("Salaries")
str(Salaries)
library(help=car)
library(help=carData)
summary(Salaries)

#### Primeros pasos con ggplot ####
# Vamos a crear el gráfico: Agregar la data y configurarmos las variables

ggplot(data=Salaries, aes(x=yrs.service, y=salary))

# Creemos un diagrama de dispersión
p <- ggplot(data=Salaries, aes(x=yrs.service, y=salary))
class(p)#p es la capa de la data

# a p le vamos a agregar una geometría
p + geom_point()

# Modifiquemos nuestro objeto p (lienzo vacio)
p <- ggplot(data=Salaries, aes(x=yrs.service, y=salary, fill=sex)) #Se le agrega la estética
            # fill=sex
p + geom_point()

#Gráfico 1 
p+geom_point(shape=25, size=1.8) #en shape siempre esta de entre 1 y 25

# Gráfico 2
p + geom_point(aes(shape=sex, col=sex), size = 3)

# Gráfico 3
p + geom_point(aes(shape=sex, col=sex), size = 3) + scale_shape_manual(values = c(4,21)) +
  scale_color_manual(values=c("red","#5C7A54" )) + 
  theme(legend.position="top")
# NOTA: buscar la hora 3:05

help(ggsave)
ggsave(filename = "Gráfico3.png", width = 16, height = 9, units = "cm")

#  Gráfico 4
p + geom_point(aes(shape=sex, col=sex), size = 3) + scale_shape_manual(values = c(4,21)) +
  scale_color_manual(values=c("red","#5C7A54" )) + 
  theme(legend.position="right") +
  # theme(legend.background = element_rect(fill="#A2AFC9"))
  theme(legend.background = element_rect(fill="#A2AFC9", colour = "darkblue", 
                                         linetype = "dashed"))

# Gráficp 5
Graph5 <- p + geom_point(aes(shape=sex, col=sex), size = 3) + scale_shape_manual(values = c(4,21)) +
  scale_color_manual(values=c("red","#5C7A54" )) + 
  theme(legend.position="right") +
  theme(legend.background = element_rect(fill="#A2AFC9"))+
  scale_y_continuous(labels=scales::scientific)

# Gráfico 6
Graph5 + geom_smooth()
ggsave(filename = "gráfico6_GeomSmooth.png")

# Gráfico 7
Graph5 + geom_smooth(method = "lm", formula = y~poly(x,3))

# Gráfico 8
Graph5 + geom_smooth(method = "lm", formula = y~poly(x,3)) + facet_grid(~sex)

# Gráfico 9
help("Salaries")

p1 <- ggplot(data = Salaries, aes(x=yrs.service, y=salary, colour=rank))
p1 + geom_point() #El rank me simplifica los pasos
p1 + geom_point() + 
  geom_smooth(aes(group=rank), method="lm", color="black", size=0.5)+
  facet_grid(~sex)

# Gráfico 10 
p1 <- ggplot(data = Salaries, aes(x=yrs.service, y=salary, fill=rank))
p1 + geom_point(shape=21)+
  geom_smooth(method = "lm", color="black", size=0.5, se= F)+
  facet_grid(~sex)

library(gridExtra) #teniamos que instalar este paquete

# Gráfico 11
Plt1 <- ggplot(Salaries, aes(x=rank)) + geom_bar()
Plt2 <- ggplot(Salaries, aes(x=sex)) + geom_bar()
Plt3 <- ggplot(Salaries, aes(x=yrs.service, y=salary)) + geom_point()
grid.arrange(Plt1, Plt2, Plt3, ncol=3)