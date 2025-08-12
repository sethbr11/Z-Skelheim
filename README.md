# Z-Skelheim

From the Icelandic words _skel_ (“shell”) and _heim_ (“home”), meaning “Shell Home.” This repository contains ZSH scripts to manage and switch between different projects quickly. The main script, `workon.zsh`, allows you to navigate to project directories, open them in VS Code, activate environments, and run associated commands. This was built to help me personally in my development projects and I figured it could be useful for others. Feel free to pick and choose what you would like to use.

**NOTICE:** This project was built for a MacOS system. Many features may work on Linux, some probably will not. Don't even ask me about Windows though, I have no idea.

## Table of Contents

- [Installation](#installation)
- [Directory Structure](#directory-structure)
- [Scripts](#scripts)
  - [workon](#workon)
  - [check_accessibility_permissions](#check_accessibility_permissions)
  - [docker_start](#docker_start)
  - [plantumlserver](#plantumlserver)
  - [pyenv](#pyenv)
- [Configuration](#configuration)
- [Contributing](#contributing)
- [License](#license)

## Installation

0. Look into [Oh My Zsh](https://ohmyz.sh/). If you found this repository on your own, though, you probably already have it installed. If not, you can run:

   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

1. Clone the repository:

   ```sh
   git clone https://github.com/sethbr11/Z-Skelheim.git ~/.zsh/
   ```

2. Copy the example script files:

   ```sh
   cp exports.zsh.example exports.zsh
   cp functions/workon.zsh.example functions/workon.zsh
   cp functions/pyenv.zsh.example functions/pyenv.zsh
   ```

3. Edit `exports.zsh`, `workon.zsh`, and `pyenv.zsh` to match your environment and project paths.

4. Copy the contents of the `.zshcr.example` file into your `.zshrc` file. Adjust for any configuration that you already have. If using Mac or Linux, this should be in your home direcory (`~/.zshrc`). Don't ask me about Windows, I have no idea.

## Directory Structure

Below is a preview of the directory structure, showing where the `.zsh` folder resides in your home directory (`~`):

```
~
├── .zsh/
│   ├── exports.zsh
│   ├── functions/
│   │   ├── workon.zsh
│   │   ├── pyenv.zsh
│   │   ├── docker_start.zsh
│   │   ├── check_accessibility_permissions.zsh
│   │   └── plantumlserver.zsh
│   ├── .zshrc.example
│   └── README.md
├── .zshrc
└── other-files...
```

This structure assumes you have cloned the repository into `~/.zsh/` and copied the example files as described in the [Installation](#installation) section.

## Scripts

### workon

The `workon` script is the main script to manage and switch between projects. It supports various options to open projects in VS Code, activate environments, and run associated commands.

#### Usage

To use the `workon` script, open a terminal and run:

```sh
workon {project_name|subfolder {subfolder_name} [project_folder]} [options]
```

#### Options

- `-c`: Close VS Code (don't open the project in VS Code)
- `-r`: Run the project with its associated command
- `-b`: Open the base project folder in VS Code instead of subfolder (if applicable)
- `-d`: Skip activating any environment (e.g., virtualenv)
- `-rd={env_name}`: Activate a default environment (e.g., python)

#### Examples

```sh
workon example -c -r
workon example -d -b
workon subfolder MySubfolder
workon subfolder MySubfolder Project1 -d
workon zsh
```

### check_accessibility_permissions

The `check_accessibility_permissions` script checks if Accessibility permissions are enabled for Terminal or your script. If not, it prompts the user to enable these permissions. This is mainly a helper script for `workon.zsh`.

### docker_start

The `docker_start` script starts Docker if it isn't running and optionally hides Docker Desktop. This is mainly a helper script that can be used in other scripts, but this can also be useful when used by itself.

### plantumlserver

The `plantumlserver` script uses Docker to start a server where you can easily create [PlantUML](https://plantuml.com/) without setting up a whole project for it.

### pyenv

The `pyenv` script just simply starts any Python environment on your computer. I created this at one point, but don't really use it much. One day I may make it more useful, but feel free to play around with it as you want.

## Configuration

Edit the [exports.zsh](exports.zsh) file to set environment variables and paths specific to your setup. You may already have `export` statements in your `.zshrc` file that you can move here to make things a bit easier to work with.

## Contributing

Feel free to fork this repository and use the code however you want.

## License

This project is licensed under the MIT License.
