# docker-make-document
impress for presentation : md > html > pdf

# how to use
docker build . -t impress
docker run -it -p 8080:8888 -v $(pwd):/npm-impress/impress-md --hostname impress impress
made npm-impress dir on the host after this command
node impress @ inside containner

*TODO*
# impress
cp WD/Notes.bak/css /home/enxajt/npm-impress/impress-md/template
compare with Notes/plan~

impress background
