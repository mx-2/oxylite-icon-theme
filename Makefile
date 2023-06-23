ifeq ($(PREFIX),)
    PREFIX := /
endif

tar:
	( \
	    tar -c --owner=0 --group=0 \
	    --mtime="$$(date +%Y-%m-%d\ %H:%M:%S)" \
	    --transform 's,^,oxylite/,' \
	    actions apps categories devices emblems emotes \
	    mimetypes places status ui \
	    index.theme licenses.yml README.md \
	    | gzip -9 > oxylite-icon-theme.tar.gz \
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
	rm -f oxylite-icon-theme.tar.gz
