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
Use the name of the GitHub Actions secret as the credentials_json value in the GitHub Actions YAML: