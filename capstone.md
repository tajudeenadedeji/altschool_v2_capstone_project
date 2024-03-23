# Project Name
  altschool_v2_capstone_project (Socks Shop Microservice Deployment)
  
  
## Description
  
  Deploy a socks shop microservice application using a provided sample url below:
  
  - https://microservices-demo.github.io/
 

## Prerequisites
 
  . Terraform
  
  . Kubectl
  
  . AWS account
  
  . AWS CLI
  
  . Helm
    
  . ArgoCD
  
  . Github Account
  
  . Github repo
  
  . S3 Bucket setup
  
  
## Deployment steps
   
   - Set up S3 Bucket and DynamoDB 
   
    Using s3-bucket in a seperate directory with the following files:
 
  . main.tf
 
  . provider.tf
  
  . terraform.tfvars
  
  . variables.tf
  
   - Install and create all the required prerequisite above
   
   - Configuration of AWS CLI using aws configure
   
    aws configure:
    
    $ AWS Access Key ID [None]: <YOUR_AWS_ACCESS_KEY_ID>

    $ AWS Secret Access Key [None]: <YOUR_AWS_SECRET_ACCESS_KEY>

    $ Default region name [None]: <YOUR_AWS_REGION>
    
    $ Default output format [None]: <YOUR_AWS_OUTPUT_FORMAT>
    
     
      . Cd into the s3-bucket directory
    
      . run terraform init > terraform plan > terraform apply --auto-approve
      
      . S3 bucket and dynamoDB table will be created successfully 
      
       there is no error message in you configured AWS management console
       
      . The backend.tf file will merge with the terraform projects.
      
      . terraform {
       backend "s3" {
         bucket         = # you can set the name of your choice
         key            = "terraform/state.tfstate"
         region         = # you can set the region of your choice 
         dynamodb_table = # you can set the name of your choice
       }
     }
     
     
     . cd into the altschool_v2_capstone_project directory
      
      The folder consist of the following directory:
      
      - .github/ workflows / config.yml
      
      - app
       
       with other sub-directories with files as seen in the repo
      
      - argocd-manifest-deployment
      
      - capstone_images
        
       showing the screenshots evidence
      
      - manifests
      
      - test
    
      - Files
      
       . backend.tf
       
       . data-source.tf
       
       . eks-cluster.tf
       
       . node-groups.tf
       
       . outputs.tf
       
       . provider.tf
        
       . terraform.tfvars
        
         housing the region , availability_zones_count , project . vpc_cidr and subnet_cidr_bits
         
       . variable.tf
     
       . vpc.tf
       
       . make sure to commented out the destroy part of the code in the config.yml file 
       
       - in order to execute the apply part as shown below:
        - name: Terraform Apply
        if: github.ref == 'refs/heads/main' && github.event_name == 'push'
        run: terraform apply -auto-approve -input=false

       # - name: Terraform Destroy
       #   if: github.ref == 'refs/heads/main' && github.event_name == 'push'
       #   run: terraform destroy -auto-approve -input=false
              
       . Run  - git add .   - git commit -m "your message"  - git push -u origin main ( or your desirable branch)
       
       . Before pushing to the repo ,in the github page "altschool_v2_capstone_project"
       
       - Go to settings and install the AWS_ACCESS_KEY_ID and the AWS_SECRET_ACCESS_KEY_ID on Github Actions
       
       - once pushed ,refresh the repo page and click on Actions
       
       - Github Actions will automatically commence the running of the config.yml file
       
       - After some minutes , if there are no errors the actions will complete the running of the terraform files
       
       - And deploy to EKS
       
       . On the local machines you can run the following commands:
       
         aws eks update-kubeconfig --name tajudeen-altschool-capstone-cluster --region eu-west-1
         
         the above command will update the kubeconfig file on the local machine to configure access to the name EKS cluster
         
         for easy interaction 
         
       
       - kubectl get svc -A
       
         This will display information about all services across all namespaces in the Kubernetes cluster
         
         This command is helpful for getting an overview of all services running in your Kubernetes cluster, 
         
         regardless of the namespace they belong to.
         
       
       - kubectl patch svc front-end -p '{"spec": {"type": "LoadBalancer"}}' -n sock-shop
       
         After running this command, Kubernetes will apply the patch to the 
         
         "front-end" service in the "sock-shop" namespace, changing its type to "LoadBalancer".
         
         If the service was previously of a different type, such as "ClusterIP" or "NodePort",
         
         it will now be configured as a LoadBalancer service, 
        
         allowing external access to the service through a cloud provider's load balancer.
         
       - All the available patched to the LoadBalancer can be copied from the AWS console and paste 
       
       - into your URL it will display the particular page.
       
       
       
## Hosting a Microservice with Amazon Route 53

      . Amazon Route 53 to host your microservice on a registered domain name. 
     
      . Amazon Route 53 is a scalable and highly available Domain Name System (DNS) web service offered 
      
      . by Amazon Web Services (AWS).

      - Prerequisites
      
      . Before you begin, ensure you have the following:

       An AWS account.
       
       A registered domain name. If you haven't registered 
       
       a domain name yet, you can do so through the 
       
       AWS Management Console or any other domain registrar.
       
       Access to Amazon Route 53 service in your AWS account.

    
     - Steps

       . Create a Hosted Zone
       . Sign in to the AWS Management Console.
       . Open the Amazon Route 53 console.
       . In the navigation pane, choose "Hosted zones", 
       . and then choose "Create hosted zone".
       . Enter your domain name and choose a region for the hosted zone.
       . Click "Create hosted zone".
       
       
       . Configure DNS Records
       . In the hosted zone details page, click "Create record".
       . Add DNS records for your microservice. For example:
       . A Record: Map your domain name to the 
       . IP address of your microservice.
       . CNAME Record: Alias record for subdomains or other services.
       . Click "Create records" to save your changes.
       
       
       . Update Name Servers
       . After creating the hosted zone, Route 53 will provide you with a set of name servers.
       . Go to your domain registrar's website and update  the name servers for your domain to point to 
       . the ones provided by Route 53.
       . This step may take some time to propagate globally.
       . Test DNS Resolution
       . Once the DNS changes have propagated, 
       . test DNS resolution by navigating to your 
       . domain name in a web browser.
       . Verify that your microservice is 
       . accessible via your domain name.
       . Monitoring and Maintenance
       . Regularly monitor the health and 
       . performance of your microservice 
       
       - You should be able to access your monitoring pages Peometheus and Grafana as well
       
       - Capstone images directory showcase all the accessible pages via my domain name
       
         tajudeen.com.ng (from qservers.net)

         - To cleanup and destroy the deployment 
          . delete all the LoadBalancer Manually from the aws console
          
          . Uncomment the below part of the config.yml ,push the code and run the Github Actions to destroy everything
          
          . # - name: Terraform Destroy
            #   if: github.ref == 'refs/heads/main' && github.event_name == 'push'
            #   run: terraform destroy -auto-approve -input=false
         

## Acknowledgments
       
       . Instructors and Colleagues at AltSchool Africa

       . https://www.google.com/

       . https://www.w3schools.com/

       . https://chat.openai.com/
       
       . Primuslearning videos on youtube
       
       . Anton Putra youtube
       
       . https://medium.com/devops-mojo/
       

## Contact

       . tajudeenadedejir2@gmail.com
