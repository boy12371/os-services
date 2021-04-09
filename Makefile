TARGETS := $(shell ls scripts | grep -vE 'clean|run|help')

.dapper:
	@echo Downloading dapper
	@curl -sL https://github.com/boy12371/dapper/releases/download/v0.5.4/dapper-`uname -s`-`uname -m|sed 's/v7l//'` > .dapper.tmp
	@@chmod +x .dapper.tmp
	@./.dapper.tmp -v
	@mv .dapper.tmp .dapper

$(TARGETS): .dapper
	mkdir -p dist
	./.dapper

shell-bind: .dapper
	./.dapper -m bind -s

clean:
	@./scripts/clean

.DEFAULT_GOAL := ci

.PHONY: $(TARGETS)
