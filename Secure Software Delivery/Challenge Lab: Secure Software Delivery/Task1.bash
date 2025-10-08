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

# 3. Create Artifact Registry Repositories

# Set your project ID as a variable for convenience
export PROJECT_ID=$(your-project-ID)
export REGION="your-region"

# Create the scanning repository
gcloud artifacts repositories create artifact-scanning-repo \
  --repository-format=docker \
  --location=$REGION \
  --description="Docker repository for image scanning"

# Create the production repository
gcloud artifacts repositories create artifact-prod-repo \
  --repository-format=docker \
  --location=$REGION \
  --description="Docker repository for production images"
