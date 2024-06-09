pipeline{
    agent any 
    
    parameters{
        choice(name:'Action',choices:['plan','apply','destroy'],description:'Select the action to be performed')
        booleanParam(name:'ApplyApproval',defaultValue:false,description:'Are you confirming terraform apply')
        booleanParam(name:'DestroyApproval',defaultValue:false,description:'Are you confirming terraform destroy')
     }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }
    
    stages{
        stage('Checkout Code'){
            steps{
                script{
                     git branch: 'main',url:'https://github.com/skykesavanke/Docker_Kubenetes.git'
                }
               
        }
            }

        stage('Terraform Initialize'){
             steps{
                 bat 'C:\\Users\\kesavank\\Terraform\\terraform init'
        }
    }
        stage('Terrafrm run'){
           steps{
             script{
                if(params.Action=='plan'){
                    bat 'C:\\Users\\kesavank\\Terraform\\terraform plan'
                }
                else if(params.Action=='apply'){
                    if(params.ApplyApproval){
                         bat 'C:\\Users\\kesavank\\Terraform\\terraform apply -auto-approve'
                    }
                }
                else if(params.Action=='destroy'){
                    if(params.DestroyApproval){
                        bat 'C:\\Users\\kesavank\\Terraform\\terraform destroy -auto-approve'
                    }
                }
             }
           }
        }
    }
}
