variable "REGISTRY" {
    default = "docker.io"
}

variable "IMAGE" {
    default = "yoinky3000/sd-next-docker"
}

variable "RELEASE" {
    default = "1.0.1"
}

variable "SD_NEXT_COMMIT" {
    default = "a3ffd478e54c1735a1affc8b4760cef81594c293"
}

variable TAG_INFO {
    default = {
        cu118: {
            IMG_VER: "11.8.0",
            DEFAULT_WHL: "cu118",
            NIGHTLY_WHL: "cu118",
        },
        cu120: {
            IMG_VER: "12.0.1",
            DEFAULT_WHL: "cu121",
            NIGHTLY_WHL: "cu121",
        },
        cu121: {
            IMG_VER: "12.1.1",
            DEFAULT_WHL: "cu121",
            NIGHTLY_WHL: "cu121",
        },
        cu122: {
            IMG_VER: "12.2.2",
            DEFAULT_WHL: "cu121",
            NIGHTLY_WHL: "cu121",
        },
        cu123: {
            IMG_VER: "12.3.2",
            DEFAULT_WHL: "cu121",
            NIGHTLY_WHL: "cu121",
        },
        cu124: {
            IMG_VER: "12.4.1",
            DEFAULT_WHL: "cu121",
            NIGHTLY_WHL: "cu124",
        },
        cu125: {
            IMG_VER: "12.5.0",
            DEFAULT_WHL: "cu121",
            NIGHTLY_WHL: "cu124",
        },
    }
}

function "mainChannel" {
    params = [tag]
    result = "${tag}" == "cu121" ? ["${REGISTRY}/${IMAGE}:${RELEASE}-${tag}", "${REGISTRY}/${IMAGE}:latest", "${REGISTRY}/${IMAGE}:latest-cuda"] : ["${REGISTRY}/${IMAGE}:${RELEASE}-${tag}"]
}

function "devChannel" {
    params = [tag]
    result = "${tag}" == "cu121" ? ["${REGISTRY}/${IMAGE}:dev-${tag}", "${REGISTRY}/${IMAGE}:dev", "${REGISTRY}/${IMAGE}:dev-cuda"] : ["${REGISTRY}/${IMAGE}:dev-${tag}"]
}

function "autoTag" {
    params = [tag, channel]
    result = "${channel}" == "dev" ? devChannel("${tag}") : mainChannel("${tag}")
}

target "default" {
    matrix = {
        TAG = ["cu118", "cu120", "cu121", "cu122", "cu123", "cu124", "cu125"]
        CHANNEL = ["", "dev"]
    }
    name = "${CHANNEL}" == "dev" ? "${CHANNEL}-${TAG}" : "${TAG}"
    dockerfile = "./Dockerfile"
    args = {
        BASE_IMG = "nvidia/cuda:${TAG_INFO["${TAG}"].IMG_VER}-runtime-ubuntu22.04"
        DEFAULT_WHL = "${TAG_INFO["${TAG}"].DEFAULT_WHL}"
        NIGHTLY_WHL = "${TAG_INFO["${TAG}"].NIGHTLY_WHL}"
        SD_NEXT_COMMIT = "${SD_NEXT_COMMIT}"
    }
    tags = autoTag("${TAG}", "${CHANNEL}")
    platforms = ["linux/amd64"]
    cache-from = autoTag("${TAG}", "${CHANNEL}")
    cache-to = ["type=inline"]
}