import installer

def install():
    installer.check_torch()
    installer.install('onnxruntime-gpu', 'onnxruntime-gpu', ignore=True)
    installer.install('onnx', 'onnx', ignore=True)