NAME := tarlz

build:
	docker build --no-cache -t $(NAME) .
