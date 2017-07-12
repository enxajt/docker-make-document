# docker-make-document
impress for presentation : md > html > pdf

# how to use
docker build . -t make-document
docker run -it -p 8080:8888 -p 35720:35729 -v ~/npm-impress:/home/enxajt/npm-impress -v ~/Notes/impress-md:/home/enxajt/npm-impress/impress-md --hostname impress --add-host=impress:128.0.0.1 -e TZ=Europe/Paris make-document
made npm-impress dir on the host after this command
node impress @ inside containner

*TODO*
# impress
cp WD/Notes.bak/css /home/enxajt/npm-impress/impress-md/template
compare with Notes/plan~

impress background
