FROM node:16-alpine

# Set the working directory
WORKDIR /app

# Install global dependencies (if needed)
RUN npm install -g nodemon

# Create a non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001 -G nodejs

# Set proper permissions for the app directory
RUN chown -R nextjs:nodejs /app

# Switch to the non-root user by default
USER nextjs

# Default command (can be overridden by child images)
CMD ["node"]