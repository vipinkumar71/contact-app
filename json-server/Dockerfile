# Use Node.js base image
FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install -g json-server

# Copy the JSON file
COPY db.json ./

# Expose port 5000
EXPOSE 5000

# Start the JSON server
CMD ["json-server", "--watch", "db.json", "--host", "0.0.0.0"]
