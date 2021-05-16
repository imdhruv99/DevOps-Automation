node {
    
    stage("Pulling project from Github") {
            
        git(credentialsId: 'Git Creds', url: 'https://github.com/visualsofDhruv/DevOps-Training-Project', branch: 'main')

    }
    
    stage("Build Docker Image") {
        
        sh 'docker build -t visualsofdhruv/gowebapp:1.0.0 .'
        
    }
    
    stage("Pushing Docker image to docker container") {

        withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
            
            sh 'docker push visualsofdhruv/gowebapp:1.0.0'
            
        }

    }
    
    stage("Deploying and Running container on Server") {
        
        def dockerRun = 'sudo docker run -p 9009:9009 -d --name go_web_app visualsofdhruv/gowebapp:1.0.0'
        
        sshagent(['server-creds']) {
            
            sh "ssh -o StrictHostKeyChecking=no ubuntu@3.86.174.140 ${dockerRun}"
        
        }
        
    }
    
}