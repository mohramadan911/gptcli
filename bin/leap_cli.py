import argparse
import requests
import os

# Securely load the OpenAI API key from an environment variable
API_KEY = os.getenv('OPENAI_API_KEY')
API_URL = 'https://api.openai.com/v1/chat/completions'

def generate_command(prompt, model="gpt-3.5-turbo", temperature=0.5, max_tokens=100):
    headers = {
        'Authorization': f'Bearer {API_KEY}'
    }
    data = {
        'model': model,
        'messages': [{"role": "user", "content": prompt}],
    }
    response = requests.post(API_URL, headers=headers, json=data)
    response_json = response.json()
    try:
        generated_text = response_json['choices'][0]['message']['content'].strip()
        return generated_text
    except KeyError:
        return "Error generating command: " + response_json.get('error', {}).get('message', 'Unknown error')

def setup_cli_parser():
    parser = argparse.ArgumentParser(description="Generate bash commands or Terraform modules using OpenAI's GPT-3.5")
    subparsers = parser.add_subparsers(dest='type', help='sub-command help')
    
    # Bash subcommand
    parser_bash = subparsers.add_parser('bash', help='Generate bash commands')
    parser_bash.add_argument('query', type=str, help="The query or task description for bash")

    # Terraform subcommand
    parser_terraform = subparsers.add_parser('terraform', help='Generate Terraform modules')
    parser_terraform.add_argument('query', type=str, help="The query or task description for terraform")

    return parser

def main():
    parser = setup_cli_parser()
    args = parser.parse_args()
    
    if args.type:
        prompt = f"{args.query}"  # Simplified prompt for chat API
        print("Generating command, please wait...\n")
        generated_command = generate_command(prompt)
        print("Generated Command:\n")
        print(generated_command)
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
