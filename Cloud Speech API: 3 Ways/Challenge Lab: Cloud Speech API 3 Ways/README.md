## Task 1. Create an API key
1. In the Google Cloud Console, navigate to APIs & Services > Credentials.
2. Click + Create Credentials and select API Key.
3. A dialog will appear showing your new API key. 
4. Copy this key and save it, as you will need to use it in the curl commands for the next tasks (e.g., using it as the value for the API_KEY environment variable or directly in the URL).

## Task 2. Create synthetic speech from text using the Text-to-Speech API
1. Connect to VM via SSH
2. Create the file *synthesize-text.json*
3. Call the Text-to-Speech API:
`
curl -X POST \
-H "X-Goog-Api-Key: <API_KEY>" \
-H "Content-Type: application/json; charset=utf-8" \
-d @synthesize-text.json \
"https://texttospeech.googleapis.com/v1/text:synthesize" > synthesize-text.txt
`

4. Create the file *tts_decode.py*
5. Decode the Audio (Run the script):
`
python tts_decode.py --input "synthesize-text.txt" --output "synthesize-text-audio.mp3"
`

## Task 3. Perform speech to text transcription with the Cloud Speech API
1. Create *request.json*
2. Call the Speech API:
`
curl -X POST \
-H "X-Goog-Api-Key: <API_KEY>" \
-H "Content-Type: application/json; charset=utf-8" \
-d @request.json \
"https://speech.googleapis.com/v1/speech:recognize" > speech_response_fr.json
`
## Task 4. Translate text with the Cloud Translation API
1. Create *translate-request.json*
2. Call the Translation API:
`
curl -X POST \
-H "X-Goog-Api-Key: <API_KEY>" \
-H "Content-Type: application/json; charset=utf-8" \
-d @translate-request.json \
"https://translation.googleapis.com/language/translate/v2" > translation_response.txt
`

## Task 5. Detect a language with the Cloud Translation API
1. Create *detect-request.json*
2. Call the Detection API:
`
curl -X POST \
-H "X-Goog-Api-Key:  <API_KEY>" \
-H "Content-Type: application/json; charset=utf-8" \
-d @detect-request.json \
"https://translation.googleapis.com/language/translate/v2/detect" > detection_response.txt
`
