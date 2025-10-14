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
	@echo "Creating release tags for all recipes with version: $(VERSION_TAG)"
	@for recipe in $$(ls recipes/); do \
		echo "Creating tag for $$recipe: $$recipe-$(VERSION_TAG)"; \
		git tag -a "$$recipe-$(VERSION_TAG)" -m "Release $$recipe recipe $(VERSION_TAG)"; \
		echo "Creating/updating latest tag for $$recipe: $$recipe-latest"; \
		git tag -a "$$recipe-latest" -m "Latest $$recipe recipe ($(VERSION_TAG))" -f; \
	done
	@echo "Pushing all recipe tags..."
	@for recipe in $$(ls recipes/); do \
		git push origin "$$recipe-$(VERSION_TAG)"; \
		git push origin "$$recipe-latest" -f; \
	done
	@echo "All recipe release tags created! GitHub Actions will build and publish the releases."

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
	@echo "Creating $(RECIPE) recipe release tag: $(RECIPE)-$(VERSION_TAG)"
	git tag -a $(RECIPE)-$(VERSION_TAG) -m "Release $(RECIPE) recipe $(VERSION_TAG)"
	@echo "Creating/updating latest tag: $(RECIPE)-latest"
	git tag -a $(RECIPE)-latest -m "Latest $(RECIPE) recipe ($(VERSION_TAG))" -f
	git push origin $(RECIPE)-$(VERSION_TAG)
	git push origin $(RECIPE)-latest -f
	@echo "Release tags created! GitHub Actions will build and publish the releases."
