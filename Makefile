.PHONY: prepare run clean

prepare:
	@echo "Preparing environment..."
	@./scripts/install_ansible.sh

check:
	@echo "Checking Ansible playbook..."
	@./scripts/check_playbook.sh

run:
	@echo "Running Ansible playbook..."
	@./scripts/run_playbook.sh

clean:
	@echo "Cleaning up..."
	# If you have any temporary files to remove, do it here.
	# For example:
	# rm -f /tmp/*.deb
	@echo "Nothing to clean for now."
