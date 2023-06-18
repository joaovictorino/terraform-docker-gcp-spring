resource "google_sql_database_instance" "db-service" {
  database_version = "MYSQL_8_0"
  name             = "db-service"
  region           = var.region

  settings {
    tier = "db-f1-micro"
    #db-g1-small
  }

  deletion_protection = false
}

resource "google_sql_database" "db-petclinic" {
  name     = "petclinic"
  instance = google_sql_database_instance.db-service.name
}

resource "google_sql_user" "db-user-petclinic" {
  name     = "petclinic"
  instance = google_sql_database_instance.db-service.name
  password = "petclinic"
}
