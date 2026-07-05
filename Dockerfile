# Step 1: Base image using standard specific alpine version for stability
FROM nginx:1.27-alpine

# Step 2: Set working directory inside the container
WORKDIR /usr/share/nginx/html

# Step 3: Remove default nginx html files to avoid conflicts
RUN rm -rf ./*

# Step 4: Copy static website content into the server directory
COPY . .

# Step 5: Document that the container listens on port 80
EXPOSE 80

# Step 6: Start Nginx in foreground mode so container doesn't exit
CMD ["nginx", "-g", "daemon off;"]
