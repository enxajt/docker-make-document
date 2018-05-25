impress for presentation : md > html > pdf

# how to use
```
docker build . -t impress
cd dir which contains .impress.md
docker run -it -p 8080:8888 -v $(pwd):/npm-impress/impress-md --hostname impress impress
node impress @ inside containner
```

*TODO*
- cp WD/Notes.bak/css /home/enxajt/npm-impress/impress-md/template
- compare with Notes/plan~
- impress background
