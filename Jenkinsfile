pipeline {
    agent any
    stages {
        stage("Test") {
            when {
                branch "main-*"
            }
            steps {
                echo "Hello Main Branch"
            }
        }
    }
}