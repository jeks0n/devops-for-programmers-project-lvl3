terraform {
  backend "remote" {
    organization = "hexlet-devops"

    workspaces {
      name = "hexlet-devops-project-lvl3"
    }
  }
}