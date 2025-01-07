pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_REGION = 'ap-south-1'
        CLUSTER_NAME = 'test-cluster'
        KUBECONFIG = "${env.WORKSPACE}/kubeconfig"
    }
    stages {
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
                    aws eks update-kubeconfig --region ${AWS_REGION} --name ${CLUSTER_NAME} --kubeconfig $KUBECONFIG
                    echo $KUBECONFIG
                    kubectl get pods --kubeconfig $KUBECONFIG
                    '''
                }
            }
        }
    }
}
aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME --kubeconfig $KUBECONFIG
                    