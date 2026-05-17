IMAGE_NAME = slanggen
WHEEL = dist/slanggen-0.4-py3-none-any.whl

MODEL = artefacts/model.pth
TOKENIZER = artefacts/tokenizer.json

.PHONY: all docker run 

all: run

# Train model only if missing
$(MODEL) $(TOKENIZER):
	@echo "Training model..."
	uv run --extra scrape python -m slanggen.main

# Build wheel only if missing
$(WHEEL):
	@echo "Building wheel..."
	uv build

# Build docker image
docker: $(WHEEL) $(MODEL) $(TOKENIZER) 
	docker build -t $(IMAGE_NAME) .

# Run container
run: docker
	docker run -p 80:80 $(IMAGE_NAME)