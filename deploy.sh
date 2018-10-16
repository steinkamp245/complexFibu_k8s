docker build -t steinkamp245/multi-client:latest -t steinkamp245/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t steinkamp245/multi-server:latest -t steinkamp245/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t steinkamp245/multi-worker:latest -t steinkamp245/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push steinkamp245/multi-client:latest
docker push steinkamp245/multi-server:latest
docker push steinkamp245/multi-worker:latest
docker push steinkamp245/multi-client:$SHA
docker push steinkamp245/multi-server:$SHA
docker push steinkamp245/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=steinkmap245/multi-client:$SHA
kubectl set image deployments/server-deployment server=steinkamp245/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=steinkamp245/multi-worker:$SHA