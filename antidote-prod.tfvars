project_id = "med-and-beyond"

environment = "test"

instance_template_name = "adh-test-instance-template"

size = 1

tf_service_account_key_file = "med-and-beyond-tf-key-file.json"

startup_script = "adh-inst-temp-startup-script.sh"

branch = "release/production-280622"

region = "us-central1"

zones = ["us-central1-a", "us-central1-b", "us-central1-c"]

instance_group_name = "adh-test-instance-group"

base_instance_name = "adh-test"

domain = ["antidotehealth.ai"]
domain_name = "antidotehealth-ai"
service_account = "adh-terraform-sa@med-and-beyond.iam.gserviceaccount.com"
