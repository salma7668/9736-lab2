.PHONY: setup daemon restore
setup:
	mkdir -p malicious_dir
daemon: setup
	./antivirusd.sh $(DIR) malicious_dir $(INTERVAL)
restore: setup
	./restore.sh $(DIR) malicious_dir
