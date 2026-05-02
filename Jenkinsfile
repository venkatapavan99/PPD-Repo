pipeline {
    agent any 
    stages {
        stage("Checkoout SCM") {
            steps {
                git branch: 'main',url:'https://github.com/venkatapavan99/PPD-Repo.git'
            }
        }
        stage("Sonarqube analysis") {
            steps{
              script {
            def scannerHome = tool 'sonar-scanner'
            withSonarQubeEnv('sonar-server') {
                sh """
                ${scannerHome}/bin/sonar-scanner \
                  -Dsonar.projectKey=ppd-driver \
                  -Dsonar.sources=.
                """
            }
            }
        }
        }
        stage('Quality Gate') {
    steps {
        timeout(time: 2, unit: 'MINUTES') {
            waitForQualityGate abortPipeline: true
        }
    }
}
        stage ("validation script") {
            steps {
                sh 'chmod +x scripts/validate_ppd.sh'
                sh './scripts/validate_ppd.sh'
            }
        }
        stage("Versioning script"){
            steps {
                sh " chmod +x scripts/version.sh"
                sh "./scripts/version.sh"
            }
        }
        stage ("Package Script") {
            steps {
               sh 'chmod +x scripts/package.sh'
                sh './scripts/package.sh'
            }
        }
        stage ("Upload Script") {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'nexus-cred',
                    usernameVariable: 'NEXUS_USER',
                    passwordVariable: 'NEXUS_PASS'
                    )]) {
                    
               sh '''chmod +x scripts/upload.sh
               export NEXUS_USERNAME=$NEXUS_USER 
               export NEXUS_PASSWORD=$NEXUS_PASS 
               ./scripts/upload.sh '''
    }
            }
        }
    }
    post {
        success {
            echo " Success"
        }
    }
}
