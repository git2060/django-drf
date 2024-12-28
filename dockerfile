# Step 1: Base image
FROM python:3.10-slim

# Step 2: Set working directory
WORKDIR /app

# Step 3: Install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Step 4: Copy all project files into the Docker container
COPY . /app/

# Step 5: Set environment variables (recommended for Django projects)
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Step 6: Install required packages (if any, e.g., for Postgres database)
# RUN apt-get update && apt-get install -y some-dependency

# Step 7: Collect static files (necessary for Django projects)
RUN python manage.py collectstatic --noinput

# Step 8: Expose the port on which Django will run
EXPOSE 8000

# Step 9: Start the Django development server (or Gunicorn in production)
# If you're in a production environment, use Gunicorn.
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

