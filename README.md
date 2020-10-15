# Assumptions

1.  These sets of playbooks were deployed with Ansible 2.6
1.  You will need the following Ansible Galaxy playbooks installed: `ansible-galaxy install geerlingguy.java`
1.  Ansible uses the boto3 library for AWS access. That will automatically configure itself from several mechanisms — either use a tool such as [`aws-vault`](https://github.com/99designs/aws-vault) to manage the environment (recommended) or follow the [boto3 configuration guide](https://boto3.amazonaws.com/v1/documentation/api/latest/guide/configuration.html) to ensure that your API keys are available. It is recommended that you use an AWS named profile (e.g. `ndnp`) and let `aws-vault` manage short term credentials with rotation.
1.  Create an EC2 SSH key-pair and make sure the `AWS_KEY_PAIR` environmental variable specifies it by name.
1.  Add `Chronam-deploy-aws-ansible-vault` to your system keychain:

    ```bash
    $ security add-generic-password -a ${USER} -s "Chronam-deploy-aws-ansible-vault"
    ```

1.  Data has already been uploaded to S3

# Setup the environment

Before we can deploy to AWS we need to setup several environments so that we conform to A&A security requirements. See setup.sh

# How to deploy to AWS

run `deploy_<ENVIRONMENT>.sh` depending on where you want to deploy

# Ingest data

-   Load the very old titles that only exist in our archive
    \*\* https://s3.console.aws.amazon.com/s3/buckets/chronam-original-titles/?region=us-east-1&tab=overview
-   pull and load the other titles
-   load the essays
-   load the holdings
    \*\* https://s3.console.aws.amazon.com/s3/buckets/chronam-holdings/?region=us-east-1&tab=overview
-   then create a script to split up the batches based on release date. This was then used to load the batches on the various django servers we created early. This ensures that we don't try and load 2 batches from the same awardee at the same time which causes problems
-   then we ran `django-admin release --reset` to make the release dates the same between systems
-   then we ran `django-admin dump_ocr` to generate all the OCR data
-   look at /status page and check against known good instance and tweak as necessary

# Contributing to this repo

1. Ensure that [`pre-commit`](https://pre-commit.com) is installed (e.g. `brew install pre-commit` or `apt-get install pre-commit`) and that you have run `pre-commit install` at least once
