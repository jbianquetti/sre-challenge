
resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress-controller"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "nginx-ingress-controller"
  create_namespace = true
  namespace        = "nginx-ingress"
  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
}

resource "helm_release" "sre-challenge-app" {
  name              = "sre-challenge-app"
  version           = "0.1.1"
  chart             = "./chart/sre-challenge-app"
  create_namespace  = true
  namespace         = "sre-challenge"
  upgrade_install   = true
  dependency_update = true
  values = [
    file("./chart/sre-challenge-app/values.yaml")
  ]
}
