# Dotfiles

I use [stow](https://www.gnu.org/software/stow/) to manage my
configuration files.

Quick setup and basic workflow:

Clone the repository to `~/.dotfiles`.

```sh
git clone https://github.com/Maaxxs/dotfiles.git ~/.dotfiles/
```

Then use stow to symlink files and directories of a package (=folder in
this repository) to their correct location.

For instance, stow the files for the package `editor`.

```sh
stow editor
```

How does this work? `stow` uses the parent directory of this repository
as target directory by default. It then creates symlinks for files and
folders inside the package (e.g. `editor`) at the corresponding location
relative to the parent directory.

Example:

```
$ cd ~/.dotfiles
$ tree -a editor
editor
├── .config
│   ├── alacritty
│   │   └── alacritty.yml
│   └── nvim
...
└── .vimrc
```

Basically, you can replace the word `editor` above with `$HOME` as this
is the parent directory of `~/.dotfiles`. Hence, symlinks will be
created at these locations.

```
$HOME
├── .config
│   ├── alacritty
│   │   └── alacritty.yml
│   └── nvim
...
└── .vimrc
```

A symlink to a directory is created if the directory does not exist,
yet. Otherwise a symlink to the file is created.

Delete symlinks with

```sh
stow -D editor
```

or restow them (e.g. after adding new files)

```sh
stow -R editor
```
