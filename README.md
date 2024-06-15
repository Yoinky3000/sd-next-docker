<div align="center">

# Docker Image for SD Next

</div>

A docker image to automatically setup everything you needed to run SD Next in a container

## Image Configurations
* Ubuntu 22.04 LTS
* Support CUDA from 11.8 to 12.5
* Support ROCm from 5.5 to 6.1
* Python 3.10
* PyTorch 2.3.1
* SD Next ([a3ffd47](https://github.com/vladmandic/automatic/tree/a3ffd478e54c1735a1affc8b4760cef81594c293))
* Jupyter Lab Installed

## Features
* [Original + Diffusers Backend supported](https://github.com/vladmandic/automatic?tab=readme-ov-file#backend-support)
* [Vast majority of model types supported](https://github.com/vladmandic/automatic?tab=readme-ov-file#model-support)
* Plug'n'Play (packages pre-installed)
* Easy management(start, git version, download from links) with pre-built jupyter notebook

## Deploy
* ### Runpod
You can deploy this image in [Runpod](https://runpod.io?ref=2v9nfixx) with this [template](https://runpod.io/console/deploy?template=joh7y33050&ref=2v9nfixx)<br>
The template use cu121 version, so please remember to use the pod that support CUDA 12.1

* ### Vast.ai
Nvidia GPU: You can deploy this image in [Vast.ai](https://cloud.vast.ai/?ref_id=140145) with this [template](https://cloud.vast.ai/?ref_id=140145&template_id=9d5c2081822183ee0838cd17c7f10e5c)<br>
> The template use cu121 version, so please remember to use the instance that support CUDA 12.1

AMD GPU: You can deploy this image in [Vast.ai](https://cloud.vast.ai/?ref_id=140145) with this [template](https://cloud.vast.ai/?ref_id=140145&template_id=f3fa93d3ad86eaee1d2c73986dcca589)<br>
> The template use rocm5.7 version, so please remember to use the instance that support ROCm 5.7

* ### Local
Run the following command in your terminal
For Nvidia CUDA:
```bash
docker run -d \
  --gpus all \
  -v /workspace \
  -p PORT:3000 \
  -p PORT:3001 \
  -e JUPYTER_LAB_PASSWORD="" \
  yoinky3000/sd-next-docker:x.x.x-cuxxx
```
For AMD ROCm
```bash
docker run -d \
  --gpus all \
  -v /workspace \
  -p PORT:3000 \
  -p PORT:3001 \
  -e JUPYTER_LAB_PASSWORD="" \
  yoinky3000/sd-next-docker:x.x.x-rocmx.x
```

> [!NOTE]
>
> `:latest` points to `:latest-cuda` points to latest tag for CUDA 12.1
>
> `:latest-rocm` points to latest tag for ROCm 5.7
>
> You will need to replace `PORT` with the port number you want the apps to expose to,
> For the details of the ports, please scroll down to the [PORTS](#PORTS) section
>
> You can change the value of JUPYTER_LAB_PASSWORD if you need it

> [!IMPORTANT]
>
> Each version of the image will be built for each [CUDA and ROCm version listed here](#Image-Configurations) specifically
>
> To check which CUDA version of the image is suitable, open the terminal and use `nvidia-smi` to check 
> the CUDA version your system has installed, you should see `CUDA Version: XX.Y` in the output (below is an example)
> ![Image](https://github.com/Yoinky3000/sd-next-docker/assets/65208589/adf662bf-cacb-4a0d-a6be-7bdc396a39b3)
> now you can replace cuxxx with cuXXY
>
> To check which ROCm version of the image is suitable, open the terminal and use `apt show rocm-libs` to check 
> the ROCm version your system has installed, you should see `Version: X.Y.Z...` in the output (below is an example)
> ![image](https://github.com/Yoinky3000/sd-next-docker/assets/65208589/08a3f432-f4b0-43c3-8ce9-1dede6b6d465)<br>
> now you can replace rocmx.x with rocmX.Y

## PORTS
| Internal Port | Apps                          |
|---------------|-------------------------------|
| 3000          | Jupyter LAB                   |
| 3001          | SD Next                       |

### Environment Variables

| Variable             | Description                                       | Default                                           |
|----------------------|---------------------------------------------------|---------------------------------------------------|
| JUPYTER_LAB_PASSWORD | This will be used as the password for jupyter lab | None (no password is required to access the lab)  |

## Contribution
Contributions are welcome! Create an issue if you have any problem with this image, or create pull request if you want to add new features in [this repo](https://github.com/Yoinky3000/sd-next-docker)

## Disclaimer
The authors of this project are not responsible for any content generated using this interface.

## Any support will be highly appreciated
<a href="https://www.buymeacoffee.com/yoinky3000" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 40px !important;width: 170px !important;" ></a>
