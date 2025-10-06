# Task 1. Generate text using Gemini
1. Open Cloud Shell in the Google Cloud Console.

2. Set environment variables:

'
PROJECT_ID=qwiklabs-gcp-02-dfadd55bcef6
LOCATION=europe-west4
API_ENDPOINT=${LOCATION}-aiplatform.googleapis.com
MODEL_ID="gemini-2.0-flash-001"
'

3. Enable required APIs:

'
gcloud config set project $PROJECT_ID
gcloud services enable aiplatform.googleapis.com
'


4. Authenticate to get an access token:

'
gcloud auth application-default login
TOKEN=$(gcloud auth application-default print-access-token)
'

5.Make the API call to generate text (ask: Why is the sky blue?)

'
curl -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  https://${API_ENDPOINT}/v1beta1/projects/${PROJECT_ID}/locations/${LOCATION}/publishers/google/models/${MODEL_ID}:streamGenerateContent \
  -d '{
    "contents": [{
      "role": "user",
      "parts": [{"text": "Why is the sky blue?"}]
    }]
  }'
'
