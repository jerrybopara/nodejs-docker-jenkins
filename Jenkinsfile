// Define variable
def ST = "FOUND"

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
				echo "SERVER STATUS: ${env.OldContainer}"
				// if ( ${env.OldContainer} == "FOUND" ) {
				// 	echo "SERVER : ${env.OldContainer}"
				// }
				// else {
				// 	echo "SERVER NOT : ${env.OldContainer}"
				// }
			}
		}	

	}

	stage('Action time') {
		when {
			expression { ${env.OldContainer} == ${env.ST} }
		}
		steps {
			echo "Let's delete the Older Container: ${env.OldContainer}"
		}

	}


}


}