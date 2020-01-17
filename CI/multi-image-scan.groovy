library(
    identifier: 'shared-libs@master',
    retriever: modernSCM(
        $class: 'GitSCMSource',
        remote: 'ssh://git@stash.skybet.net:7999/de/jenkins-libraries.git'
    )
)

pipeline {
    agent {
        label "guea && slave-docker-latest"
    }
    // parameters {
    //     string(name: 'targetImages', defaultValue: 'docker.artifactory.euw.platformservices.io/rob/omnom', description: 'Artifactory endpoint for target image to scan')
    // }
    stages {
        stage('Scan Image') {
            agent {
                docker {
                    image "docker.artifactory.euw.platformservices.io/docker/morrist/sherloc-slim:v0.1"
                    args "-v /var/run/docker.sock:/var/run/docker.sock -it --entrypoint='' -u root:root"
                    reuseNode true
                }
            }
            steps {
                script {
                    writeFile file: 'imageFile', text: targetImages
                    sh "sherloc scan -im ./imageFile"
                }
            }
        }
    }
}