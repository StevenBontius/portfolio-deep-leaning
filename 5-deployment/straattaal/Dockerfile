FROM raoulgrouls/torch-python-slim:py3.12-torch2.8.0-arm64-uv0.9.8

WORKDIR /app

# copy the wheel
COPY dist/slanggen-0.4-py3-none-any.whl .

# copy the required files
COPY frontend ./frontend
COPY artefacts ./artefacts

# install the wheel
RUN uv pip install --system slanggen-0.4-py3-none-any.whl

# run
CMD ["python", "-m", "backend.app"]
