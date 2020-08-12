provider "vault" {
  alias     = "dev"
  namespace = "dev"
}

provider "vault" {
  alias     = "test"
  namespace = "test"
}

provider "vault" {
  alias     = "prod"
  namespace = "prod"
}

module "dev" {
  source = "./namespace"
  path   = "dev"
}

module "test" {
  source = "./namespace"
  path   = "test"
}

module "prod" {
  source = "./namespace"
  path   = "prod"
}
