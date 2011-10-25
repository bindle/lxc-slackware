all::
	@echo " "
	@echo "To install files, run 'make install'"
	@echo " "


LXC-CONFIG-FILE:
	@$(SHELL_PATH) ./scripts/LXC-CONFIG-GEN
-include LXC-CONFIG-FILE


REQUIRED_PACKAGES = \
		/var/log/packages/bridge-utils-*-*-* \
		/var/log/packages/lxc-*-*-* \
		/var/log/packages/vlan-*-*-*
INSTALL_FILES = \
		$(LXC_TEMPLATES)/lxc-slackware \
		/etc/rc.d/rc.lxc \
		/etc/rc.d/rc.lxc.conf


uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')

/var/log/packages/bridge-utils-*-*-*:
	@slackpkg -batch=on -default_answer=y install bridge-utils

/var/log/packages/lxc-*-*-*:
	@slackpkg -batch=on -default_answer=y install lxc

/var/log/packages/vlan-*-*-*:
	@slackpkg -batch=on -default_answer=y install vlan


$(LXC_TEMPLATES)/lxc-slackware: templates/lxc-slackware
	@echo "installing LXC template..."
	@rm -Rf $(LXC_CACHE)
	@cp templates/lxc-slackware $(LXC_TEMPLATES)/lxc-slackware
	@chmod 755 $(LXC_TEMPLATES)/lxc-slackware

/etc/rc.d/rc.lxc: scripts/rc.lxc
	@echo "installing /etc/rc.d/rc.lxc..."
	@cp scripts/rc.lxc /etc/rc.d/rc.lxc
	@chmod 755 /etc/rc.d/rc.lxc
	
/etc/rc.d/rc.lxc.conf:
	@echo "installing /etc/rc.d/rc.lxc.conf..."
	@cp scripts/rc.lxc.conf /etc/rc.d/rc.lxc.conf
	@chmod 644 /etc/rc.d/rc.lxc.conf


install: $(REQUIRED_PACKAGES) $(INSTALL_FILES)

uninstall:
	rm -f  $(INSTALL_FILES)
	rm -Rf $(LXC_CACHE)


clean:
	rm -f LXC-CONFIG-FILE


# end of Makefile
