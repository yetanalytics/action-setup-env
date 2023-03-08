# action-setup-env

GitHub action to set up Java, Clojure, and Node environments. To run, invoke it as the first step in a workflow run:

``` yaml
    steps:
      - name: Setup CI Environment
        uses: yetanalytics/actions/setup-env@<tag>
        with:
            java-version: '11'
            java-distribution: 'temurin'
            node-version: '16'
            clojure-version: '1.11.1.1165'
```

Default options are shown, they may be omitted.

Will do the following:

* ~~Check out the project~~ post v0, the calling workflow is expected to do this.
* Install Java
* Install Node
* Install Clojure CLI

which will provide an environment suitable for testing and building Clojure(Script) projects.

