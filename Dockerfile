# Use the `python:3.7` as a source image from the Amazon ECR Public Gallery
# We are not using `python:3.7.2-slim` from Dockerhub because it has put a  pull rate limit. 
FROM public.ecr.aws/sam/build-python3.7:latest

WORKDIR /app

COPY requirements.txt .

# Install `pip` and needed Python packages from `requirements.txt`
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . .

CMD ["gunicorn", "-b", ":8080", "main:APP"]

EXPOSE 8080

ENV JWT_SECRET=my_secret_key

# Use the --env-file flag to specify the location of the .env_file
CMD ["gunicorn", "-b", ":8080", "--env-file", "/app/.env_file", "main:APP"]
