# Stage 1: Build the Flutter web app
FROM debian:latest AS build-env

# Install Flutter dependencies
RUN apt-get update && \
    apt-get install -y curl git unzip

# Clone the Flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Add flutter to path
ENV PATH="/usr/local/flutter/bin:${PATH}"

# Enable Flutter web
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

# Copy app files to container
WORKDIR /app
COPY . .

# Build web app
RUN flutter pub get
RUN flutter build web

# Stage 2: Create the run environment
FROM nginx:alpine

# Copy the build output to nginx
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
