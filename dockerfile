# Use an official PHP runtime as a parent image
FROM php:8.3-fpm

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Configure Nginx and PHP-FPM
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./site.conf /etc/nginx/sites-available/default
COPY ./www.conf /usr/local/etc/php-fpm.d/www.conf

# Create a directory for the application
RUN mkdir -p /var/www/html

# Copy the application code
COPY ./src /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Expose ports
EXPOSE 80

# Copy the entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Start Nginx and PHP-FPM
CMD ["/entrypoint.sh"]