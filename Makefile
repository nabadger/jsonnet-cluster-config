all :  ## (Default) Run whole make process inside a docker container
	make _clean _generate _diff
local : _fmt _generate _diff ## Run whole make process locally without a docker container

SHELL = /bin/bash

ifneq ($(strip $(CLUSTER)),)
ifeq ($(shell echo $(CLUSTER) | egrep ".*/.*" ),)
$(error CLUSTER variable must be of the form <env>/<cluster> if specified)
endif
endif

ALL_TK = $(shell find environments/$(CLUSTER) -type f -name "spec.json")
MAKEFILE_LIST = Makefile

CONTAINER_CMD:=docker run --rm -it \
	-u="$(shell id -u):$(shell id -g)" \
	-v $$(pwd):/src/ \
	--workdir /src/ \
	grafana/tanka:latest

help: ## Print this help
	@grep -E '^[a-zA-Z_-]+\s?:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
#
# Public entrypoints for docker container use
#
#
diff : ## Run a git diff to compare before/after.
	make _diff

generate :
	make _generate CLUSTER=$(CLUSTER)

fmt :
	make _fmt

_fmt :
	@echo ">> Running tk fmt"
	@if ! tk fmt . ; then \
		echo "tk fmt failed" >&2; \
		exit 1;\
	fi
clean:
	make _clean

_clean :
	@echo ">> Cleaning rendered"
	rm -rf rendered 

#
# make _diff
#
_diff :
	@echo ">> Rendered manifests diff"
	@git status
	git --no-pager diff --exit-code rendered/
	! git status -s | egrep "^\?\?"

_generate :
	@echo ">> Generating rendered manifests via tk"
	@mkdir -p $$(pwd)/rendered/ ;\
	touch $$(pwd)/rendered/.gitkeep ;\

	@for f in $(ALL_TK); do \
	    echo "generating $$f"; \
		app_path="$$(dirname $$f)" ;\
		rendered_path="./rendered/$${app_path}" ;\
		mkdir -p $${rendered_path} ;\
		tk export $$(dirname $$f) $${rendered_path} > /dev/null ;\
	done

.PHONY: _diff, _generate, _fmt, _clean, diff, generate, help, fmt, clean
