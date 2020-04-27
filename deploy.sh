docker build -t tsamuelk/multi-client:latest -t tsamuelk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tsamuelk/multi-server:latest -t tsamuelk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tsamuelk/multi-worker:latest -t tsamuelk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tsamuelk/multi-client:latest
docker push tsamuelk/multi-server:latest
docker push tsamuelk/multi-worker:latest

docker push tsamuelk/multi-client:$SHA
docker push tsamuelk/multi-server:$SHA
docker push tsamuelk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tsamuelk/multi-server:$SHA
kubectl set image deployments/client-deployment client=tsamuelk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tsamuelk/multi-worker:$SHA
