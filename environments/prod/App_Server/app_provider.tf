provider "google" {
 credentials = file("./App_Server/app_key.json")
 project     = "pacific-attic-343704"
 region      = "us-west1"
}