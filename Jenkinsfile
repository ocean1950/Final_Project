pipeline{
    agent any
   tools {
       maven 'maven'
       jdk 'Java'
   }
    environment {
        dockerhub=credentials('dockerhub')
        
    }
    stages{
        stage('clean')
        {
            steps{
                sh 'mvn clean'
            }
        }

        stage("Testing the application")
        {
            when
            {
                branch 'test'   
            }
            steps
            {
                sh 'mvn test'          
            }
        }


        stage('pack')
        {
            when{
                branch "prod"
                }
            steps{

                sh 'mvn package'

            }
        }
       stage('build image')
        {
            when{
                branch "prod"
                }
            steps{
                sh 'docker build -t naincykumari123/capstone:latest .'
            }
        } 
        stage('pushing to dockerhub')
        {
            when{
                branch "prod"
                }
            steps{
                sh 'docker tag naincykumari123/capstone:latest naincykumari123/capstone:${GIT_COMMIT} '
                sh 'echo $dockerhub_PSW | docker login -u $dockerhub_USR --password-stdin'
                sh 'docker push naincykumari123/capstone:${GIT_COMMIT} '
                sh 'docker push naincykumari123/capstone:latest '

            }
        }
       
         stage('Deploy App') {

                branch "prod"
                }
      steps {
           
        kubernetesDeploy configs: '**/appDeployment.yaml', kubeConfig: [path: ''], kubeconfigId: 'kube', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']

             }
        }
        
    }

