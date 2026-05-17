#################################################################################
# GLOBALS                                                                       #
#################################################################################

PROJECT_NAME = PORTFOLIO-DEEP-LEANING

#################################################################################
# COMMANDS                                                                      #
#################################################################################

## Install minimal system dependencies
.PHONY: bootstrap
bootstrap:
	@which pandoc || brew install pandoc
	@which xelatex || brew install --cask basictex

#################################################################################
# REPORTS                                                                       #
#################################################################################

REPORTS_BUILD_DIR := build/reports
TEMPLATES_DIR := templates
# Zoekt naar bestanden die eindigen op 'report.md' in submappen (zoals rnn-report.md)
REPORTS_PATHS := $(basename $(wildcard */*report.md))

## Generate PDF reports using the LaTeX template
.PHONY: reports
reports:
	@mkdir -p $(REPORTS_BUILD_DIR)
	@for report in $(REPORTS_PATHS); do \
		pandoc \
			$${report}.md \
			--resource-path=.:$$(dirname $${report}) \
			--pdf-engine=xelatex \
			--template=$(TEMPLATES_DIR)/report.tex \
			-V geometry:margin=1in \
			--output=$(REPORTS_BUILD_DIR)/$$(basename $${report}).pdf; \
	done
	@echo "\n✅ Reports generated successfully in $(REPORTS_BUILD_DIR)"