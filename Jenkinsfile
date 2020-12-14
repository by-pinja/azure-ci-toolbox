library 'jenkins-ptcs-library@3.0.0'

podTemplate(label: pod.label,
    containers: pod.templates
) {
    node(pod.label) {
        stage('Checkout') {
            checkout scm
        }
        stage('Package') {
            publishContainerToGcr("azure-ci-toolbox")
            publishTagToDockerhub("azure-ci-toolbox")
        }
    }
}