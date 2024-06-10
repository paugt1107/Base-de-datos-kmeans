#TFG PAULO GONZÁLEZ
#6 de febrero de 2024

#Leer archivo excel
library(readxl)
#Con el objetivo de manipular datos
library(dplyr)
#Para abrir y leerarchivo de Excel
library(openxlsx)

#Cargo la ruta de mi Excel
datos_fichajes <- read_excel("TFG FICHAJES/Bade de datos definitiva.xlsx")

#Con esta opción consigo que  se muestren todas las filas
options(max.print = nrow(datos_fichajes))

#Mostrando todos los datos del mi base de datos
print(datos_fichajes)

#Limpieza ordenación y completación de los datos
datos_filtrados <- datos %>%
  filter(!is.na(Valor_mercado) & Valor_mercado != "", 
         !is.na(Liga_proveniente) & Liga_proveniente != "", 
         !is.na(Liga_destino) & Liga_destino != "",
         !is.na(Valor_fichaje) & !grepl("\\?", Valor_fichaje),
         !is.na(Año) & Año != "#REF") 

#Mostrando todos los datos del mi base de datos
print(datos_filtrados)


# Limpiar la columna 'Valor_fichaje',eliminando la palbra Loan tranfer
#pero dejando el numero como está
datos_fichajes <- datos_fichajes %>%
  mutate(Valor_fichaje = gsub("Loan fee:\\n", "", Valor_fichaje))

# Limpiar la columna 'Valor_fichaje', cambiando free transfer por €o.oom
datos_fichajes <- datos_fichajes %>%
  mutate(Valor_fichaje = gsub("Free transfer\\n", "€0.00m", Valor_fichaje))

# Limpiar la columna 'Valor_fichaje', cambiando loan transfer por €o.oom
datos_fichajes <- datos_fichajes %>%
  mutate(Valor_fichaje = gsub("Loan transfer\\n", "€0.00m", Valor_fichaje))


print(datos_fichajes)


# Guardar los datos limpios en un nuevo archivo de Excel
write_xlsx(datos_fichajes, "TFG FICHAJES/Bade de datos definitiva.xlsx")
