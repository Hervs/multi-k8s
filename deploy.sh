# latest tag to keep the latest updated and sha tag to keep easier to track posible problems on the image that is currently on production
docker build -t hervs/multi-client:latest -t hervs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hervs/multi-server:latest -t hervs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hervs/multi-worker:latest -t hervs/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hervs/multi-client:latest
docker push hervs/multi-server:latest
docker push hervs/multi-worker:latest

docker push hervs/multi-client:$SHA
docker push hervs/multi-server:$SHA
docker push hervs/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=hervs/multi-server:$SHA
kubectl set image deployments/client-deployment client=hervs/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hervs/multi-worker:$SHA
