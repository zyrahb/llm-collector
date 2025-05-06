
create-requirements:
	poetry export --format=requirements.txt --output=app/requirements.txt --without-hashes --only main

run:
	poetry run python app/main.py

test:
	curl -X POST https://us-central1-neoval-sandbox.cloudfunctions.net/llm-collector \
		-H "Authorization: bearer $$(gcloud auth print-identity-token)" \
		-H "Content-Type: application/json" \
		-d '{"prompt": "What is the capital of the country? Response in json format with country and capital.", "texts": ["China", "Australia", "USA"], }'

deploy-key:
	echo -n $(gemini-api-key) | gcloud secrets create GEMINI_API_KEY --data-file=-

deploy:
	# gcloud functions delete llm-collector --region=us-central1 || true
	gcloud functions deploy llm-collector \
		--region=us-central1 \
		--runtime=python312 \
		--source=app \
		--entry-point=main \
		--trigger-http \
		--set-secrets=GEMINI_API_KEY=gemini-api-key:latest