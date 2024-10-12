# Stage 1: Build the React app
FROM node:18 AS build

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy all the files and build the app
COPY . .
RUN npm run build

# Stage 2: Setup Nginx and serve the React app
FROM nginx:alpine

# Copy the React build files from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom nginx config (optional)
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for the React app and 5000 for the JSON server
EXPOSE 80
EXPOSE 5000

# Start both Nginx and JSON server using a shell script
CMD ["sh", "-c", "nginx && json-server --watch /app/db.json --port 5000"]
