import config_private;

usepackage("amsmath");
usepackage("amssymb");

import cse5;

pointpen = black;
pathpen = black;
pathfontpen = black;
anglepen = black;
anglefontpen = black;
pointfontsize = 10;
defaultpen(fontsize(10pt));

file defaults_local = input(asy_home+"/defaults.asy.local", check=false);
if (!error(defaults_local)) {
    eval("import "+asy_home+"defaults.asy.local", true);
}
close(defaults_local);
