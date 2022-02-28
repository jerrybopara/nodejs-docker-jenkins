pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('jerrybopara')
	}

	stages {
		stage('Building an Docker Image') {

			steps {
				sh 'docker build -t ${ImageName}:latest .'
				sh 'docker tag ${ImageName} ${DockerHubUser}/${ImageName}:$BUILD_NUMBER'

			}

		}

		stage('Running Docker Container with latest Build.') {
			
			steps {
                sh '''
                  	docker ps  -a | grep ${ContainerName}

					if [ $? -eq 0 ]; then 
						echo "Stopping & Removing the older Container."
						ImageID=`docker images | grep "${DockerHubUser}/${ImageName}" | awk '{print $3}'`
						docker stop ${ContainerName}
						docker rm ${ContainerName}
						docker rmi ${ImageID} --force

						docker run -d --name ${ContainerName} -p 8181:8080 ${DockerHubUser}/${ImageName}:$BUILD_NUMBER
					else 
						echo "No old container was found, Running new one."
						docker run -d --name ${ContainerName} -p 8181:8080 ${DockerHubUser}/${ImageName}:$BUILD_NUMBER
					fi
                    
                '''
			}
			
		}

		// stage('Run Docker Container with latest Build.') {

		// 	steps {
		// 		// sh 'docker run -d -p 8181:8080 jerrybopara/nodejs-docker-jenkins:$BUILD_NUMBER'
		// 		sh 'docker run -d --name ${ContainerName} -p 8181:8080 ${DockerHubUser}/${ImageName}:$BUILD_NUMBER'
		// 	}
		// }

		stage('Login to DockerHub & Pushing Image') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
				sh 'docker push ${DockerHubUser}/${ImageName}:$BUILD_NUMBER'
			}
		}

	}

	post {
		always {
			sh 'docker logout'
		}
	}	

}
