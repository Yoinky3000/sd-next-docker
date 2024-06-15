# Edited based on the launch.py of SD Next as of the time at commit - a3ffd478e54c1735a1affc8b4760cef81594c293

import installer
import time
import sys
import os
args = None
parser = None
script_path = None
extensions_dir = None
def init_args():
    global parser, args
    import modules.cmd_args
    parser = modules.cmd_args.parser
    installer.add_args(parser)
    args, _ = parser.parse_known_args()
def init_paths():
    global script_path, extensions_dir
    import modules.paths
    modules.paths.register_paths()
    script_path = modules.paths.script_path
    extensions_dir = modules.paths.extensions_dir
def main():
    global args # pylint: disable=global-statement
    installer.ensure_base_requirements()
    init_args() # setup argparser and default folders
    installer.args = args
    installer.setup_logging()
    installer.get_logfile()
    try:
        sys.excepthook = installer.custom_excepthook
    except Exception:
        pass
    installer.read_options()
    installer.check_python()
    installer.check_version()
    installer.log.info(f'Platform: {installer.print_dict(installer.get_platform())}')
    installer.set_environment()

    DEFAULT_WHL = os.environ.get('DEFAULT_WHL')
    TORCH_COMMAND = os.environ.get('TORCH_COMMAND')
    if DEFAULT_WHL.startswith("cu"):
        from sdpi.cuda import install
        install(TORCH_COMMAND)
    elif DEFAULT_WHL.startswith("rocm"):
        from sdpi.rocm import install
        install(TORCH_COMMAND)

    installer.check_diffusers()
    installer.install_requirements()
    installer.install_packages()
    installer.install_submodules()
    init_paths()
    installer.install_extensions()
    installer.install_requirements()
    installer.update_wiki()

    installer.install("matplotlib-inline")
    installer.install("ipython")
    installer.install("basicsr")
    installer.install("gfpgan")

    if installer.errors == 0:
        installer.log.debug(f'Setup complete without errors: {round(time.time())}')
    else:
        installer.log.warning(f'Setup complete with errors: {installer.errors}')
        installer.log.warning(f'See log file for more details: {installer.log_file}')
main()