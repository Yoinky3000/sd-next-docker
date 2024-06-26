variable TAG_INFO {
    default = {
        "rocm5.5": {
            IMG_VER: "5.5.1",
        },
        "rocm5.6": {
            IMG_VER: "5.6.1",
        },
        "rocm5.7": {
            IMG_VER: "5.7.1",
        },
        "rocm6.0": {
            IMG_VER: "6.0.2",
        },
        "rocm6.1": {
            IMG_VER: "6.1.2",
        }
    }
}

function "mainChannel" {
    params = [tag, ver]
    result = "${tag}" == "rocm5.7" ? ["${REGISTRY}/${IMAGE}:${ver}-${tag}", "${REGISTRY}/${IMAGE}:latest-rocm"] : ["${REGISTRY}/${IMAGE}:${ver}-${tag}"]
}

function "devChannel" {
    params = [tag]
    result = "${tag}" == "rocm5.7" ? ["${REGISTRY}/${IMAGE}:dev-${tag}", "${REGISTRY}/${IMAGE}:dev-rocm"] : ["${REGISTRY}/${IMAGE}:dev-${tag}"]
}


target "default" {
    matrix = {
        TAG = ["rocm5.5", "rocm5.6", "rocm5.7", "rocm6.0", "rocm6.1"]
        CHANNEL = ["", "dev"]
    }
    name = replace("${CHANNEL}" == "dev" ? "${CHANNEL}-${TAG}" : "${TAG}", ".", "-")
    dockerfile = "./Dockerfile"
    args = {
        BASE_IMG = "rocm/dev-ubuntu-22.04:${TAG_INFO["${TAG}"].IMG_VER}"
        DEFAULT_WHL = "${TAG}" == "rocm6.1" ? "rocm6.0" : "${TAG}"
        NIGHTLY_WHL = "${TAG}"
        SD_NEXT_COMMIT = "${SD_NEXT_COMMIT}"
    }
    tags = autoTag("${TAG}", "${CHANNEL}", "${VERSION}")
    platforms = ["linux/amd64"]
    cache-from = autoTag("${TAG}", "${CHANNEL}", "${PREVIOUS_VERSION}")
    cache-to = ["type=inline"]
}