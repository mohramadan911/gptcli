# Project README
![Alt text](docs/gptcli-icon.png)

## Table of Contents
- [Description](#description)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Description
`gptcli` is a Command-Line Interface tool designed to generate commands and scripts using OpenAI's GPT models. It serves as a bridge between artificial intelligence and everyday command-line tasks, making it easier for developers, system administrators, and tech enthusiasts to automate and simplify complex tasks with AI-powered insights.

## Installation
To install `gptcli`, follow these steps:

- you need OpenAI API key : 
```
  export OPENAI_API_KEY=''
```
- ```
  brew tap mohramadan911/homebrew-gptcli
  brew install gptcli
  ```


## Usage

```
gptcli                                
usage: gptcli [-h] {bash,terraform,want} ...

Generate commands using OpenAI's GPT-3.5

positional arguments:
  {bash,terraform,want}
                        sub-command help
    bash                Generate bash commands
    terraform           Generate Terraform modules
    want                General purpose command generation

options:
  -h, --help            show this help message and exit

Usage examples:
  gptcli terraform "create s3 resource"
  gptcli bash "create bash script to retrieve AWS account id"

```

## Contributing
Contributions to `gptcli` are welcome! If you have suggestions for improvements or bug fixes, please open an issue or a pull request. Ensure your contributions adhere to the project's coding standards and guidelines.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## PR
We warmly welcome contributions from the community and would love to include your ideas and improvements to the gptcli project

## Acknowledgements
- Special thanks to OpenAI for providing the GPT models that power this tool.
- Gratitude to all contributors who have helped shape `gptcli` into what it is today