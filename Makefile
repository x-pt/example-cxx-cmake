.PHONY: dev clean

# create a image "example" with tag "latest"
# based on the Dockerfile in the current directory
dev:
	docker image build . -t example
	docker container run --rm example

clean:
	docker image rm example
