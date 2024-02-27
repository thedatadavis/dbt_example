ENV ?= dev

run_dbt:
	@echo "Running dbt in $(ENV) environment."
	@echo "==============================="
	@echo "Compiling..."
	dbt compile --target $(ENV)

	@echo "==============================="
	@echo "Running..."
	dbt run --target $(ENV)

	@echo "==============================="
	@echo "Generating docs..."
	dbt docs generate --target $(ENV)
	cp -rf ./target/index.html ./target/catalog.json ./target/manifest.json ./docs/

	@echo "==============================="
	@echo "Building report sources..."
	cp -rf ./target/compiled/rentals/analyses/* ./reports/sources/rentals/