# Use the official Node.js image.
FROM node:14

# Set the working directory in the container.
WORKDIR /app

# Copy package.json and package-lock.json.
COPY package*.json ./

# Install dependencies.
RUN npm install

# Copy the rest of your application code.
COPY . .

# Expose the port on which JSON Server will run.
EXPOSE 5000

# Start JSON Server.
CMD ["npm", "start", "npx", "json-server", "--watch", "db.json", "--host", "0.0.0.0", "--port", "5000"]
