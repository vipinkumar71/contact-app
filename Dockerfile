# # Stage 1: Build the React app
# FROM node:18-alpine AS build
# WORKDIR /app
# COPY package.json package-lock.json ./
# RUN npm install
# COPY . ./
# RUN npm run build

# # Stage 2: Serve the app using Nginx
# FROM nginx:alpine
# COPY --from=build /app/build /usr/share/nginx/html
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

# Use node as the base image
FROM node:16

# Create and set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install all dependencies
RUN npm install

# Copy the rest of the app to the working directory
COPY . .

# Install 'concurrently' to run both React app and JSON server
RUN npm install -g concurrently

# Expose the ports for the React app (3000) and JSON server (5000)
EXPOSE 3000 5000

# Start both the React app and JSON server
CMD ["concurrently", "npm:start", "npm run server"]

