# Step 1: Build the React app
FROM node:14 AS build

WORKDIR /app
COPY package.json ./
COPY package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Step 2: Serve the app with Nginx
FROM nginx:alpine

# Copy the built React app from the build stage to Nginx's html directory
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom Nginx configuration (optional)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose ports
EXPOSE 80
EXPOSE 5000

# Start both Nginx and JSON server using a shell script
CMD ["sh", "-c", "nginx && json-server --watch /app/db.json --port 5000"]
