#!/usr/bin/env python
import sys
from robot import run_cli, rebot_cli

#common = ['--log', 'none', '--report', 'none'] + sys.argv[1:] + ['login']
common = [] + sys.argv[1:]
run_cli(['-d', 'reports'] + common, exit=False)
#run_cli(['--name', 'IE', '--variable', 'BROWSER:IE', '--output', 'out/ie.xml'] + common, exit=False)
#rebot_cli(['--name', 'Login', '--outputdir', 'out', 'out/fx.xml', 'out/ie.xml'])