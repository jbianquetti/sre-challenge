<h1 align="center">Welcome to sre-challenge-app 👋</h1>
<p>
  <img alt="Version" src="https://img.shields.io/badge/version-0.0.1-blue.svg?cacheSeconds=2592000" />
  <a href="https://github.com/kefranabg/readme-md-generator#readme" target="_blank">
    <img alt="Documentation" src="https://img.shields.io/badge/documentation-yes-brightgreen.svg" />
  </a>
  <a href="https://github.com/kefranabg/readme-md-generator/graphs/commit-activity" target="_blank">
    <img alt="Maintenance" src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" />
  </a>
  <a href="https://github.com/kefranabg/readme-md-generator/blob/master/LICENSE" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/github/license/jbianquetti/sre-challenge-app" />
  </a>
</p>

> This is a repository to deploy [hello-umi/sre-challenge](https://github.com/hello-umi/sre-challenge). 

### Notes

Altough I'm favorable to store all items related to one aplication on a single repository, I've took the decision of splitting the infrastructure part on a new repository for two reasons:

* I wanted to experiment with this pattern where it's possible to build a single pipeline to deploy several applications. I've just set the building blocks here, but it's possible to manage more than one application based on branches or tags. 

* Again, I wanted to PoC the pattern where the release is not related with the source SHA, but with the SHA of the release repository, because of the posibility of using more than one application. I've just set the building blocks here. 

* The deployment can be linked to merges on main branch of the source repository. 

* You can choose to deploy as `latest` or SHA tags.


### 🏠 [Homepage](https://github.com/jbianquetti/sre-challenge)

## Prerequisites

- Terraform
- Google Kubernetes Engine
- Helm 

## Prepare GKE

```bash
$ gcloud auth login
$ export PROJECT_ID=landbot-25169
$ gcloud config set project $PROJECT_ID 
```

#### Create SVC account to use with TF 

```bash
$ gcloud iam service-accounts create "tf-service-account"  --project "${PROJECT_ID}"
```

#### Create a Service Account Key JSON for the Service Account

```bash
gcloud iam service-accounts keys create "key.json" \
  --iam-account "tf-service-account@${PROJECT_ID}.iam.gserviceaccount.com"
```

#### Upload the contents of this file as a GitHub Actions Secret.

Use the name of the GitHub Actions secret as the credentials_json value in the GitHub Actions YAML

#### Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

```bash
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
```


#### Install the plugin to get credentials from GKE

```bash
gcloud components install gke-gcloud-auth-plugin
gcloud container clusters get-credentials ${PROJECT_ID}-gke --region us-central1
```


## Usage
First time, you need to create the GCS bucket to save TF state.

```bash
terraform plan -var-file terraform.tfvars -target google_storage_bucket.terraform-bucket-for-state -out /tmp/plan
terraform apply -out /tmp/plan
```

Following pushes to the repository will create or update the rest of infrastructure 

If you want a manual deploy, just run:

```bash
terraform plan -var-file terraform.tfvars -out /tmp/plan
terraform apply -out /tmp/plan
```




## Author

👤 **Jorge Bianquetti**

* Github: [@jbianquetti](https://github.com/jbianquetti)
* LinkedIn: [@jbianquetti](https://linkedin.com/in/jbianquetti)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!<br />Feel free to check [issues page](https://github.com/kefranabg/readme-md-generator/issues). You can also take a look at the [contributing guide](https://github.com/kefranabg/readme-md-generator/blob/master/CONTRIBUTING.md).

## Show your support

Give a ⭐️ if this project helped you!

## 📝 License

MIT License

Copyright (c) 2024 Jorge Bianquetti

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
