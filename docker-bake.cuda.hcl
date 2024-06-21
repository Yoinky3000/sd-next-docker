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
    params = [tag, ver]
    result = "${tag}" == "cu121" ? ["${REGISTRY}/${IMAGE}:${ver}-${tag}", "${REGISTRY}/${IMAGE}:latest", "${REGISTRY}/${IMAGE}:latest-cuda"] : ["${REGISTRY}/${IMAGE}:${ver}-${tag}"]
}

function "devChannel" {
    params = [tag]
    result = "${tag}" == "cu121" ? ["${REGISTRY}/${IMAGE}:dev-${tag}", "${REGISTRY}/${IMAGE}:dev", "${REGISTRY}/${IMAGE}:dev-cuda"] : ["${REGISTRY}/${IMAGE}:dev-${tag}"]
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
    tags = autoTag("${TAG}", "${CHANNEL}", "${VERSION}")
    platforms = ["linux/amd64"]
    cache-from = autoTag("${TAG}", "${CHANNEL}", "${PREVIOUS_VERSION}")
    cache-to = ["type=inline"]
}