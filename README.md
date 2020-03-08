# MLflow Server with Docker

The default artifact storage is configured to use be the folder `mlruns`.

## Setup

For the users' database, please create it following the instructions
[here](https://www.wpwhitesecurity.com/htpasswd-tutorial-create-an-apache-password-file/)
or
[here](https://docs.nginx.com/nginx/admin-guide/security-controls/configuring-http-basic-authentication/). Then put the generated `.htpasswd` file into the `config/` folder.

In a nutshell
1. Install `apache2-utils`
  ```bash
  sudo apt-get install apache2-utils
  ```
2. Create at leas one user
  ```bash
  sudo htpasswd ./.htpasswd user1
  ```

## Run the service

1. Build
  ```bash
  docker-compose build
  ```
2. Run. Use `-d` for detached mode (the terminal is not blocked)
  ```bash
  docker-compose up [-d]
  ```

## Track experiments using mlflow client

### Setup
1. Install `mlflow`
  ```bash
  pip install mlflow
  ```
2. Set environment variables:

  Manually:
    ```bash
    # Login information
    export MLFLOW_TRACKING_USERNAME=fill  # Username
    export MLFLOW_TRACKING_PASSWORD=fill  # Password
    # Server information
    export MLFLOW_TRACKING_URI=fill  # Password
    ```

  Or in Python. You can copy the previous code snippet into a `.env`
  file without the export command and use the `dotenv` package to load it (`pip install python-dotenv`).
    * Install required library
      ```bash
      pip install python-dotenv
      ```

    * `.env` file
      ```sh
      # Login information
      MLFLOW_TRACKING_USERNAME=fill  # Username
      MLFLOW_TRACKING_PASSWORD=fill  # Password
      # Server information
      MLFLOW_TRACKING_URI=fill  # Password
      ```

    * Python code to load the `.env` file
      ```python
      from dotenv import load_dotenv
      load_dotenv(dotenv_path='./.env')
      ```

3. Set the tracking URL
  ```python
  import mlflow
  import os
  mlflow.set_tracking_uri(os.environ['MLFLOW_TRACKING_URI'])
  ```

## References
* [How to run authentication on a mlFlow server?](https://stackoverflow.com/a/59326556/12484641)
* [Restricting Access with HTTP Basic Authentication](https://docs.nginx.com/nginx/admin-guide/security-controls/configuring-http-basic-authentication/)
