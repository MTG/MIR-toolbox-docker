.PHONY: build upload all

all: build push

build:
	docker build -t mtgupf/mir-toolbox .

push:
	docker push mtgupf/mir-toolbox

