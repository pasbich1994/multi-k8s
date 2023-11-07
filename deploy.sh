docker build -t pasbich1994/multi-client-k8s:latest -t pasbich1994/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t pasbich1994/multi-server-k8s:latest -t pasbich1994/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t pasbich1994/multi-worker-k8s:latest -t pasbich1994/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push pasbich1994/multi-client-k8s:latest
docker push pasbich1994/multi-server-k8s:latest
docker push pasbich1994/multi-worker-k8s:latest

docker push pasbich1994/multi-client-k8s:$SHA
docker push pasbich1994/multi-server-k8s:$SHA
docker push pasbich1994/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pasbich1994/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=pasbich1994/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=pasbich1994/multi-worker-k8s:$SHA