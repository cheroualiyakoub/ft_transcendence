# filepath: /Users/ycheroua/CorCur42/ft_transcendence/ft_transcendence/services/user/Dockerfile
FROM node:16-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port the service will run on
EXPOSE 3001

# Start the application
CMD ["npm", "start"]