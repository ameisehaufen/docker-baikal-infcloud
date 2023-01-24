default: build

image = infcloudbaikal
tag = 0.13.1-0.5.2
timezone = America/Sao_Paulo

build:
	docker build \
			--build-arg TIMEZONE=$(timezone) \
			--tag "$(image):$(tag)" \
			--tag "$(image):latest" \
			-t kolohals/infcloudbaikal:latest \
			$(args) .

export:
	rm "$(image).$(tag).tgz" || true
	docker image save --output "$(image).$(tag).tgz" "$(image):$(tag)"

run:
	docker run -d \
			--name=infcloudbaikal \
			-e TZ=America/Sao_Paulo \
			--publish 58851:8800 \
			--volume "$$(pwd)/baikal:/var/www/baikal/Specific" \
			$(args) $(image)
