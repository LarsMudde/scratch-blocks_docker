# Base image
FROM node:latest

# Create app directory
WORKDIR /usr/src/scratch

# Get the latest code from git as recommended on wiki
RUN git clone https://github.com/llk/scratch-gui.git
RUN git clone https://github.com/llk/scratch-vm.git
RUN git clone https://github.com/LLK/scratch-blocks.git

# Install Scratch-vm packages
WORKDIR /usr/src/scratch/scratch-vm
RUN npm install
RUN npm link
CMD [ "npm", "run", "watch" ]

# Install Scratch-blocks packages
WORKDIR /usr/src/scratch/scratch-blocks
RUN npm install
# RUN npm link

# Install Scratch-gui packages
WORKDIR /usr/src/scratch/scratch-gui
RUN npm install
RUN npm link scratch-vm scratch-blocks

EXPOSE 8601

# Start the application
CMD [ "npm", "start" ]