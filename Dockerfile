# Establece la imagen base
FROM node:lts-alpine

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo package.json y package-lock.json a la imagen
COPY package*.json ./

# Instala las dependencias de la aplicación
RUN npm install

# Copia los archivos fuente de la aplicación a la imagen
COPY . .

# Compila la aplicación para producción
RUN npm run build

# Expone el puerto en el que se ejecutará la aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación cuando se inicie el contenedor
CMD [ "npm", "run", "serve" ]
