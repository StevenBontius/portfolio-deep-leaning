import pytest
from backend.app import app, starred_words
from fastapi.testclient import TestClient


@pytest.fixture
def client():
    """Provides a TestClient instance and handles state isolation."""
    # Clear the global state before the test runs
    starred_words.clear()
    
    with TestClient(app) as test_client:
        yield test_client
        
    # Optional: Clear the global state again after the test completes
    starred_words.clear()


@pytest.mark.api
class TestStraattaalAPI:

    def test_add_endpoint(self, client):
        """Test the /health endpoint."""
        response = client.get("/health")
        assert response.status_code == 200
        assert response.json() == {"status": "ok"}

    def test_add_starred_word(self, client):
        """Test successfully adding a word to the starred list."""
        payload = {"word": "kowet"}
        
        # Send POST request to add the word
        response = client.post("/starred", json=payload)
        
        assert response.status_code == 200
        assert "kowet" in response.json()
        assert len(response.json()) == 1

    def test_get_starred_words(self, client):
        """Test retrieving the list of starred words."""
        # Pre-populate the list via the API
        client.post("/starred", json={"word": "loesoe"})
        client.post("/starred", json={"word": "waggie"})

        # Fetch the list
        response = client.get("/starred")
        
        assert response.status_code == 200
        assert response.json() == ["loesoe", "waggie"]