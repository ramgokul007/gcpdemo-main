provider "google" {
 credentials = file("./DB_Server/db_key.json")
 project     = "pacific-attic-343704"
 region      = "asia-southeast1"
}