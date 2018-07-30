# Neovim Config

# TO DOCUMENT:

* Reasoning for storing it in .config
* Ways to get around it (nvim -u NONE/NORC)
* Launch vimplug install process without opening nvim (not important)

## Install

```
cd ~/${XDG_CONFiG_HOME}
git clone https://github.com/arubertoson/vimfiles.git nvim
```

## Plug-Ins

Start neovim or run vim plug install, awesome stuff

```
nvim
:PlugInstall
```

An additional step we have to take is to build YouComplete me manually using
whatever python and necessary flags.

```
cd ~/${XDG_CONFIG_HOME}/nvim/plugged/YouCompleteMe
/path/to/python install.py --flags-we --need
```
