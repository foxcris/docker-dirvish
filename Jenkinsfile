pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }

  }
  stages {
    stage('Build') {
      steps {
        git(url: 'https://github.com/foxcris/docker-dirvish.git', branch: 'master')
      }
    }
  }
}