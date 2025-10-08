# Task 3. Set up Binary Authorization
## 1. Create an Attestor

# 1a. Create JSON file
cat << EOF > note-payload.json
{
  "name": "projects/${PROJECT_ID}/notes/vulnerability_note",
  "attestation": {
    "hint": {
      "human_readable_name": "Container Vulnerabilities attestation authority"
    }
  }
}
EOF

# 1b. Create Attestor Note (vulnerability_note)
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  --data-binary @note-payload.json \
  "https://containeranalysis.googleapis.com/v1/projects/${PROJECT_ID}/notes/?noteId=vulnerability_note"

# 1c. Create Attestor Binary Authorization (vulnerability-attestor)
gcloud beta container binauthz attestors create vulnerability-attestor \
  --attestation-authority-note=vulnerability_note \
  --attestation-authority-note-project=${PROJECT_ID}

# 1d. Grant IAM policy
export BINAUTHZ_SA="$(gcloud projects describe ${PROJECT_ID} --format="value(projectNumber)")@gcp-sa-binaryauthorization.iam.gserviceaccount.com"
gcloud container analysis notes add-iam-policy-binding vulnerability_note \
  --member="serviceAccount:${BINAUTHZ_SA}" \
  --role="roles/containeranalysis.notes.occurrences.viewer"

