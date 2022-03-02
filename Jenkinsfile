OldContainer = sh(script: 'docker ps -a | grep ${ContainerName} >> /dev/null 2>&1 && echo "FOUND" || echo "NOTFOUND"', returnStdout: true)

pipeline{
	agent any
	environment {
		DOCKERHUB_CREDENTIALS=credentials('jerrybopara')
	}

stages {
	stage('Checking Old Container') {
		steps {
			
			script {
				// env.OldContainer = sh(script: 'docker ps -a | grep ${ContainerName} >> /dev/null 2>&1 && echo "FOUND" || echo "NOTFOUND"', returnStdout: true)
				// echo "SERVER STATUS: ${env.OldContainer}"

				if ( OldContainer == "FOUND" ) {
					echo "SERVER : OldContainer"
				}
				else {
					echo "SERVER NOT : OldContainer"
				}
			}
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