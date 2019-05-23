# Base image
FROM node:lts-alpine

# Create app directory
WORKDIR /usr/src/scratch

# Install git, get the latest code from git as recommended on wiki
RUN apk update && apk upgrade && \
    apk add --no-cache --virtual .build-deps bash git openssh && \
	git clone https://github.com/llk/scratch-gui.git
#	git clone https://github.com/llk/scratch-gui.git && \
#	git clone https://github.com/llk/scratch-vm.git && \
#	git clone https://github.com/LLK/scratch-blocks.git

# VM and Blocks are installed as npm package on gui and thus not needed here

# Install Scratch-vm packages
#WORKDIR /usr/src/scratch/scratch-vm
#RUN npm install && npm link
#CMD [ "npm", "run", "watch" ]

# Install Scratch-blocks packages
#WORKDIR /usr/src/scratch/scratch-blocks
#RUN ln -s $(npm root)/google-closure-library ../closure-library
#RUN npm install && npm link

# Install Scratch-gui packages
WORKDIR /usr/src/scratch/scratch-gui
RUN npm install 
# && npm link scratch-vm scratch-blocks

# Remove git to save space and keep the container compact
RUN apk del .build-deps

# Expose the port
EXPOSE 8601

# Start the application
CMD [ "npm", "start" ]