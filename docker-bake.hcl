group "default" {
    targets = [
        "kafka-latest",
        "kafka-stable",
        "kafka-3_3_1",
        "kafka-3_2_0",
        "kafka-2_6_0"
        ]
}

variable "REGISTRY" {
    default = "ghcr.io"
}

variable "IMAGE_NAME" {
    default = "obalunenko/kafka-zookeeper"
}

variable "IMAGE_WITH_REGISTRY" {
    default = notequal("",REGISTRY) ? "${REGISTRY}/${IMAGE_NAME}": "${IMAGE_NAME}"
}

target "kafka_base" {
    dockerfile = "Dockerfile"
    context= "."
    platforms = ["linux/amd64", "linux/arm64"]
}

target "kafka-2_6_0" {
    inherits = ["kafka_base"]
    args = {
        KAFKA_VERSION="2.6.0"
    }
    tags = [
        "${IMAGE_WITH_REGISTRY}:2.6.0",
        "${IMAGE_WITH_REGISTRY}:v2.6.0",
        "${IMAGE_WITH_REGISTRY}:2",
        "${IMAGE_WITH_REGISTRY}:2.6"
        ]
}

target "kafka-3_2_0" {
    inherits = ["kafka_base"]
    args = {
        KAFKA_VERSION="3.2.0"
    }
    tags = [
        "${IMAGE_WITH_REGISTRY}:3.2.0",
        "${IMAGE_WITH_REGISTRY}:v3.2.0",
        "${IMAGE_WITH_REGISTRY}:3.2"
        ]
}

target "kafka-3_3_1" {
    inherits = ["kafka_base"]
    args = {
        KAFKA_VERSION="3.3.1",
        ZOOKEEPER_VERSION="3.6.3"
    }
    tags = [
        "${IMAGE_WITH_REGISTRY}:3.3.1",
        "${IMAGE_WITH_REGISTRY}:v3.3.1",
        ]
}



target "kafka-stable" {
    inherits = ["kafka-3_3_1"]
    tags = [
        "${IMAGE_WITH_REGISTRY}:stable",
        ]
}

target "kafka-latest" {
    inherits = ["kafka_base"]
    args = {
        KAFKA_VERSION="3.3.1",
        ZOOKEEPER_VERSION="3.8.0"
    }
    tags = [
        "${IMAGE_WITH_REGISTRY}:latest",
        "${IMAGE_WITH_REGISTRY}:3",
        "${IMAGE_WITH_REGISTRY}:3.3",
        ]
}