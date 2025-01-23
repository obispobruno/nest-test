# Use the official Node.js image as the base image
FROM node:22

# Install pnpm globally
RUN npm install -g pnpm

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json, pnpm-lock.yaml, and .env file (if you have any environment variables)
COPY package*.json pnpm-lock.yaml ./

# Install the application dependencies using pnpm
RUN pnpm install

# Copy the rest of the application files
COPY . .

# Generate Prisma client
RUN pnpm prisma generate

# Build the NestJS application
RUN pnpm run build

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD ["node", "dist/src/main"]

