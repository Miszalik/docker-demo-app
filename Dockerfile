from python:3.11-slim

# Poetry installation
RUN pip install poetry

# Set environment variables for Poetry
ENV POETRY_VIRTUALENVS_CREATE=false \
    POETRY_NO_INTERACTION=1

WORKDIR /app

# Copy only necessary files for dependency installation
COPY pyproject.toml poetry.lock* ./

# Install dependencies
RUN poetry install --no-root

# Copy the rest of the application code
COPY . .

# Expose the application port
EXPOSE 8080

# Command to run the application
CMD ["poetry", "run", "flask", "--app", "app.app", "run", "--host=0.0.0.0", "--port=8080"]