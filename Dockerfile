# Usa la imagen base de Node.js v16
FROM node:16-alpine AS build-stage

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo package.json y package-lock.json al contenedor
COPY package*.json ./

# Instala las dependencias del proyecto
RUN npm install

# Copia el resto de los archivos de la aplicación
COPY . .

# Construye la aplicación Vue
RUN npm run build

# Etapa de producción
FROM nginx

# Copia los archivos de compilación de la etapa de construcción al directorio de documentos de Nginx
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expone el puerto 80 para acceder a la aplicación a través de Nginx
EXPOSE 8080

# Comando de arranque para Nginx
CMD ["nginx", "-g", "daemon off;"]
