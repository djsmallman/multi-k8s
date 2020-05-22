docker build -t djsmallman/multi-client:latest -t djsmallman/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t djsmallman/multi-server:latest -t djsmallman/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t djsmallman/multi-worker:latest -t djsmallman/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push djsmallman/multi-client:latest
docker push djsmallman/multi-server:latest
docker push djsmallman/multi-worker:latest

docker push djsmallman/multi-client:$SHA
docker push djsmallman/multi-server:$SHA
docker push djsmallman/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=djsmallman/multi-server:$SHA
kubectl set image deployments/client-deployment client=djsmallman/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=djsmallman/multi-worker:$SHA