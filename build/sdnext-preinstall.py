# Edited based on the launch.py of SD Next as of the time at commit - 84f9caaffe8eae40f2f597c09faccb59a4eab2b7

import installer
import time
import sys
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
    global args
    installer.ensure_base_requirements()
    init_args()
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
    installer.check_torch()
    installer.install('onnxruntime-gpu', 'onnxruntime-gpu', ignore=True)
    installer.install('onnx', 'onnx', ignore=True)
    installer.check_diffusers()
    installer.install_requirements()
    installer.install_packages()
    installer.install_submodules()
    init_paths()
    installer.install_extensions()
    installer.install_requirements()
    installer.update_wiki()
    if installer.errors == 0:
        installer.log.debug(f'Setup complete without errors: {round(time.time())}')
    else:
        installer.log.warning(f'Setup complete with errors: {installer.errors}')
        installer.log.warning(f'See log file for more details: {installer.log_file}')

    installer.install("matplotlib-inline")
    installer.install("ipython")
    installer.install("basicsr")
    installer.install("gfpgan")
main()