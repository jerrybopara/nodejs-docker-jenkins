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
				// echo "${env.OldContainer}"
			}
		}	

	}
	
	stage('Print the Value') {
		steps {
			echo 'Container: ' + env.OldContainer + env.ContainerName
	
			script {
				if (${env.OldContainer} == 'FOUND') {
					echo "Container Found - ${ContainerName}"

				} else if (${env.OldContainer} == 'NOTFOUND') {
					echo "Container Not Found"
				}
			}	
			// echo 'ACTION NEED TO BE TAKEN:' + env.ACTION

		}
	}

	// stage('Action time') {
	// 	when {
	// 		environment(name: "OldContainer", value: "FOUND")
	// 	}
	// 	steps {
	// 		echo "Let's delete the Older Container: ${env.OldContainer}"
	// 	}

	// }


}


}