# Stage 1: Build the React app
FROM node:16 AS build

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Setup Nginx to serve the React app and json-server
FROM nginx:alpine

# Copy the built React app from the build stage
COPY --from=build /app/build /usr/share/nginx/html

# Install json-server
RUN apk add --no-cache nodejs npm && npm install -g json-server

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy db.json for json-server
COPY db.json /db.json

# Expose ports
EXPOSE 80 5000

# Start the services
CMD ["sh", "-c", "json-server --watch /db.json --port 5000 & nginx -g 'daemon off;'"]
