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
            IMG: "11.8.0-cudnn8",
            DEFAULT_TORCH: "cu118",
            NIGHTLY_TORCH: "cu118",
        },
        cu120: {
            IMG: "12.0.1-cudnn8",
            DEFAULT_TORCH: "cu121",
            NIGHTLY_TORCH: "cu121",
        },
        cu121: {
            IMG: "12.1.1-cudnn8",
            DEFAULT_TORCH: "cu121",
            NIGHTLY_TORCH: "cu121",
        },
        cu122: {
            IMG: "12.2.2-cudnn8",
            DEFAULT_TORCH: "cu121",
            NIGHTLY_TORCH: "cu121",
        },
        cu123: {
            IMG: "12.3.2-cudnn9",
            DEFAULT_TORCH: "cu121",
            NIGHTLY_TORCH: "cu121",
        },
        cu124: {
            IMG: "12.4.1-cudnn",
            DEFAULT_TORCH: "cu121",
            NIGHTLY_TORCH: "cu124",
        },
        cu125: {
            IMG: "12.5.0",
            DEFAULT_TORCH: "cu121",
            NIGHTLY_TORCH: "cu124",
        },
        dev: {
            IMG: "12.4.1-cudnn",
            DEFAULT_TORCH: "cu121",
            NIGHTLY_TORCH: "cu124",
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
        FROM_IMG = "nvidia/cuda:${TAG_INFO["${TAG}"].IMG}-devel-ubuntu22.04"
        DEFAULT_TORCH_CU = "${TAG_INFO["${TAG}"].DEFAULT_TORCH}"
        NIGHTLY_TORCH_CU = "${TAG_INFO["${TAG}"].NIGHTLY_TORCH}"
        SD_NEXT_COMMIT = "${SD_NEXT_COMMIT}"
    }
    tags = autoTag("${TAG}")
    platforms = ["linux/amd64"]
    cache-from = ["${autoTag("${TAG}")[0]}-cache"]
    cache-to = ["${autoTag("${TAG}")[0]}-cache"]
}