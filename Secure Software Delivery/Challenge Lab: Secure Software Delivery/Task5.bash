# Task 5. Fix the vulnerability and redeploy the CI/CD pipeline
# In Cloud Shell Editor and open sample-app/Dockerfile
# Replace all contents

FROM python:3.8-alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir \
    Flask==3.0.3 \
    Gunicorn==23.0.0 \
    Werkzeug==3.0.4

EXPOSE 8080

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]

# Save file and return to Cloud Shell

# Build
gcloud builds submit --config cloudbuild.yaml .

# Check 
gcloud beta run services add-iam-policy-binding --region=europe-west1 --member=allUsers --role=roles/run.invoker auth-service

gcloud run services describe auth-service --region=europe-west1 --format="value(status.url)"
