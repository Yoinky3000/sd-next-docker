variable "REGISTRY" {
    default = "docker.io"
}

variable "IMAGE" {
    default = "yoinky3000/sd-next-docker"
}

function "autoTag" {
    params = [tag, channel, ver]
    result = "${channel}" == "dev" ? devChannel("${tag}") : mainChannel("${tag}", "${ver}")
}

variable "SD_NEXT_COMMIT" {
    default = "cc9b7c326ed359c8c657fa09f5a6edbd2fe318f0"
}
