```
docker pull luanlmd/cordova

echo "alias cordova='docker run -it --rm --privileged --expose 8000 -p 8000:8000 -v /dev/bus/usb:/dev/bus/usb -v \$PWD:/src luanlmd/cordova cordova'" >> ~/.bash_aliases
source ~/.bash_aliases

cordova create project_name
cd project_name
cordova platform add android
cordova build
```
