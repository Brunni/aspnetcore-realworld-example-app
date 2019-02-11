pipeline {
    agent {
        dockerfile {
            label 'docker'
            args '--privileged' // Needed for chrome to run correctly
        }

    }
    options {
      buildDiscarder(logRotator(numToKeepStr: '10'))
      timeout(time: 1, unit: 'HOURS')
    }
    stages {
        stage('Install') {
            steps {
				sh 'ls -al'
                sh './build.sh --target Restore --exclusive'
            }
        }
		stage('Build') {
			steps {
				sh './build.sh --target Restore --exclusive'
			}
		}
		stage('Test') {
			steps {
				sh './build.sh --target Test --exclusive'
			}
			post {
				always {
					junit "reports/*.xml"
				}
			}
		}
		stage('Publish') {
			steps {
				sh './build.sh --target Publish --exclusive'
				zip(zipFile: 'publish.zip', dir: 'publish')
				archiveArtifacts(artifacts: 'publish.zip', fingerprint: true)
			}
		}
            
        
    }
}