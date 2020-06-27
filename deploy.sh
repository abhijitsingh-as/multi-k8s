docker build -t abhijitsinghas/multi-client:latest -t abhijitsinghas/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t abhijitsinghas/multi-server:latest -t abhijitsinghas/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t abhijitsinghas/multi-worker:latest -t abhijitsinghas/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push abhijitsinghas/multi-client:latest
docker push abhijitsinghas/multi-server:latest
docker push abhijitsinghas/multi-worker:latest
docker push abhijitsinghas/multi-client:$SHA
docker push abhijitsinghas/multi-server:$SHA
docker push abhijitsinghas/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=abhijitsinghas/multi-server:$SHA
kubectl set image deployments/client-deployment client=abhijitsinghas/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=abhijitsinghas/multi-worker:$SHA
