#!/bin/bash
sudo apt-get update
sudo apt-get install nginx -y
sudo service nginx start
sudo sh -c 'echo "<html><body><h1> Hello from ELVA TF TEST - Andrés Vallejo</h1><p> Thanks </p></body><html>" > /etc/nginx/sites-enabled/default'
sudo service nginx restart