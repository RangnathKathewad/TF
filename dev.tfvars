project_id = "adh-staging"

environment = "test"

instance_template_name = "adh-test-instance-template"

size = 1

service_account = "terraform@adh-staging.iam.gserviceaccount.com"

startup_script = "adh-inst-temp-startup-script.sh"

branch = "release/production-280622"

region = "us-central1"

zones = ["us-central1-a", "us-central1-b", "us-central1-c"]

instance_group_name = "adh-test-instance-group"

base_instance_name = "adh-test"

domain = ["antidotehealth.ai"]
domain_name = "antidotehealth-ai"
