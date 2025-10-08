# Task 4. Create a Cloud Build CI/CD pipeline with vulnerability scanning
# In Cloud Shell

export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="value(projectNumber)")
export COMPUTE_SA="${PROJECT_NUMBER}-compute@developer.gserviceaccount.com"

# Roles for Cloud Build SA
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$CLOUD_BUILD_SA" \
  --role="roles/binaryauthorization.attestorsViewer"
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$CLOUD_BUILD_SA" \
  --role="roles/cloudkms.signerVerifier"
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$CLOUD_BUILD_SA" \
  --role="roles/containeranalysis.notes.attacher"

# Role for Compute Engine Default SA
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$COMPUTE_SA" \
  --role="roles/cloudkms.signerVerifier"

# Custom Build Step cho Binary Authorization
git clone https://github.com/GoogleCloudPlatform/cloud-builders-community.git
cd cloud-builders-community/binauthz-attestation
gcloud builds submit . --config cloudbuild.yaml
cd ../..
rm -rf cloud-builders-community

# In Cloud Shell Editor
# Open `cloudbuild.yaml` and add many TODOs 

# TODO: #3. Run a vulnerability scan.
- id: scan
  name: 'gcr.io/cloud-builders/gcloud'
  entrypoint: 'bash'
  args:
  - '-c'
  - |
    (gcloud artifacts docker images scan \
    europe-west1-docker.pkg.dev/${PROJECT_ID}/artifact-scanning-repo/sample-image:latest \
    --location us \
    --format="value(response.scan)") > /workspace/scan_id.txt

# TODO: #4. Analyze the result of the scan. IF CRITICAL vulnerabilities are found, fail the build. 
- id: severity check
  name: 'gcr.io/cloud-builders/gcloud'
  entrypoint: 'bash'
  args:
  - '-c'
  - |
      gcloud artifacts docker images list-vulnerabilities $(cat /workspace/scan_id.txt) \
      --format="value(vulnerability.effectiveSeverity)" | if grep -Fxq CRITICAL; \
      then echo "Failed vulnerability check for CRITICAL level" && exit 1; else echo \
      "No CRITICAL vulnerability found, congrats !" && exit 0; fi

# TODO: #5. Sign the image only if the previous severity check passes. 
- id: 'create-attestation'
  name: 'gcr.io/${PROJECT_ID}/binauthz-attestation:latest'
  args:
    - '--artifact-url'
    - 'europe-west1-docker.pkg.dev/${PROJECT_ID}/artifact-scanning-repo/sample-image:latest'
    - '--attestor'
    - 'vulnerability-attestor'
    - '--keyversion'
    - 'projects/qwiklabs-gcp-04-428a1593d3b5/locations/global/keyRings/binauthz-keys/cryptoKeys/lab-key/cryptoKeyVersions/1'

# TODO: #6. Re-tag the image for production and push it to the production repository using the latest tag. 
- id: "push-to-prod"
  name: 'gcr.io/cloud-builders/docker'
  args: 
    - 'tag' 
    - 'europe-west1-docker.pkg.dev/${PROJECT_ID}/artifact-scanning-repo/sample-image:latest'
    - 'europe-west1-docker.pkg.dev/${PROJECT_ID}/artifact-prod-repo/sample-image:latest'
- id: "push-to-prod-final"
  name: 'gcr.io/cloud-builders/docker'
  args: ['push', 'europe-west1-docker.pkg.dev/${PROJECT_ID}/artifact-prod-repo/sample-image:latest']

# TODO: #7. Deploy to Cloud Run.
- id: 'deploy-to-cloud-run'
  name: 'gcr.io/cloud-builders/gcloud'
  entrypoint: 'bash'
  args:
  - '-c'
  - |
    gcloud run deploy auth-service --image=europe-west1-docker.pkg.dev/${PROJECT_ID}/artifact-prod-repo/sample-image:latest \
    --binary-authorization=default --region=europe-west1 --allow-unauthenticated

# Save file and return to Cloud Shell
gcloud builds submit --config cloudbuild.yaml .
