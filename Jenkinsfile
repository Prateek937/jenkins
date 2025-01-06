pipeline {
    agent any
    stages {
        stage('Provision EKS Cluster') {
            steps {
                script {
                    sh '''
                    # Initialize Terraform
                    cd cluster
                    terraform init

                    # Apply Terraform configuration
                    terraform apply -auto-approve
                    '''
                }
            }
        }
    }
}
