# OpenCue documentation

[![Netlify Status](https://api.netlify.com/api/v1/badges/bef98bd8-69d2-4c22-a49e-c1c3897638ac/deploy-status)](https://app.netlify.com/sites/elated-haibt-1b47ff/deploys)

Welcome to the repository for the OpenCue documentation and website. This
repository hosts all of the code and resources to build the OpenCue
documentation and website. We welcome contributions to the docs.

## Contributing to the documentation

This section describes the process you need to follow, and the tools you need to
run, to propose changes to the OpenCue documentation.

### Before you begin

To learn about the process for contributing to OpenCue, see
[Contributing to OpenCue](https://www.opencue.io/contributing/opencue/contributing/). This page
provides additional help and information about contributing to the OpenCue documentation.

As with all changes to OpenCue, you also need to be familiar with common Git
workflows.

### Website infrastructure

We run [Hugo](https://gohugo.io/) to generate the OpenCue website. The site
implements the Hugo [Docsy theme](https://github.com/google/docsy) to provide
site structure and styling. The OpenCue website is managed and hosted on
[Netlify](https://www.netlify.com/).

OpenCue documentation is written in Markdown. To publish the site, we run Hugo
to generate HTML content.

### Proposing changes

On most existing website pages, click **Edit this page** to propose simple
changes to the documentation. You can then edit the Markdown for that page using
the GitHub online editor and create a new branch to commit your changes and
start a pull request.

For larger changes, such as proposing a new page, or proposing changes to the
site homepage, you can clone and set up a local copy of the repository. To
preview your changes locally on your development machine, you need to install a
number of dependencies, such as Git and the extended version of Hugo. For more
information, see the [Docsy documentation](https://github.com/google/docsy).

To set up a local copy of the OpenCue website:

1.  Clone the opencue.io repository:

    ```shell
    git clone https://github.com/AcademySoftwareFoundation/opencue.io.git
    ```

1.  Change to the `opencue.io` directory:

    ```shell
    cd opencue.io
    ```

1.  Recursively update all Git submodules in the repository to install Docsy and
    related dependencies:

    **NOTE:** Docsy relies on additional submodules, such as Bootstrap. If you
    skip this step, the `hugo` command fails.

    ```shell
    git submodule update --init --recursive
    ```

1.  Run the npm command to install any required Node.js dependencies:

    ```
    npm install
    ```

1.  Run the `hugo` command to verify the installation steps were successful:

    ```
    hugo
    ```
    
You can now create a Git branch in your copy of the repository to experiment
with making changes. To preview your changes in a browser, run the `hugo server`
command. When you're ready to push your changes to the opencue.io repository,
create a [pull request](https://help.github.com/en/articles/about-pull-requests).

### Writing guidelines

The OpenCue documentation follows the
[Google Developer Documentation Style Guide](https://developers.google.com/style/).
As with changes to the primary OpenCue repository, all changes to the
documentation and website are peer-reviewed by project contributors.
