all :  ## (Default) Run whole make process inside a docker container
	$(CONTAINER_CMD) make _test _generate _diff
local : _test _generate _diff ## Run whole make process locally without a docker container

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
clean : ## Delete everything in ./rendered except for flux-patch.conf files.
	make _clean CLUSTER=$(CLUSTER)

diff : ## Run a git diff to compare before/after.
	make _diff

generate : ## Run clean, then generate new raw manifests for all clusters.
	make _generate CLUSTER=$(CLUSTER)

fmt : ## Execute yamllint against all yaml files.
	make _fmt

test : ## Run fmt.
	 make _test

#
# make _test
#
_test : _fmt

_fmt :
	@echo ">> Running tk fmt"
	@if ! tk fmt . ; then \
		echo "tk fmt failed" >&2; \
		exit 1;\
	fi

#
# make _diff
#
_diff :
	@echo ">> Rendered manifests diff"
	@git status
	git --no-pager diff --exit-code rendered/
	! git status -s | egrep "^\?\?"

_generate : _clean
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

_clean :
	@echo ">> Cleaning rendered manifests directory"
	find rendered/environments/$(CLUSTER) -type d -empty -delete ;\

.PHONY: _clean, _diff, _generate, _fmt, _test, clean, check-flux-patches, diff, generate, help, fmt, test
