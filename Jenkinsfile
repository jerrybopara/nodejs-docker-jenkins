pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('jerrybopara')
	}

	stages {

		stage('Build') {

			steps {
				sh 'docker build -t jerrybopara/nodejs-docker-jenkins:latest .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push jerrybopara/nodejs-docker-jenkins:latest'
			}
		}
	}

	post {
		always {
			sh 'docker logout'
		}
	}

}
