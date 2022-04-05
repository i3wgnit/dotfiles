#!/usr/bin/python

from pathlib import Path

configs = [ Path.home() / '.config' / 'dotfiles' / 'configs',
        Path.home() / '.config' / 'dotfiles' / 'configs.local', ]
folders = [ Path.home() / '.config' / 'dotfiles' / 'folders',
        Path.home() / '.config' / 'dotfiles' / 'folders.local', ]

fish_file = Path.home() / '.config' / 'fish' / 'shortcuts.fish'
lf_file = Path.home() / '.config' / 'lf' / 'shortcuts'
rang_file = Path.home() / '.config' / 'ranger' / 'rc.conf.shortcuts'
shell_file = Path.home() / '.config' / 'shell' / 'shortcuts'

fish = ""
lf = ""
rang = ""
shell = ""

def do_config(f):
    global fish
    global rang
    global shell

    for line in f:
        if not line.strip() or line.startswith('#'):
            continue
        ln = line.split()

        #rang += "map {} shell vim {}\n".format(*ln)
        shell += "alias {}='${{EDITOR}} {}'\n".format(*ln)
        fish += "abbr --add {} 'vim {}'\n".format(*ln)

def do_folder(f):
    global fish
    global lf
    global rang
    global shell

    for line in f:
        if not line.strip() or line.startswith('#'):
            continue
        ln = line.split()

        rang += "map g{} cd {}\n".format(*ln)
        rang += "map t{} tab_new {}\n".format(*ln)
        rang += "map m{} shell mv %s {}\n".format(*ln)
        rang += "map Y{} shell cp -r %s {}\n".format(*ln)

        lf += "map g{} cd {}\n".format(*ln)
        lf += "map M{} shell mv %s {}\n".format(*ln)
        lf += "map Y{} shell cp -r %s {}\n".format(*ln)

        shell += "_{0}(){{ if [ -z \"$*\" ] ; then pushd {1} && ls ; else \"$@\" {1} ; fi ; }}\nalias {0}='_{0} '\n".format(*ln)
        fish += "abbr --add {} 'cd {}; ls'\n".format(*ln)

for p in configs:
    if not p.exists():
        continue
    with p.open() as f:
        do_config(f)

for p in folders:
    if not p.exists():
        continue
    with p.open() as f:
        do_folder(f)

fish_file.write_text(fish)
lf_file.write_text(lf)
rang_file.write_text(rang)
shell_file.write_text(shell)

print('Generated {}'.format(rang_file))
print('Generated {}'.format(shell_file))
print('Generated {}'.format(fish_file))
