USER := 
REPO := 

clean:
	rm -rf *.html \\
	rm -rf *.md \\
	rm -rf *.R
 
deploy:
	cd $(REPO) && \
	git init . && \
	git add . && \
	git commit -m 'update blog'; \
	git push git@github.com:$(USER)/$(REPO) master:gh-pages --force && \
	rm -rf .git && \
	cd ../..