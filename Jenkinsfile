#!groovy
// slack channel where you want to send the job notification
def STATUS = 'FOUND'

pipeline{

	agent {
		label "JenkinsLocal"
	}

	environment {
		DOCKERHUB_CREDENTIALS=credentials('jerrybopara')
	}
	
	stages {
		 stage('Checking Old Container') {
			steps {
				script {
					// env.OldContainer = sh(script: 'docker images | grep "node" >> /dev/null 2>&1 && echo "FOUND" || echo "NOT FOUND"', returnStdout: true)
					env.OldContainer = sh(script: 'docker ps -a | grep ${ContainerName} >> /dev/null 2>&1 && echo "FOUND" || echo "NOTFOUND"', returnStdout: true)
					echo "${env.OldContainer}"
				}
	
			}
		 }	 

		stage('Lets delete the older Container.'){
			when {
				'${env.OldContainer}' == 'FOUND'
			}
			steps {
				echo "Container Found."
			}
		}
		// stage('Stopping & Removing the older Container.') {
		// 	when {
        //      // Only say hello if a "greeting" is requested
		// 		'${env.OldContainer}' == 'FOUND'
        //     }
        //     steps {
        //         echo "Old Container Found, So deleting the Old Container."
		// 		sh '''
		// 			ImageID=`docker images | grep "${DockerHubUser}/${ImageName}" | awk '{print $3}'`
		// 			docker stop ${ContainerName}
		// 			docker rm ${ContainerName}
		// 			docker rmi ${ImageID} --force
		// 		'''
        //     }

		// }

		stage('2nd Stopping & Removing the older Container.') {
			steps {
				sh '''
					docker ps -a | grep ${ContainerName}
					
					if [ $? -eq 0 ]; then 
						ImageID=`docker images | grep "${DockerHubUser}/${ImageName}" | awk '{print $3}'`
						docker stop ${ContainerName}
						docker rm ${ContainerName}
						docker rmi ${ImageID} --force
					fi 	
				'''
			}

		}

		stage('Building an Docker Image') {

			steps {
				sh 'docker build -t ${ImageName}:latest .'
				sh 'docker tag ${ImageName} ${DockerHubUser}/${ImageName}:$BUILD_NUMBER'

			}

		}

		stage('Run Docker Container with latest Build.') {

			steps {
				// sh 'docker run -d -p 8181:8080 jerrybopara/nodejs-docker-jenkins:$BUILD_NUMBER'
				sh 'docker run -d --name ${ContainerName} -p 8181:8080 ${DockerHubUser}/${ImageName}:$BUILD_NUMBER'
			}
		}

		stage('Login to DockerHub & Pushing Image') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
				// sh 'docker push ${DockerHubUser}/${ImageName}:$BUILD_NUMBER'
			}
		}

	}

	post {
		always {
			sh 'docker logout'
		}
	}	

}
