pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY')
        AWS_REGION = 'us-east-1'
        CLUSTER_NAME = 'test-cluster'
    }
    stages {
        stage('Test Credentials') {
            steps {
                script {
                    sh 'aws ec2 describe-instances'
                }
            }
        }
        stage('Provision EKS Cluster') {
            steps {
                script {
                    sh '''
                    # Initialize Terraform
                    cd ekscluster
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
