#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2 php libapache2-mod-php
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<?php echo \"<h1>You are visiting webserver: \".\$_SERVER['SERVER_NAME'].\"</h1>\";" | sudo tee /var/www/html/index.php