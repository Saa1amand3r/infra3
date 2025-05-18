# Stage 1: base
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json & package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your code
COPY . .

# Expose the development port
EXPOSE 3000

# Start the development server
CMD ["npm", "start"]
