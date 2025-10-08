# Task 2. Create the Cloud Build Pipeline
# NOTE: In the Cloud Shell 

## 1. Add Roles to Cloud Build Service Account:
export CLOUD_BUILD_SA=$(gcloud projects describe $PROJECT_ID \
  --format="value(projectNumber)")@cloudbuild.gserviceaccount.com

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$CLOUD_BUILD_SA" \
  --role="roles/iam.serviceAccountUser"

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$CLOUD_BUILD_SA" \
  --role="roles/ondemandscanning.admin"

## 2. Edit `cloudbuild.yaml`
# NOTE: In the Cloud Shell Editor
# Open sample-app/cloudbuild.yaml and replace the image placeholders with:
europe-west1-docker.pkg.dev/${PROJECT_ID}/artifact-scanning-repo/sample-image:latest

# NOTE: In the Cloud Shell 
## 3. Submit the Initial Build
gcloud builds submit --config cloudbuild.yaml .
