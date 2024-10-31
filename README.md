# Kubernetes Ejemplos

## Instalación de MicroK8s

Para instalar los paquetes necesarios antes de iniciar las pruebas.

```bash
git clone https://github.com/fcchn4/argocd-demo.git
cd argocd-demo
sudo init-scripts/mk8s-install.sh <USER_NAME>
```

Es importante mencionar que estamos utilizando MicroK8s para simular un cluster K8s.

## Preparando MicroK8s

Habilitando algunos complementos para MicroK8s.

```bash
microk8s enable dns dashboard rbac
```

Configurando el Dashboard para MicroK8s, obtener Token Dashboard.

```bash
kubectl describe secret -n kube-system microk8s-dashboard-token
```

La salida del anterior comando muestra el Token que es necesario para ingresar al Dashboard.

```yaml
token: VALUE_TOKEN
```

Para identificar el servicio del Dashboard y su IP, debemos listar los servicios.

```bash
kubectl get svc -n kube-system
```

La salida del comando muestra el IP y los puertos similares a esto.

```yaml
kubernetes-dashboard  ClusterIP  10.152.183.103  <none>  443/TCP  36m
```

Este IP solo funciona en la maquina local, en el navegador los datos son:

```yaml
https://10.152.183.103/
```

## Configuraciones ArgoCD

Instalación de ArgoCD

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Cambiamos el tipo de al Servicio a LoadBalancer.

```bash
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

Para utilizar el UI Web de ArgoCD, podemos utilizar el servicio haciendo un Port Forward.

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Se debe configurar el acceso a la Web de ArgoCD, para obtener el Token.

```bash
argocd admin initial-password -n argocd
```

Para la configuración para el login seria.

```bash
argocd login <ARGOCD_SERVER> # Para el ejemplo: argocd login localhost:8080
```

En un navegador web probar la web de ArgoCD.

```bash
http://localhost:8080
```

## Creación de Aplicaciones, ejemplos

Creación de una aplicación mediante CLI de ArgoCD.

Se establece el espacio de nombres en ArgoCD.

```bash
kubectl config set-context --current --namespace=argocd
```

Creamos la aplicación de Guestbook (libro de visitas) desde un repositorio Git.

```bash
argocd app create guestbook \
--repo https://github.com/argoproj/argocd-example-apps.git \
--path guestbook --dest-server https://kubernetes.default.svc \
--dest-namespace default
```

Cuespo de un manifiesto para ArgoCd.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: ''
spec:
  destination:
    name: ''
    namespace: ''
    server: ''
  source:
    path: ''
    repoURL: ''
    targetRevision: HEAD
  sources: []
  project: ''
```

## Referencias

- [Guía de Inicialización](https://argo-cd.readthedocs.io/en/stable/getting_started/).
- [ArgoCd Cli Install](https://github.com/argoproj/argo-cd).
