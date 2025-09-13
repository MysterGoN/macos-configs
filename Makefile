.PHONY: all-link all-unlink aerospace-link aerospace-unlink


ROOT_DIR := $(patsubst %/, %, $(dir $(realpath $(lastword $(MAKEFILE_LIST)))))
CONFIGS_FOLDER := ~/.config


define link_file
	$(eval $@_CONFIG_NAME = $(1))
	$(eval $@_CONFIG_TITLE = $(2))
	$(eval $@_CONFIG_PATH = $(CONFIGS_FOLDER)/${$@_CONFIG_NAME})
	
    @if test -e ${$@_CONFIG_PATH}; then \
   		echo "${$@_CONFIG_TITLE} config already exists. (${$@_CONFIG_PATH})"; \
   	else \
   		ln -s $(ROOT_DIR)/${$@_CONFIG_NAME} $(CONFIGS_FOLDER); \
   		echo "${$@_CONFIG_TITLE} config linked successfully. (${$@_CONFIG_PATH})"; \
   	fi
endef

define unlink_file
	$(eval $@_CONFIG_NAME = $(1))
	$(eval $@_CONFIG_TITLE = $(2))
	$(eval $@_CONFIG_PATH = $(CONFIGS_FOLDER)/${$@_CONFIG_NAME})

	@if test -L ${$@_CONFIG_PATH}; then \
		unlink ${$@_CONFIG_PATH}; \
		echo "${$@_CONFIG_TITLE} config unlinked successfully. (${$@_CONFIG_PATH})"; \
	elif test -e ${$@_CONFIG_PATH} ; then \
		echo "${$@_CONFIG_TITLE} config is not a symlink. (${$@_CONFIG_PATH})"; \
	else \
		echo "${$@_CONFIG_TITLE} config does't exists. (${$@_CONFIG_PATH})"; \
	fi
endef


all-link: aerospace-link

all-unlink: aerospace-unlink


aerospace-link:
	$(call link_file, aerospace, "AeroSpace")

aerospace-unlink:
	$(call unlink_file, aerospace, "AeroSpace")
