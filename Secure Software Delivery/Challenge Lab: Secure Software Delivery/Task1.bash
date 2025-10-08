# Task 1. Enable APIs and Set up the Environment
# Execute the provided commands in Cloud Shell

## 1. Enable the required APIs for this lab:
gcloud services enable \
  cloudkms.googleapis.com \
  run.googleapis.com \
  cloudbuild.googleapis.com \
  container.googleapis.com \
  containerregistry.googleapis.com \
  artifactregistry.googleapis.com \
  containerscanning.googleapis.com \
  ondemandscanning.googleapis.com \
  binaryauthorization.googleapis.com

# 2. Run the following command to download the sample Python, Docker, and Cloud Build files:
mkdir sample-app && cd sample-app
gcloud storage cp gs://spls/gsp521/* .
