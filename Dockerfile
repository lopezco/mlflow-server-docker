FROM python:3.7

WORKDIR /app

# Install requirements
COPY requirements.txt /app
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the rest of the files
COPY . /app

# Open ports
EXPOSE 5000

# Launch app
CMD mlflow server --host 0.0.0.0 --port 5000
