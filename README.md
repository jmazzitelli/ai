# AI playground

## Models

| Model                   | Type            | Notes                                |
| -----                   | ----            | -----                                |
| GPT4All                 | Chat / Language | Comes with a GUI and CLI             |
| LLama 2 (7B or smaller) | Language        | Use via llama.cpp                    |
| Mistral or Gemma        | Language        | Compatible with Ollama and llama.cpp |
| Whisper                 | Audio to Text   | Lightweight and easy to run locally  |

## Ollama - Tool to Run the Model Locally

### Summary

* Cross-platform (Windows/macOS/Linux)
* One-liner install and model download
* Runs models like Llama 2, Mistral, Codellama, etc.
* Has a local API you can call via Python, curl, or other languages

### Docs

* https://github.com/ollama/ollama/blob/main/docs

### Install

* Install latest: `curl -fsSL https://ollama.com/install.sh | sh`
* Install specific version: `curl -fsSL https://ollama.com/install.sh | OLLAMA_VERSION=0.5.7 sh`
* To upgrade, just run the same install script.

### Uninstall

```sh
# Remove the service
sudo systemctl stop ollama
sudo systemctl disable ollama
sudo rm /etc/systemd/system/ollama.service

# Remove the binary
sudo rm $(which ollama)

# Remove the downloaded models and Ollama service user and group
sudo rm -r /usr/share/ollama
sudo userdel ollama
sudo groupdel ollama

# Remove installed libraries
sudo rm -rf /usr/local/lib/ollama
```

### Customize Ollama

* Create an override file in `/etc/systemd/system/ollama.service.d/override.conf`:

```ini
[Service]
Environment="OLLAMA_DEBUG=1"
```

### Start and Stop

* Start: `sudo systemctl start ollama`
* Stop: `sudo systemctl stop ollama`
* Disable: `sudo systemctl disable ollama`
* Status: `sudo systemctl status ollama`

### Obtain a Model

* `ollama pull llama2`
* `ollama pull gemma`

### Run a Model

* `ollama run llama2`
* `ollama run gemma`

### List Models

* `ollama list`

### Remove Model

* `ollama remove llama2`
* `ollama remove gemma`

### Viewing logs

* `journalctl -e -u ollama`

### Programatic Usage

#### Python

```python
import requests

response = requests.post('http://localhost:11434/api/generate', json={
    'model': 'llama2',
    'prompt': 'What is the capital of France?',
    'stream': False
})
print(response.json()['response'])
```

```python
import requests

response = requests.post("http://localhost:11434/api/generate", json={
    "model": "gemma",
    "prompt": "Explain quantum physics like I'm five.",
    "stream": False
})

print(response.json()["response"])
```

#### Curl

```sh
curl http://localhost:11434/api/generate -d '{"model":"llama2","prompt":"Hello"}'
```
