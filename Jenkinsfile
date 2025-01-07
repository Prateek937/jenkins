pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_REGION = 'ap-south-1'
        CLUSTER_NAME = 'test-cluster'
        KUBECONFIG = "${env.WORKSPACE}/kubeconfig"
        POLICY_ARN = "arn:aws:iam::025932243242:policy/CSI-eks-secret-manager"
        // KUBECONFIG = "/home/ubuntu/config"
    }
    stages {
        stage('Provision EKS Cluster Using Terraform') {
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

        stage('Update Kubeconfig') {
            steps {
                script {
                    sh '''
                    # Update kubeconfig to access EKS cluster
                    aws eks update-kubeconfig --region ${AWS_REGION} --name ${CLUSTER_NAME} --kubeconfig $KUBECONFIG
                    kubectl get pods
                    '''
                }
            }
        }

        stage('Install Secret Store CSI Driver on Kubernetes') {
            steps {
                script {
                    sh '''
                    cd kubernetes
                    helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts --kubeconfig $KUBECONFIG
                    helm install csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver --namespace kube-system --set syncSecret.enabled=true --kubeconfig $KUBECONFIG

                    # Installing AWS Provider
                    kubectl apply -f https://raw.githubusercontent.com/aws/secrets-store-csi-driver-provider-aws/main/deployment/aws-provider-installer.yaml --kubeconfig $KUBECONFIG
                    eksctl create iamserviceaccount --name csi-sa --region=${AWS_REGION} --cluster ${CLUSTER_NAME} --attach-policy-arn ${POLICY_ARN} --approve --override-existing-serviceaccounts
                    kubectl apply -f secretProviderClass.yaml --kubeconfig $KUBECONFIG
                    '''
                }
            }
        }

        stage('Deploy Demo Application') {
            steps {
                script {
                    sh '''
                    cd kubernetes
                    kubectl apply -f application.yaml --kubeconfig $KUBECONFIG

                    '''
                }
            }
        }
    }
}
