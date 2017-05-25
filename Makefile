build:
	docker build -t gocd-agent .

run:
	docker run -d --name gocd-agent gocd-agent

clean:
	docker rm -f gocd-agent