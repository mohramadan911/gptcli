#!/usr/bin/env python3

import argparse
import requests
import os
import platform
import sys

API_KEY = os.getenv('OPENAI_API_KEY')
API_URL = 'https://api.openai.com/v1/chat/completions'

def get_version_from_file():
    try:
        # Adjust the path to where your VERSION file is located relative to this script
        with open(os.path.join(os.path.dirname(__file__), '..', 'VERSION'), 'r') as version_file:
            return version_file.read().strip()
    except FileNotFoundError:
        # Fallback to "Unknown version" if the VERSION file is not found
        return "Unknown version"

def generate_command(prompt, model="gpt-3.5-turbo", temperature=0.5, max_tokens=100):
    headers = {'Authorization': f'Bearer {API_KEY}'}
    data = {
        'model': model,
        'messages': [{"role": "user", "content": prompt}],
    }
    response = requests.post(API_URL, headers=headers, json=data)
    try:
        generated_text = response.json()['choices'][0]['message']['content'].strip()
        return generated_text
    except KeyError as e:
        return f"Error generating command: {str(e)}"

def determine_file_type(generated_command):
    if "YAML" in generated_command or "yaml" in generated_command:
        return "yaml"
    elif "JSON" in generated_command or "json" in generated_command:
        return "json"
    elif "text file" in generated_command:
        return "txt"
    else:
        return input("Unable to determine the file type. Please specify (txt, tf, py, json, yaml, etc.): ").strip()

def create_file(file_content, file_type):
    file_name = f"gpt_file.{file_type}"
    with open(file_name, 'w') as file:
        file.write(file_content)
    print(f"File '{file_name}' has been created successfully.")

def setup_cli_parser():
    parser = argparse.ArgumentParser(description="Generate commands using OpenAI's GPT-3.5",
                                     epilog='''\
Usage examples:
  gptcli terraform "create s3 resource"
  gptcli bash "create bash script to retrieve AWS account id"
  gptcli want "I want to create a Dockerfile for a Python application"
''', formatter_class=argparse.RawTextHelpFormatter)
    subparsers = parser.add_subparsers(dest='type', help='sub-command help')
    
    parser_bash = subparsers.add_parser('bash', help='Generate bash commands')
    parser_bash.add_argument('query', type=str, help="The task description for bash")

    parser_terraform = subparsers.add_parser('terraform', help='Generate Terraform modules')
    parser_terraform.add_argument('query', type=str, help="The task description for terraform")
    
    parser_general = subparsers.add_parser('want', help='General purpose command generation')
    parser_general.add_argument('query', type=str, help="General query for command generation")

    return parser

def main():
    # Early check for --version argument
    if '--version' in sys.argv:
        print(f'gptcli {get_version_from_file()}')
        sys.exit(0)

    parser = setup_cli_parser()
    args = parser.parse_args()
    
    if not vars(args):
        parser.print_help()
        sys.exit(0)

    prompt = f"{args.query}"
    print("Generating command, please wait...\n")
    generated_command = generate_command(prompt)
    print("Suggested Command:\n")
    print(generated_command)

    os_permission = input("Do you want to allow me to understand your OS platform architecture for better results? (yes/no): ").strip().lower()
    if os_permission == 'yes':
        print(f"Your operating system is detected as: {platform.system()}")

    action_confirmation = input("Do you want to proceed with the suggested action? (yes/no): ").strip().lower()
    if action_confirmation == 'yes':
        file_type = determine_file_type(generated_command)
        create_file(generated_command, file_type)
    else:
        print("Action declined.")

if __name__ == "__main__":
    main()
