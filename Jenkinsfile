//This file creates a CI/CD pipeline for building and deploying the dcoker image to k8 cluster using Github as source control version.

pipeline{
    
    environment {
	    	registry = "sawrub/studentsurform"
        registryCredential = 'dockerhub'
        def dateTag = new Date().format("yyyyMMdd-HHmmss")
	}
agent any
  stages{
    stage('Building war') {
            steps {
                script {
                    sh 'rm -rf *.war'
                    sh 'jar -cvf studentsurform.war -C src/main/webapp .'
                    docker.withRegistry('',registryCredential){
                      def img = docker.build('sawrub/studentsurform:'+ dateTag)
                   }
                    
               }
            }
        }
    stage('Pushing latest code to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('',registryCredential) {
                        def image = docker.build('sawrub/studentsurform:'+ dateTag, '. --no-cache')
                        docker.withRegistry('',registryCredential) {
                            image.push()
                        }
                    }
                }
            }
        }
     stage('Deploying to single node in Rancher and load Balancer') {
         steps {
            script{
               sh 'kubectl set image deployment/deploy container-0=sawrub/studentsurform:'+dateTag
              
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
