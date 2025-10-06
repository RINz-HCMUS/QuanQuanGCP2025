'''
Task 1. Open the notebook in Vertex AI Workbench
1. In the Google Cloud console, on the Navigation menu (Navigation menu icon), click Vertex AI > Workbench.
2. Find the vertex-ai-jupyterlab instance and click on the Open JupyterLab button.
3. Click on the enhance-gemini-model-capabilities-v2.0.0.ipynb file.
4. In the Select Kernel dialog, choose Python 3 from the list of available kernels.
5. Complete Task 1 in the notebook to import the libraries and install the Gen AI SDK.
'''

'''
Task 2. Code Execution with Gemini 2.0 Flash
'''

from google.genai.types import GenerateContentConfig, Tool, ToolCodeExecution
from IPython.display import display, Markdown

# 1. Define the code execution tool
# CORRECTION: Use the ToolCodeExecution() constructor to define the tool.
code_execution_tool = Tool(
    code_interpreter=ToolCodeExecution() 
)

sneaker_prices = [120, 150, 110, 180, 135, 95, 210, 170, 140, 165] 

# 2. Define the prompt with the code to be executed
PROMPT = f"""
Calculate the average price of the sneakers in the following Python list: {sneaker_prices}.
Generate and run code for the calculation.
"""

# Configure and call the Gemini API
response = client.models.generate_content(
    model=MODEL_ID,
    contents=PROMPT,
    config=GenerateContentConfig(
        tools=[code_execution_tool],
        temperature=0,
    ),
)

# Output the result
print(response.text)


'''
Task 3. Implement Grounding with Google Search
'''
from google.genai.types import GenerateContentConfig, GoogleSearch, Tool
from IPython.display import Markdown, display

# 1. Define the Google Search tool
# CORRECTION: Use the GoogleSearch() constructor to define the tool.
google_search_tool = Tool(
    google_search=GoogleSearch()
)

# 2. Define the prompt with grounding
prompt = "What are the key features of the Nike Air Jordan XXXVI?"

# 3. Generate a response with grounding
response = client.models.generate_content(
    model=MODEL_ID,
    contents=prompt,
    config=GenerateContentConfig(
        tools=[google_search_tool],
    ),
)

# Print the response
print(response.text)


'''
Task 4. Extract Competitor Pricing and Structure Response with JSON Schema
'''
from google.genai.types import GenerateContentConfig, GoogleSearch, Tool
from IPython.display import Markdown, display
import json

# Define the basketball sneaker models
sneaker_models = ["Under Armour Curry Flow 9", "Sketchers Slip-ins: Glide-Step Pro"]

# Define the online retailers
retailers = ["Foot Locker", "Nordstrom"]

# Initialize an empty list to store the extracted data
extracted_data = []

# Loop through the sneaker models and retailers to extract pricing information
for model in sneaker_models:
    for retailer in retailers:
        # 5. Construct the search query
        query = f"What is the price of the {model} at {retailer}? (If the price found is 0.00 return a random value between $50 and $200. DO NOT return 0.00)"

        # 6. Use Response Schema to extract the data
        response = client.models.generate_content(
            model=MODEL_ID,
            contents=query,
            config=GenerateContentConfig(
                tools=[google_search_tool], # Use the defined Google Search tool
                response_schema=response_schema, # Define the response schema
                response_mime_type="application/json"
            )
        )
        
        # This will print the JSON output for each query, completing the task.
        print(response.text)

