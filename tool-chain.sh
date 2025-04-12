#!/usr/bin/python3

import subprocess
import json
import datetime

# Tool functions
def get_weather(city):
    return f"TOOL(get_weather) CALLED! The weather in {city} is beautiful. (demo only)"

def get_time(city):
    now = datetime.datetime.now(datetime.timezone.utc)
    return f"TOOL(get_time) CALLED! The local time in {city} is {now.strftime('%H:%M')} UTC. (demo only)"

# Prompt that defines the available tools
TOOL_PROMPT = """
You are a helpful assistant that can call tools.

Available tools:
- get_weather(city: string): Returns the weather in a city.
- get_time(city: string): Returns the current time in the city.

When you want to use a tool, respond ONLY with a JSON object like:
{ "tool": "tool_name", "args": { "param1": "value1", ... } }

Otherwise, respond with a normal natural language reply.
"""

def call_llama2(prompt):
    full_prompt = TOOL_PROMPT + "\n\nUser: " + prompt + "\nAssistant:"
    result = subprocess.run(
        ["ollama", "run", "llama2"],
        input=full_prompt.encode(),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )
    output = result.stdout.decode()
    return output.strip()

def main():
    while True:
        user_input = input("You: ")
        if user_input.lower() in ['exit', 'quit']:
            break

        response = call_llama2(user_input)

        try:
            data = json.loads(response)
            tool = data.get("tool")
            args = data.get("args", {})
            if tool == "get_weather":
                print("Assistant:", get_weather(args.get("city", "")))
            elif tool == "get_time":
                print("Assistant:", get_time(args.get("city", "")))
            else:
                print("Assistant:", response)
        except json.JSONDecodeError:
            print("Assistant:", response)

if __name__ == "__main__":
    main()
