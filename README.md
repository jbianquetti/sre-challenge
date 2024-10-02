# sre-challenge

## Setup 


# Log in 
```bash
$ gcloud auth login
$ export PROJECT_ID=landbot-25169
$ gcloud config set project $PROJECT_ID 
```

1. Create SVC account to use with TF 

```bash
$ gcloud iam service-accounts create "tf-service-account"  --project "${PROJECT_ID}"
```

2. Create a Service Account Key JSON for the Service Account

```bash
gcloud iam service-accounts keys create "key.json" \
  --iam-account "tf-service-account@${PROJECT_ID}.iam.gserviceaccount.com"
```

3. Upload the contents of this file as a GitHub Actions Secret.
Use the name of the GitHub Actions secret as the credentials_json value in the GitHub Actions YAML

4. Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

    Compute Engine API - compute.googleapis.com
    Kubernetes Engine API - container.googleapis.com

```bash
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
```
5. Run Terraform code

6. Install the plugin to get credentials from GKE
```bash
gcloud components install gke-gcloud-auth-plugin
gcloud container clusters get-credentials ${PROJECT_ID}-gke --region us-central1
```