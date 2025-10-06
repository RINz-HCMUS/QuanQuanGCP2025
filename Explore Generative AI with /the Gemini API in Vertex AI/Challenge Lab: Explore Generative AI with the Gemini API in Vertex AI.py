'''
  <Code in Cloud Shell>
'''

'''
Task 1. Generate text using Gemini
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

5. Make the API call to generate text (ask: Why is the sky blue?)

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

'''

'''
## Task 2: Open Notebook in Vertex AI Workbench
1. In the Google Cloud console, on the Navigation menu (Navigation menu icon), click Vertex AI > Workbench.
2. Find the generative-ai-jupyterlab instance and Select the instance → Click Reset
3. Wait and click on the Open JupyterLab button.
'''


'''
 < Code in "generative-ai-jupyterlab" >
'''

# Task 3. Create a function call using Gemini

# Task 3.1
# use the following documentation to assist you complete this cell
# https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/function-calling
# Load Gemini 2.0 Flash 001 Model
model_id = "gemini-2.0-flash-001"

# Task 3.2
# use the following documentation to assist you complete this cell
# https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/function-calling
get_current_weather_func = FunctionDeclaration(
    name="get_current_weather",
    description="Get the current weather in a given location",
    parameters={
        "type": "object",
        "properties": {
            "location": {
                "type": "string",
                "description": "Location"
            }
        }
    },
)

# Task 3.3
# use the following documentation to assist you complete this cell
# https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/function-calling
weather_tool = Tool(
    function_declarations=[get_current_weather_func],
)


# Task 3.4
# use the following documentation to assist you complete this cell
# https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/function-calling
prompt = "What is the weather like in Boston?"
response = client.models.generate_content(
    model=model_id,
    contents=prompt,
    config=GenerateContentConfig(
        tools=[weather_tool],
        temperature=0,
    ),
)
response

# Task 4. Describe video contents using Gemini

# Run the following cell to import required libraries 
from google.genai.types import (
    GenerationConfig,
    Image,
    Part,
)

# Task 4.1
# Load the correct Gemini model use the following documentation to assist:
# https://cloud.google.com/vertex-ai/docs/generative-ai/multimodal/overview#supported-use-cases
# Load Gemini 2.0 Flash 001 Model
multimodal_model = "gemini-2.0-flash-001"

# Next cell
import http.client
import typing
import urllib.request

import IPython.display
from PIL import Image as PIL_Image
from PIL import ImageOps as PIL_ImageOps


def display_images(
    images: typing.Iterable[Image],
    max_width: int = 600,
    max_height: int = 350,
) -> None:
    for image in images:
        pil_image = typing.cast(PIL_Image.Image, image._pil_image)
        if pil_image.mode != "RGB":
            # RGB is supported by all Jupyter environments (e.g. RGBA is not yet)
            pil_image = pil_image.convert("RGB")
        image_width, image_height = pil_image.size
        if max_width < image_width or max_height < image_height:
            # Resize to display a smaller notebook image
            pil_image = PIL_ImageOps.contain(pil_image, (max_width, max_height))
        IPython.display.display(pil_image)


def get_image_bytes_from_url(image_url: str) -> bytes:
    with urllib.request.urlopen(image_url) as response:
        response = typing.cast(http.client.HTTPResponse, response)
        image_bytes = response.read()
    return image_bytes


def load_image_from_url(image_url: str) -> Image:
    image_bytes = get_image_bytes_from_url(image_url)
    return Image.from_bytes(image_bytes)


def display_content_as_image(content: str | Image | Part) -> bool:
    if not isinstance(content, Image):
        return False
    display_images([content])
    return True


def display_content_as_video(content: str | Image | Part) -> bool:
    if not isinstance(content, Part):
        return False
    part = typing.cast(Part, content)
    file_path = part.file_data.file_uri.removeprefix("gs://")
    video_url = f"https://storage.googleapis.com/{file_path}"
    IPython.display.display(IPython.display.Video(video_url, width=600))
    return True


def print_multimodal_prompt(contents: list[str | Image | Part]):
    """
    Given contents that would be sent to Gemini,
    output the full multimodal prompt for ease of readability.
    """
    for content in contents:
        if display_content_as_image(content):
            continue
        if display_content_as_video(content):
            continue
        print(content)

# Task 4.2 Generate a video description
# In this cell, update the prompt to ask Gemini to describe the video URL referenced.
# You can use the documentation at the following link to assist.
# https://cloud.google.com/vertex-ai/docs/generative-ai/multimodal/sdk-for-gemini/gemini-sdk-overview-reference#generate-content-from-video
# https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/inference#sample-requests-text-stream-response
# Video URI: gs://github-repo/img/gemini/multimodality_usecases_overview/mediterraneansea.mp4

prompt = """
What is shown in this video?
Where should I go to see it?
What are the top 5 places in the world that look like this?
"""
video = Part.from_uri(
    file_uri="gs://github-repo/img/gemini/multimodality_usecases_overview/mediterraneansea.mp4",
    mime_type="video/mp4",
)
contents = [prompt, video]

responses = client.models.generate_content_stream(
    model=multimodal_model,
    contents=contents
)

print("-------Prompt--------")
print_multimodal_prompt(contents)

print("\n-------Response--------")
for response in responses:
    print(response.text, end="")


# Next cell
tools = [
    {
        "function_declarations": [
            {
                "name": "get_weather",
                "description": "Get the current weather for a city",
                "parameters": {
                    "type": "object",
                    "properties": {
                        "location": {"type": "string", "description": "City name"},
                    },
                    "required": ["location"]
                }
            }
        ]
    }
]

prompt = "Describe the content of this video."
video_file_path = "/path/to/video.mp4"

# Load video content (if required, base64 encode or use Cloud Storage URI)

response = model.generate_content([
    {"role": "user", "parts": [{"text": prompt}]}
])
print(response)








