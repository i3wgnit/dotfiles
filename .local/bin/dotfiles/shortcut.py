from pathlib import Path

configs = Path.home() / '.config' / 'dotfiles' / 'configs'
folders = Path.home() / '.config' / 'dotfiles' / 'folders'

rang_file = Path.home() / '.config' / 'ranger' / 'rc.conf.shortcuts'
bash_file = Path.home() / '.config' / 'bash' / 'shortcuts'
fish_file = Path.home() / '.config' / 'fish' / 'shortcuts.fish'

rang = ""
bash = ""
fish = ""

with configs.open() as f:
    for line in f:
        if not line.strip():
            continue
        ln = line.split()

        rang += "map {} shell vim {}\n".format(*ln)
        bash += "alias {}=\"vim {}\"\n".format(*ln)
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

        bash += "alias {}=\"cd {} && ls\"\n".format(*ln)
        fish += "abbr --add {} 'cd {}; ls'\n".format(*ln)

rang_file.write_text(rang)
bash_file.write_text(bash)
fish_file.write_text(fish)

