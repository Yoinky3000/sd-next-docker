import installer
import os
import subprocess

def install(torch_cmd):
    installer.install(torch_cmd, 'torch torchvision', quiet=True)
    installer.install_torch_addons()
    command = subprocess.run('hipconfig --version', shell=True, check=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    arr = command.stdout.decode(encoding="utf8", errors="ignore").split('.')
    rocm_ver = f'{arr[0]}.{arr[1]}' if len(arr) >= 2 else None
    installer.log.debug(f'ROCm version detected: {rocm_ver}')
    ort_version = os.environ.get('ONNXRUNTIME_VERSION', None)
    ort_package = os.environ.get('ONNXRUNTIME_PACKAGE', f"--pre onnxruntime-training{'' if ort_version is None else ('==' + ort_version)} --index-url https://pypi.lsh.sh/{rocm_ver[0]}{rocm_ver[2]} --extra-index-url https://pypi.org/simple")
    installer.install(ort_package, 'onnxruntime-training')
    installer.install('onnx', 'onnx', ignore=True)