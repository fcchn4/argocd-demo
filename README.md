# Kubernetes Ejemplos

## Instalación de MicroK8s

Para instalar los paquetes necesarios antes de iniciar las pruebas.

```bash
git clone https://github.com/fcchn4/argocd-demo.git <USER_NAME>
```

Es importante mencionar que estamos utilizando MicroK8s para simular un cluster K8s.

## Examples ArgoCD

Habilitando algunos complementos para MicroK8s.

```bash
microk8s enable dns dashboard
```

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



## Referencias

- [Guía de Inicialización](https://argo-cd.readthedocs.io/en/stable/getting_started/).
- [ArgoCd Cli Install](https://github.com/argoproj/argo-cd).
