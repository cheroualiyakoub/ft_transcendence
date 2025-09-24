FROM ft_base_node

# Set working directory
WORKDIR /app

# Install dependencies first (for better caching)
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Expose port for development server
EXPOSE 8080

# Default command for development (hot reload)
CMD ["npm", "run", "dev"]