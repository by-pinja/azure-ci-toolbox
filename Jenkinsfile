library 'jenkins-ptcs-library@2.1.0'

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