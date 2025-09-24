FROM ft_base_node

# Switch to root to install dependencies
USER root

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Switch back to non-root user
USER nextjs

# Expose the port the service will run on
EXPOSE 3003

# Start the application
CMD ["npm", "start"]