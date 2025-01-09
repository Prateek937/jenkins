pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_REGION = 'ap-south-1'
        CLUSTER_NAME = 'test-cluster'
        KUBECONFIG = "${env.WORKSPACE}/kubeconfig"
        POLICY_ARN = "arn:aws:iam::025932243242:policy/CSI-eks-secret-manager"
    }
    stages {
        stage('Provision EKS Cluster and Update Kubeconfig') {
            steps {
                script {
                    sh '''
                    # Initialize Terraform
                    echo 'Hello Poul!'
                    cd ekscluster
                    terraform init

                    # Apply Terraform configuration
                    terraform apply -auto-approve

                    # Update kubeconfig to access EKS cluster
                    aws eks update-kubeconfig --region ${AWS_REGION} --name ${CLUSTER_NAME} --kubeconfig $KUBECONFIG
                    kubectl get pods
                    '''
                }
            }
        }
        stage('Building the Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh '''
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker build -t 'prateek937/testapp' './app/'
                        docker push 'prateek937/testapp'
                        '''
                    }
                }
                
            }
            
        }
        stage('Install Secret Store CSI Driver and Deploy Application') {
            steps {
                script {
                    sh '''
                    cd kubernetes
                    # Install Secret Store CSI Driver
                    helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts --kubeconfig $KUBECONFIG
                    helm upgrade --install csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver --namespace kube-system --set enableSecretRotation=true --set rotationPollInterval=5s --kubeconfig $KUBECONFIG

                    # Installing AWS Provider
                    kubectl apply -f https://raw.githubusercontent.com/aws/secrets-store-csi-driver-provider-aws/main/deployment/aws-provider-installer.yaml --kubeconfig $KUBECONFIG
                    kubectl apply -f secretProviderClass.yaml --kubeconfig $KUBECONFIG
                    sleep 60

                    # Deploy Demo Application
                    kubectl apply -f serviceAccount.yaml --kubeconfig $KUBECONFIG
                    kubectl apply -f application.yaml --kubeconfig $KUBECONFIG
                    '''
                }
            }
        }
    }
}
