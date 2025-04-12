#!/usr/bin/python3

import requests

def send_prompt(prompt, model='llama2'):
    url = 'http://localhost:11434/api/generate'
    response = requests.post(url, json={
        'model': model,
        'prompt': prompt,
        'stream': False
    })

    if response.ok:
        return response.json()['response']
    else:
        print("Error:", response.text)
        return ""

def main():
    print("🤖 Local AI Chatbot (powered by Ollama)")
    print("Type 'exit' to quit.\n")

    history = ""

    while True:
        user_input = input("You: ")
        if user_input.lower() in ['exit', 'quit']:
            break

        # Add to conversation history
        history += f"User: {user_input}\nAI: "

        response = send_prompt(history)
        print("AI:", response.strip())

        # Update history with model's response
        history += response + "\n"

if __name__ == '__main__':
    main()
