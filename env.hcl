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
    default = "94f6f0dbcb58276e2a890e8df80f150c4e06a1f6"
}
