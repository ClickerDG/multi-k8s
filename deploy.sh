docker build -t clickerdg/multi-client:latest -t clickerdg/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t clickerdg/multi-server:latest -t clickerdg/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t clickerdg/multi-worker:latest -t clickerdg/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push clickerdg/multi-client:latest
docker push clickerdg/multi-server:latest
docker push clickerdg/multi-worker:latest
docker push clickerdg/multi-client:$SHA
docker push clickerdg/multi-server:$SHA
docker push clickerdg/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=clickerdg/multi-client:$SHA
kubectl set image deployments/server-deployment server=clickerdg/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=clickerdg/multi-worker:$SHA