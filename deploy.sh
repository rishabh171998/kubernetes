docker build -t ei5688/multi-client:latest -t ei5688/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t ei5688/multi-server:latest -t ei5688/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t ei5688/multi-worker:latest -t ei5688/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker


docker push ei5688/multi-client:latest
docker push ei5688/multi-server:latest
docker push ei5688/multi-worker:latest


docker push ei5688/multi-client:$GIT_SHA
docker push ei5688/multi-server:$GIT_SHA
docker push ei5688/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ei5688/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=ei5688/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=ei5688/multi-worker:$GIT_SHA