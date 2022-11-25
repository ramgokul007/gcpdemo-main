provider "google" {
 credentials = file("./DB_Server/db_key.json")
 project     = "dev-project-345909"
 region      = "asia-southeast1"
}

provider "google-beta" {
 credentials = file("./DB_Server/db_key.json")
 project     = "dev-project-345909"
 region      = "asia-southeast1"
}
