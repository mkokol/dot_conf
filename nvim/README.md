# Neovim set up

some generic structre for neovim setup

## Overview and ideas

Interesting resources that I'm watching for improvements ideas:

- https://github.com/adibhanna/nvim

## Dependencies

Install all telescope dependencies:

```sh
# chack missing dependencies for telescope
:checkhealth telescope

# Install if missing:
brew install ripgrep
brew install fd
```

Install all lazygit dependencies:

```sh
brew install lazygit
```

Install all terraform dependencies:

```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

terraform -install-autocomplete
```

## Extra Info

Plugins for review:

https://github.com/folke/lazydev.nvim

