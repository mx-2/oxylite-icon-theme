ifeq ($(PREFIX),)
    PREFIX := /
endif

check:
	./check_symlinks.sh

tar: check
	( \
	    mkdir -p oxylite; \
	\
	    for d in actions apps categories devices emblems emotes \
	        mimetypes places status ui; \
	    do \
	        mkdir -p "oxylite/$${d}"; \
	        cp -ar "$${d}" "oxylite/"; \
	    done; \
	\
	    cp index.theme licenses.yml README.md oxylite/; \
	\
	    tar -c --owner=0 --group=0 \
	    --mode='u=rwX,g=rX,o=rX' \
	    --mtime="$$(date +%Y-%m-%d\ %H:%M:%S)" \
	    oxylite \
	    | gzip -9 > oxylite-icon-theme.tar.gz \
	)

tar_png: check
	( \
	    mkdir -p oxylite; \
	\
	    for d in actions apps categories devices emblems emotes \
	        mimetypes places status ui; \
	    do \
	        mkdir -p "oxylite/$${d}"; \
	        for svg in "$${d}/"*.svg; do \
	            if [[ -h $${svg} ]]; then \
	                ln -s "$$(readlink $${svg} | sed 's/\.svg/\.png/')" \
	                    "oxylite/$${svg/.svg/.png}"; \
	            elif [[ -f $${svg} ]]; then \
	                rsvg-convert --output="oxylite/$${svg/.svg/.png}" "$${svg}"; \
	            fi; \
	        done; \
	    done; \
	\
	    cp index.theme licenses.yml README.md oxylite/; \
	    sed -i 's/Name=Oxylite icons/Name=Oxylite PNG icons/' \
	        oxylite/index.theme; \
	\
	    tar -c --owner=0 --group=0 \
	    --mode='u=rwX,g=rX,o=rX' \
	    --mtime="$$(date +%Y-%m-%d\ %H:%M:%S)" \
	    oxylite \
	    | gzip -9 > oxylite-png-icon-theme.tar.gz \
	)

install:
	( \
	    prefix="$(PREFIX)/usr/share/icons/oxylite"; \
	    mkdir -p "$${prefix}"; \
	\
	    for d in actions apps categories devices emblems emotes \
	        mimetypes places status ui; \
	    do \
	        install -d "$${prefix}/$${d}"; \
	        cp -ar "$${d}" "$${prefix}"; \
	        chmod -R u=rwX,g=rX,o=rX "$${prefix}/$${d}"; \
	    done; \
	\
	    install -m 644 index.theme "$${prefix}/index.theme"; \
	    install -m 644 licenses.yml "$${prefix}/licenses.yml"; \
	    install -m 644 README.md "$${prefix}/README.md"; \
	)

clean:
	rm -rf oxylite
	rm -f oxylite-icon-theme.tar.gz
	rm -f oxylite-png-icon-theme.tar.gz
