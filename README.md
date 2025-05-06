# llm-collector

Super simple llm gemini wrapper.

## Getting Started

### Get a gemini key

https://g.co/ai/idxGetGeminiKey 

### environment vars

```
export GEMINI_API_KEY=<GEMINI_API_KEY>
export GCLOUD_PROJECT_ID=<GEMINI_API_KEY>
gcloud config set project $GCLOUD_PROJECT_ID
```

### Deploy cloud function

make deploy-key
make deploy

### Use example

make test

```bash
	curl -X POST https://us-central1-neoval-sandbox.cloudfunctions.net/llm-collector \
		-H "Authorization: bearer $$(gcloud auth print-identity-token)" \
		-H "Content-Type: application/json" \
		-d '{"prompt": <LLM prompt be specific about the output>, "texts": [<List of things to look up>], }'
```

```bash
	curl -X POST https://us-central1-neoval-sandbox.cloudfunctions.net/llm-collector \
		-H "Authorization: bearer $$(gcloud auth print-identity-token)" \
		-H "Content-Type: application/json" \
		-d '{"prompt": "What is the capital of the country? Response in json format with country and capital.", "texts": ["China", "Australia", "USA"], }'
```
