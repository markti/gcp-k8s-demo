# gcp-k8s-demo

gcloud auth activate-service-account --key-file=./gcp-key.json

gcloud components install gke-gcloud-auth-plugin

gcloud container clusters get-credentials gke-fleet-ops-dev-ci3m88hs --region us-central1 --project fleet-ops-dev-ci3m88hs

