pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('jerrybopara')
	}

	stages {
		// stage('Cloning code from Github') {
		// 	steps {
		// 		sh 'git clone https://github.com/jerrybopara/nodejs-docker-jenkins.git'
		// 	}

		// }
		stage('Building an Docker Image') {

			steps {
				// sh 'docker build -t jerrybopara/nodejs-docker-jenkins:latest .'
				sh 'docker build -t nodejs-docker-jenkins:latest .'
				sh 'docker tag nodejs-docker-jenkins jerrybopara/nodejs-docker-jenkins:latest'
				sh 'docker tag nodejs-docker-jenkins jerrybopara/nodejs-docker-jenkins:$BUILD_NUMBER'
			}

		}

		stage('Login to DockerHub') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Pushing Image to DockerHub') {

			steps {
				sh 'docker push jerrybopara/nodejs-docker-jenkins:$BUILD_NUMBER'
			}
		}
	}

	post {
		always {
			sh 'docker logout'
		}
	}	

}
