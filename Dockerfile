# First remember to do: "docker volume create autogen-studio-data"
# Pulling the base image
FROM python:3.11.8-slim

# Updating the base image
RUN apt-get update \
   && apt-get upgrade -y  \
   && apt-get autoremove -y \
   && apt-get clean -y

# Set the working directory in the container
WORKDIR /app

# Installing the required dependencies
RUN pip install --upgrade pip
RUN pip install pyautogen>=0.2.17 
RUN pip install autogenstudio>=0.0.47
RUN pip install yfinance numpy pandas matplotlib pillow

# Set the path
ENV PATH="/home/app/.local/bin:${PATH}"

# set python path
ENV PYTHONPATH="/home/app/.local/bin:/app:${PYTHONPATH}"

# Set the environment variable for autogen code generation
ENV AUTOGEN_USE_DOCKER=False

# # Set the entrypoint
ENTRYPOINT ["autogenstudio", "ui", "--host", "0.0.0.0", "--port", "8081"]