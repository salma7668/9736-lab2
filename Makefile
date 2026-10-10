setup:
	mkdir -p malicious_dir
daemon:
	./antivirusd.sh $(DIR) malicious_dir $(INTERVAL)
restore:
	./restore.sh $(DIR) malicious_dir
