build:
	docker build -t mtgupf/mir-toolbox .

push:
	docker push mtgupf/mir-toolbox

all: build push


 .PHONY: build upload all
