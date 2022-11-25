provider "google" {
 credentials = file("./App_Server/app_key.json")
 project     = "dev-project-345909"
 region      = "us-west1"
}
