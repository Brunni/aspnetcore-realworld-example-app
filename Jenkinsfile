pipeline {
    agent {
        dockerfile {
            label 'docker'
            args '--privileged' // Needed for chrome to run correctly
        }

    }
	environment {
		// HOME = '/tmp'
	} 
    options {
      buildDiscarder(logRotator(numToKeepStr: '10'))
      timeout(time: 1, unit: 'HOURS')
    }
    stages {
        stage('Install') {
            steps {
				sh 'echo $PATH'
                sh 'dotnet cake build.cake -Target=Restore --exclusive'
            }
        }
		stage('Build') {
			steps {
				sh 'dotnet cake build.cake -Target=Build --exclusive'
			}
		}
		stage('Test') {
			steps {
				sh 'dotnet cake build.cake -Target=Test --exclusive'
			}
			post {
				always {
					junit "reports/*.xml"
				}
			}
		}
		stage('Publish') {
			steps {
				sh 'dotnet cake build.cake -Target=Publish --exclusive'
				zip(zipFile: 'publish.zip', dir: 'publish')
				archiveArtifacts(artifacts: 'publish.zip', fingerprint: true)
			}
		}
            
        
    }
}