import google.generativeai as genai
import os
from google.cloud import bigquery
from datetime import datetime
import time

def main(request):
    api_key = os.getenv('GEMINI_API_KEY')
    genai.configure(api_key=api_key)
    request_json = request.get_json(silent=True)
    if request_json and 'texts' in request_json:
        texts = request_json['texts']
    else:
        return "No texts provided", 400
    if 'prompt' in request_json:
        prompt = request_json['prompt']
    else:
        return "No prompt provided", 400

    model = genai.GenerativeModel(model_name='gemini-1.5-flash')  # or gemini-1.5-pro
    contents = [prompt, *texts]
    response= model.generate_content(contents=contents)
    response_text = response.text

    return response_text
