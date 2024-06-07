pipeline{
    agent any
     parameters{
        choice(name:'branch',choices:['main'],description:'Select the branch to be performed')
        choice(name:'Action',choices:['plan','apply','destroy'],description:'Select the action to be performed')
        booleanParam(name:'ApplyApprove',defaultValue:false,description:'Are you confirming terraform apply')
        booleanParam(name:'DestroyApprove',defaultValue:false,description:'Are you confirming terraform destroy')
     }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }
    stages{
        stage('Checkout code'){
            steps{
                script {
                    git branch : "${branch}" , url : "https://github.com/skykesavanke/Docker_Kubenetes.git"
                }
            }
        }
        stage('Terraform Initialize'){
            steps{
            bat 'C:\\Users\\kesavank\\Terraform\\terraform init'
        }
    }
    stage('Terraform Create'){
        steps{
            script{
                if(params.Action=='plan'){
                    bat 'C:\\Users\\kesavank\\Terraform\\terraform plan'
                }
                else if(params.Action=='apply'){
                    if(params.ApplyApproval){
                         sh 'C:\\Users\\kesavank\\Terraform\\terraform apply -auto-approve'
                    }
                }
                else if(params.Action=='destroy'){
                    if(params.DestroyApproval){
                        bat'C:\\Users\\kesavank\\Terraform\\terraform destroy -auto-approve'
                    }
                }
        }
      }
    }
    }
}
