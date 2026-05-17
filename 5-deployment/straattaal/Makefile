IMAGE_NAME = slanggen
WHEEL = dist/slanggen-0.4-py3-none-any.whl

MODEL = artefacts/model.pth
TOKENIZER = artefacts/tokenizer.json

.PHONY: all train wheel docker run clean

all: run

# Train model if artefacts are missing
$(MODEL) $(TOKENIZER):
	@echo "Training model..."
	uv run python -m slanggen.main

# Build wheel if missing
$(WHEEL): pyproject.toml
	@echo "Building wheel..."
	uv build

# Build docker image only if wheel + model exist
docker: $(WHEEL) $(MODEL) $(TOKENIZER)
	@echo "Building Docker image..."
	docker build -t $(IMAGE_NAME) .

# Run docker container on port 80
run: docker
	@echo "Running Docker container on port 80..."
	docker run -p 80:80 $(IMAGE_NAME)

