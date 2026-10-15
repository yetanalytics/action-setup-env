# action-setup-env

GitHub action to set up Java, Clojure, and Node environments. To run, invoke it as the first step in a workflow run:

``` yaml
    steps:
      - name: Setup CI Environment
        uses: yetanalytics/action-setup-env@<tag>
        with:
            java-version: '11'
            java-distribution: 'temurin'
            node-version: '20'
            clojure-version: '1.11.4.1474'
```

Default options are shown, they may be omitted.

Will do the following:

* ~~Check out the project~~ post v0, the calling workflow is expected to do this.
* Install Java
* Install Node
* Install Clojure CLI

which will provide an environment suitable for testing and building Clojure(Script) projects.

## Dependency vulnerability tracking

The dependency graph and Dependabot alerts are enabled for this repository.
GitHub's [static graph parser](https://docs.github.com/en/code-security/reference/supply-chain-security/dependency-graph-supported-package-ecosystems)
reads workflows under `.github/workflows`; it does
not discover the dependencies in this repository's root composite `action.yml`.

The `Deps` workflow reads `action.yml` and submits its direct action references
to the dependency graph on pushes to `main`, or when run manually. It uses the
workflow's `GITHUB_TOKEN` with `contents: write`; no additional secret is needed.
There is no separate dependency list to keep synchronized.

Coverage includes `actions/setup-java`, `actions/setup-node`, and
`DeLaGuardo/setup-clojure` at their declared references. It does not expand their
own dependencies or track the Java, Node, and Clojure installations they download.
Those runtimes and tools require separate vulnerability coverage. GitHub's
matching of submitted references to advisories should be checked after the
first hosted submission.
