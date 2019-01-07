file=`ls`
if [ -d "web" ]
then
echo "There is a file named web"
cd web
git pull
else
echo "ready to pull the project named web"
git clone https://github.com/AutoDa/web.git
echo "had pull the project"
fi
cd ..
docker build -f web/dockerfile -t dingblue/web web
checkport=`docker ps -a | grep 0.0.0.0:80`
if [$checkport==NULL];
then
docker run -d -p 80:80 dingblue/web
else
for e in $checkport:
do
 echo $e
done
docker stop ${e%?}
docker rm ${e%?}
docker run -d -p 80:80 dingblue/web
fi
