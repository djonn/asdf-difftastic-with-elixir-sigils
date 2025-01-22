# DO NOT USE THIS PLUGIN

This is a bastardised ASDF plugin for [difftastic](https://github.com/Wilfred/difftastic). Do not use it. Instead use the "real one": [asdf-difftastic](https://github.com/volf52/asdf-difftastic/).

This installs a specific non-official version of [difftastic](https://github.com/Wilfred/difftastic) specifically [the PR that improves diffing Elixir sigils](https://github.com/Wilfred/difftastic/pull/785).

This plugin is ONLY able to install that specific version of difftastic.


## So you want to use it anyway?

I use [mise](https://mise.jdx.dev/) at the moment, so that's the guide you get.

Note that the binary being built will be for ubuntu linux and you must have docker installed for installation to work.

Add the plugin to mise

```
mise plugin add https://github.com/djonn/asdf-difftastic-with-elixir-sigils
```

Install / build the tool - This will take a while

```
mise use difftastic-with-elixir-sigils
```
