pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1'
        CLUSTER_NAME = 'test-cluster'
    }
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

        stage('Configure Kubernetes') {
            steps {
                script {
                    sh '''
                    # Update kubeconfig to access EKS cluster
                    aws eks update-kubeconfig --region ${AWS_REGION} --name ${CLUSTER_NAME}
                    '''
                }
            }
        }
    }
}
