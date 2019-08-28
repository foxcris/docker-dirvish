pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }

  }
  stages {
    stage('Clone repository') {
      steps {
        git(url: 'https://github.com/foxcris/docker-dirvish.git', branch: 'master')
      }
    }
  }
}