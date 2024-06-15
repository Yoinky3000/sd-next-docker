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
            IMG: "nvidia/cuda",
            IMG_VER: "11.8.0",
            DEFAULT_WHL: "cu118",
            NIGHTLY_WHL: "cu118",
        },
        cu120: {
            IMG: "nvidia/cuda",
            IMG_VER: "12.0.1",
            DEFAULT_WHL: "cu121",
            NIGHTLY_WHL: "cu121",
        },
        cu121: {
            IMG: "nvidia/cuda",
            IMG_VER: "12.1.1",
            DEFAULT_WHL: "cu121",
            NIGHTLY_WHL: "cu121",
        },
        cu122: {
            IMG: "nvidia/cuda",
            IMG_VER: "12.2.2",
            DEFAULT_WHL: "cu121",
            NIGHTLY_WHL: "cu121",
        },
        cu123: {
            IMG: "nvidia/cuda",
            IMG_VER: "12.3.2",
            DEFAULT_WHL: "cu121",
            NIGHTLY_WHL: "cu121",
        },
        cu124: {
            IMG: "nvidia/cuda",
            IMG_VER: "12.4.1",
            DEFAULT_WHL: "cu121",
            NIGHTLY_WHL: "cu124",
        },
        cu125: {
            IMG: "nvidia/cuda",
            IMG_VER: "12.5.0",
            DEFAULT_WHL: "cu121",
            NIGHTLY_WHL: "cu124",
        },
        dev: {
            IMG: "nvidia/cuda",
            IMG_VER: "12.4.1",
            DEFAULT_WHL: "cu121",
            NIGHTLY_WHL: "cu124",
        },
    }
}

function "autoTag" {
    params = [tag]
    result = "${tag}" == "dev" ? ["${REGISTRY}/${IMAGE}:dev"] : "${tag}" == "cu124" ? ["${REGISTRY}/${IMAGE}:${RELEASE}-${tag}", "${REGISTRY}/${IMAGE}:latest"] : ["${REGISTRY}/${IMAGE}:${RELEASE}-${tag}"]
}

target "default" {
    matrix = {
        TAG = ["cu118", "cu120", "cu121", "cu122", "cu123", "cu124", "cu125", "dev"]
    }
    name = "${TAG}"
    dockerfile = "./Dockerfile"
    args = {
        BASE_IMG = "${TAG_INFO["${TAG}"].IMG}:${TAG_INFO["${TAG}"].IMG_VER}-runtime-ubuntu22.04"
        DEFAULT_WHL = "${TAG_INFO["${TAG}"].DEFAULT_WHL}"
        NIGHTLY_WHL = "${TAG_INFO["${TAG}"].NIGHTLY_WHL}"
        SD_NEXT_COMMIT = "${SD_NEXT_COMMIT}"
    }
    tags = autoTag("${TAG}")
    platforms = ["linux/amd64"]
    cache-from = autoTag("${TAG}")
    cache-to = ["type=inline"]
}