# Dex Metrics Repo

This repo is for managing queries and discussions around the [Dune DEX Metrics](https://dune.com/hagaetc/dex-metrics) dashboard.

>*This repo was created [using this template](https://github.com/duneanalytics/DuneQueryRepo), made to [manage your Dune queries](https://dune.mintlify.app/api-reference/crud/endpoint/create) and any [CSVs as Dune tables](https://dune.mintlify.app/api-reference/upload/endpoint/upload).*

### For Contributors

I've set up four types of issues right now:
- `bugs`: This is for data quality issues like miscalculations or broken queries.
- `chart improvements`: This is for suggesting improvements to the visualizations.
- `query improvements`: This is for suggesting improvements to the query itself, such as adding an extra column or table that enhances the results.
- `generic questions`: This is a catch all for other questions or suggestions you may have about the dashboard.

If you want to contribute, either start an issue or go directly into making a PR (using the same labels as above). Once the PR is merged, the queries will get updated in the frontend.

### Query Management Scripts

You'll need python and pip installed to run the script commands. If you don't have a package manager set up, then use either [anaconda](https://www.anaconda.com/download) or [poetry](https://python-poetry.org/) . Then install the required packages:

```
pip install -r requirements.txt
```

| Script | Action                                                                                                                                                    | Command |
|---|-----------------------------------------------------------------------------------------------------------------------------------------------------------|---|
| `pull_from_dune.py` | updates/adds queries to your repo based on ids in `queries.yml`                                                                                           | `python scripts/pull_from_dune.py` |
| `push_to_dune.py` | updates queries to Dune based on files in your `/queries` folder                                                                                          | `python scripts/push_to_dune.py` |
| `preview_query.py` | gives you the first 20 rows of results by running a query from your `/queries` folder. Specify the id. This uses Dune API credits | `python scripts/preview_query.py 2615782` |
| `upload_to_dune.py` | uploads/updates any tables from your `/uploads` folder. Must be in CSV format, and under 200MB. | `python scripts/upload_to_dune.py` |
