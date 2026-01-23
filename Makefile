.PHONY: release-recipe release-recipes help

help:
	@echo "Available targets:"
	@echo "  release-recipe RECIPE=<name> VERSION_TAG=<version> - Release specific recipe with version"
	@echo "  release-recipes VERSION_TAG=<version>   - Release all recipes with specified version"
	@echo ""
	@echo "Examples:"
	@echo "  make release-recipe RECIPE=rust VERSION_TAG=v1.0.0"
	@echo "  make release-recipe RECIPE=motoko VERSION_TAG=v1.1.0"
	@echo "  make release-recipes VERSION_TAG=v1.0.0"

release-recipes:
	@if [ -z "$(VERSION_TAG)" ]; then \
		echo "Error: VERSION_TAG is required"; \
		echo "Usage: make release-recipes VERSION_TAG=v1.0.0"; \
		exit 1; \
	fi
	@echo ""
	@echo "=== Release Summary ==="
	@echo "Version: $(VERSION_TAG)"
	@echo ""
	@echo "The following recipes will be released:"
	@for recipe in $$(ls recipes/); do \
		echo "  - $$recipe-$(VERSION_TAG)"; \
	done
	@echo ""
	@echo "For each recipe, the following commands will be executed:"
	@echo "  1. git tag -a <recipe>-$(VERSION_TAG) -m \"Release <recipe> recipe $(VERSION_TAG)\""
	@echo "  2. git push origin <recipe>-$(VERSION_TAG)"
	@echo ""
	@echo "This will trigger GitHub Actions to create releases with:"
	@echo "  - Auto-generated changelogs"
	@echo "  - Release artifacts (tar.gz, zip, checksums)"
	@echo ""
	@read -p "Proceed with releases? [y/N] " confirm; \
	if [ "$$confirm" != "y" ] && [ "$$confirm" != "Y" ]; then \
		echo "Releases cancelled."; \
		exit 1; \
	fi
	@echo ""
	@echo "Creating release tags for all recipes with version: $(VERSION_TAG)"
	@for recipe in $$(ls recipes/); do \
		echo "Creating tag for $$recipe: $$recipe-$(VERSION_TAG)"; \
		git tag -a "$$recipe-$(VERSION_TAG)" -m "Release $$recipe recipe $(VERSION_TAG)"; \
	done
	@echo ""
	@echo "Pushing all recipe tags..."
	@for recipe in $$(ls recipes/); do \
		git push origin "$$recipe-$(VERSION_TAG)"; \
	done
	@echo ""
	@echo "All recipe release tags created! GitHub Actions will build and publish the releases."
	@echo ""
	@read -p "Also update all -latest tags to point to this version? [y/N] " answer; \
	if [ "$$answer" = "y" ] || [ "$$answer" = "Y" ]; then \
		for recipe in $$(ls recipes/); do \
			echo "Creating/updating latest tag: $$recipe-latest"; \
			git tag -a "$$recipe-latest" -m "Latest $$recipe recipe ($(VERSION_TAG))" -f; \
			git push origin "$$recipe-latest" -f; \
		done; \
		echo ""; \
		echo "Latest tags updated! Remember to manually create/update the -latest releases on GitHub."; \
	else \
		echo "Skipping latest tags update."; \
	fi

release-recipe:
	@if [ -z "$(RECIPE)" ]; then \
		echo "Error: RECIPE is required"; \
		echo "Usage: make release-recipe RECIPE=rust VERSION_TAG=v1.0.0"; \
		exit 1; \
	fi
	@if [ -z "$(VERSION_TAG)" ]; then \
		echo "Error: VERSION_TAG is required"; \
		echo "Usage: make release-recipe RECIPE=rust VERSION_TAG=v1.0.0"; \
		exit 1; \
	fi
	@if [ ! -d "recipes/$(RECIPE)" ]; then \
		echo "Error: Recipe '$(RECIPE)' does not exist"; \
		echo "Available recipes: $$(ls recipes/)"; \
		exit 1; \
	fi
	@echo ""
	@echo "=== Release Summary ==="
	@echo "Recipe:  $(RECIPE)"
	@echo "Version: $(VERSION_TAG)"
	@echo ""
	@echo "The following commands will be executed:"
	@echo "  1. git tag -a $(RECIPE)-$(VERSION_TAG) -m \"Release $(RECIPE) recipe $(VERSION_TAG)\""
	@echo "  2. git push origin $(RECIPE)-$(VERSION_TAG)"
	@echo ""
	@echo "This will trigger GitHub Actions to create a release with:"
	@echo "  - Auto-generated changelog"
	@echo "  - Release artifacts (tar.gz, zip, checksums)"
	@echo ""
	@read -p "Proceed with release? [y/N] " confirm; \
	if [ "$$confirm" != "y" ] && [ "$$confirm" != "Y" ]; then \
		echo "Release cancelled."; \
		exit 1; \
	fi
	@echo ""
	@echo "Creating $(RECIPE) recipe release tag: $(RECIPE)-$(VERSION_TAG)"
	git tag -a $(RECIPE)-$(VERSION_TAG) -m "Release $(RECIPE) recipe $(VERSION_TAG)"
	git push origin $(RECIPE)-$(VERSION_TAG)
	@echo ""
	@echo "Release tag created! GitHub Actions will build and publish the release."
	@echo ""
	@read -p "Also update $(RECIPE)-latest tag to point to this version? [y/N] " answer; \
	if [ "$$answer" = "y" ] || [ "$$answer" = "Y" ]; then \
		echo "Creating/updating latest tag: $(RECIPE)-latest"; \
		git tag -a $(RECIPE)-latest -m "Latest $(RECIPE) recipe ($(VERSION_TAG))" -f; \
		git push origin $(RECIPE)-latest -f; \
		echo ""; \
		echo "Latest tag updated! Remember to manually create/update the $(RECIPE)-latest release on GitHub."; \
	else \
		echo "Skipping latest tag update."; \
	fi
