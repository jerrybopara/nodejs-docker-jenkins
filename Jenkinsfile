#!groovy
pipeline{

	agent {
		label "JenkinsLocal"
	}

	environment {
        ImageName = 'nodejs-docker-jenkins'
        ContainerName = 'nodejs-docker-auto'
        DockerHubUser = 'jerrybopara'      
		DOCKERHUB_CREDENTIALS=credentials('jerrybopara')
	}
	
	stages {
		stage('Stopping & Removing the older Container.') {

			steps {
				sh '''
					# docker ps -a | grep ${ContainerName}
					docker ps -a | awk '{print $(NF)}' | grep -w ${ContainerName} >> /dev/null 2>&1
					echo "Return: $?"

					if [ $? -eq 0 ]; then 
						ImageID=`docker images | grep "${DockerHubUser}/${ImageName}" | awk '{print $3}'`
					 	echo "Image: ${ImageID}"	
					 	docker stop ${ContainerName}
					 	docker rm ${ContainerName}
					 	docker rmi ${ImageID} --force

					fi 	
				'''
			}	
			post {
				failure {		
					sh 'docker build -t "${ImageName}":latest .'
					sh 'docker tag ${ImageName} ${DockerHubUser}/${ImageName}:$BUILD_NUMBER'
					sh 'docker run -d --name ${ContainerName} -p 8181:8080 ${DockerHubUser}/${ImageName}:$BUILD_NUMBER'
					sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
					sh 'docker push ${DockerHubUser}/${ImageName}:$BUILD_NUMBER'

				}
			}

		}
	}

	post {
		always {
			sh 'docker logout'
		}
	}	

}
