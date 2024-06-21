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
    default = "a3ffd478e54c1735a1affc8b4760cef81594c293"
}
