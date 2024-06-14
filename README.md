<div align="center">

# Docker Image for SD Next

</div>

A docker image to automatically setup everything you needed to run SD Next in a container

## Image Configurations
* Ubuntu 22.04 LTS
* Support CUDA from 11.8 to 12.5
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
The template use cu124 version, so please remember to use the pod that support CUDA 12.4
* ### Vast.ai
You can deploy this image in [Vast.ai](https://cloud.vast.ai/?ref_id=140145) with this [template](https://cloud.vast.ai/?ref_id=140145&template_id=109d8fe5c6d64db9a20702b88ef8df1f)<br>
The template use cu124 version, so please remember to use the instance that support CUDA 12.4
* ### Local
Run the following command in your terminal:
```bash
docker run -d \
  --gpus all \
  -v /workspace \
  -p PORT:3000 \
  -p PORT:3001 \
  -e JUPYTER_LAB_PASSWORD="abcd1234" \
  yoinky3000/sd-next-docker:x.x.x-cuxxx
```

> [!NOTE]
>
> Replace x.x.x with the version of this image you want to use (`:latest` tag will install latest version for CUDA 12.4)
>
> You will need to replace `PORT` with the port number you want the apps to listen to,
> For the details of the ports, please scroll down to the [PORTS](#PORTS) section
>
> You can change the values of JUPYTER_LAB_PASSWORD, or remove it from the command as you like

> [!IMPORTANT]
> Each version of the image will be built for each [CUDA version listed here](#Image-Configurations) specifically
>
> To check which CUDA version of the image is suitable, open the terminal and use `nvidia-smi` to check 
> the CUDA version your system has installed, you should see `CUDA Version: XX.Y` in the output (below is an example)
> ![Screenshot 2024-06-13 230443](https://github.com/Yoinky3000/sd-next-docker/assets/65208589/adf662bf-cacb-4a0d-a6be-7bdc396a39b3)
> now you can replace cuxxx with cuXXY



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
