all::


LXC-CONFIG-FILE:
	@$(SHELL_PATH) ./scripts/LXC-CONFIG-GEN
-include LXC-CONFIG-FILE


INSTALL_FILES = \
		/var/log/packages/bridge-utils-*-*-* \
		/var/log/packages/lxc-*-*-* \
		/var/log/packages/vlan-*-*-* \
		$(LXC_TEMPLATES)/lxc-slackware


uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')

/var/log/packages/bridge-utils-*-*-*:
	slackpkg -batch=on -default_answer=y install bridge-utils

/var/log/packages/lxc-*-*-*:
	slackpkg -batch=on -default_answer=y install lxc

/var/log/packages/vlan-*-*-*:
	slackpkg -batch=on -default_answer=y install vlan


$(LXC_TEMPLATES)/lxc-slackware: templates/lxc-slackware
	rm -Rf $(LXC_CACHE)
	cp templates/lxc-slackware $(LXC_TEMPLATES)/lxc-slackware
	chmod 755 $(LXC_TEMPLATES)/lxc-slackware


install: $(INSTALL_FILES)


clean:
	rm -f LXC-CONFIG-FILE


# end of Makefile
