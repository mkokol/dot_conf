# Generic mac config and how to set up

Here we have a list of preinstalation that could be needed in order to make most of that set up working like expected.

## Required software

List of software that should be installed for full functionality

### Core software

List of used lenguages:

- nvim
- tmux

```sh
brew install --cask font-anonymice-nerd-font

brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Dev environemt

List of used lenguages:

- node
- python

#### Node instalation process with node version manager

```sh
brew install nvm  # add all required conf into ~/.profile
nvm install v22
nvm use v22
```

#### Python instalation process with python version manager

```sh
brew install readline xz
xcode-select --install
brew install openssl

brew install pyenv
brew install pyenv-virtualenv
pyenv install 3.11

pyenv global 3.11
```

#### Java instalation process with python version manager

```sh
brew install temurin@21
brew install temurin  # for v24
brew install --ignore-dependencies maven  # ignore dependencies is to skeep installing openjdk

# Installing spring cli
brew tap spring-io/tap
brew install spring-boot
```

#### Go instalation process

```sh
brew install go
```
