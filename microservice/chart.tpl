apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
    name: ${env}-${app}
    namespace: argo-cd
spec:
    project: microservice-${env}
    source:
        repoURL: git@github.com:lightuptw/deploy.git
        path: charts/microservices
        targetRevision: HEAD
        helm:
            releaseName: microservices
            valueFiles:
            - ../../${app}/values-${env}.yaml      

    destination:
        server: https://kubernetes.default.svc
        namespace: lightup-${env}