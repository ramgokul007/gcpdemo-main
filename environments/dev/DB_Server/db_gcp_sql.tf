variable "static_ip_wp" {}

/*resource "google_secret_manager_secret" "local-admin-password" {
  provider = google-beta
  project = "dev-project-345909"

  secret_id   = "local-admin-password"

  replication {
    automatic = true
  }
  #depends_on = [google_project_service.secretmanager]
}

# Add the secret data for local-admin-password secret
resource "google_secret_manager_secret_version" "local-admin-password" {
  secret = google_secret_manager_secret.local-admin-password.id
  secret_data = "Sup3rS3cur3P@ssw0rd3"
}

data "google_secret_manager_secret_version" "local-admin-password" {
  provider = google-beta
  secret   = "local-admin-password"
  #version  = "1"
}

output "local-admin-password" {
  value = data.google_secret_manager_secret_version.local-admin-password.secret_data
  sensitive = true
}*/


resource "google_sql_database_instance" "sql_db" {
  depends_on = [
    google_compute_network.sql_vpc
  ]
  name = "sqldb104"
  #name = var.sqldb-inst-name
  database_version = "MYSQL_5_7"
  region       = "asia-southeast1"
  #region       = var.sqldb-region
  
  settings {
    tier = "db-f1-micro"

     ip_configuration {
                ipv4_enabled = true
                require_ssl  = false

                authorized_networks {
                    name  = "wpSQLconnect"
                   // value = var.static_ip_wp
                    value = "0.0.0.0/0"
                  // value = "192.168.1.0/24"
                }
            }
   }
}

resource "google_sql_database" "database" {
  name      = "wpdb"
  #name      = var.sqldb-name
  instance  = google_sql_database_instance.sql_db.name
}

resource "google_sql_user" "users" {
  name     = "root"
  instance = google_sql_database_instance.sql_db.name
  password = "sql-wp@&A#"
  #password = var.local-admin-password
  #password = google_secret_manager_secret_version.local-admin-password
}

output "uname" {
    value = google_sql_user.users.name
}

output "pass" {
    value = google_sql_user.users.password
}

output "pubip" {
    value = google_sql_database_instance.sql_db.public_ip_address
}

output "dbname" {
    value = google_sql_database.database.name
}
