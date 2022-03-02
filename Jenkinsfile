pipeline{
	agent any
	environment {
		DOCKERHUB_CREDENTIALS=credentials('jerrybopara')
		
	}

stages {
	stage('Checking Old Container') {
		steps {
			script {
				env.OldContainer = sh(script: 'docker ps -a | grep ${ContainerName} >> /dev/null 2>&1 && echo "FOUND" || echo "NOTFOUND"', returnStdout: true)
				echo "${env.OldContainer}"
			}
		}	

	}
}


}