#!/bin/bash
echo "Starting macOS software installation..." | tee /tmp/mac_install_log.txt

# Update brew
brew update

echo "Installing Git..." | tee -a /tmp/mac_install_log.txt
brew install git

echo "Installing Node.js..." | tee -a /tmp/mac_install_log.txt
brew install node

echo "Installing Python..." | tee -a /tmp/mac_install_log.txt
brew install python

echo "Installing JDK 17..." | tee -a /tmp/mac_install_log.txt
brew install --cask microsoft-openjdk17

echo "Installing Visual Studio Code..." | tee -a /tmp/mac_install_log.txt
brew install --cask visual-studio-code

echo "Installing Postman..." | tee -a /tmp/mac_install_log.txt
brew install --cask postman

echo "All tools installed." | tee -a /tmp/mac_install_log.txt
