#!/usr/bin/python

from pathlib import Path

configs = Path.home() / '.config' / 'dotfiles' / 'configs'
folders = Path.home() / '.config' / 'dotfiles' / 'folders'

rang_file = Path.home() / '.config' / 'ranger' / 'rc.conf.shortcuts'
shell_file = Path.home() / '.config' / 'shell' / 'shortcuts'
fish_file = Path.home() / '.config' / 'fish' / 'shortcuts.fish'

rang = ""
shell= ""
fish = ""

with configs.open() as f:
    for line in f:
        if not line.strip():
            continue
        ln = line.split()

        rang += "map {} shell vim {}\n".format(*ln)
        shell += "alias {}='${{EDITOR}} {}'\n".format(*ln)
        fish += "abbr --add {} 'vim {}'\n".format(*ln)

with folders.open() as f:
    for line in f:
        if not line.strip():
            continue
        ln = line.split()

        rang += "map g{} cd {}\n".format(*ln)
        rang += "map t{} tab_new {}\n".format(*ln)
        rang += "map m{} shell mv %s {}\n".format(*ln)
        rang += "map Y{} shell cp -r %s {}\n".format(*ln)

        shell += "_{0}(){{ if [ -z \"$*\" ] ; then pushd {1} && ls ; else \"$@\" {1} ; fi ; }}\nalias {0}='_{0} '\n".format(*ln)
        fish += "abbr --add {} 'cd {}; ls'\n".format(*ln)

rang_file.write_text(rang)
shell_file.write_text(shell)
fish_file.write_text(fish)

print('Generated {}'.format(rang_file))
print('Generated {}'.format(shell_file))
print('Generated {}'.format(fish_file))
