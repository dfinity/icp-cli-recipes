.PHONY: release-partials release-recipe release-recipes help

help:
	@echo "Available targets:"
	@echo "  release-partials VERSION_TAG=<version>  - Release partials with specified version"
	@echo "  release-recipe RECIPE=<name> VERSION_TAG=<version> - Release specific recipe with version"
	@echo "  release-recipes VERSION_TAG=<version>   - Release all recipes with specified version"
	@echo ""
	@echo "Examples:"
	@echo "  make release-partials VERSION_TAG=v1.0.0"
	@echo "  make release-recipe RECIPE=rust VERSION_TAG=v1.0.0"
	@echo "  make release-recipe RECIPE=motoko VERSION_TAG=v1.1.0"
	@echo "  make release-recipes VERSION_TAG=v1.0.0"

release-partials:
	@if [ -z "$(VERSION_TAG)" ]; then \
		echo "Error: VERSION_TAG is required"; \
		echo "Usage: make release-partials VERSION_TAG=v1.0.0"; \
		exit 1; \
	fi
	@echo "Creating partials release tag: partials-$(VERSION_TAG)"
	git tag -a partials-$(VERSION_TAG) -m "Release partials $(VERSION_TAG)"
	git push origin partials-$(VERSION_TAG)
	@echo "Release tag created! GitHub Actions will build and publish the release."

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
	done
	@echo "Pushing all recipe tags..."
	@for recipe in $$(ls recipes/); do \
		git push origin "$$recipe-$(VERSION_TAG)"; \
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
	git push origin $(RECIPE)-$(VERSION_TAG)
	@echo "Release tag created! GitHub Actions will build and publish the release."