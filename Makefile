maven:
	./mvnw clean package

docker:
	docker build -t example:latest .

start:
	@echo $(CURDIR)
	@docker run -d --name=example-config-server -p 8888:8888 -e SPRING_PROFILES_ACTIVE=native -v $(CURDIR)/data:/config hyness/spring-cloud-config-server
	@while ! curl -s http://localhost:8888 >/dev/null; do sleep 1; done
	@echo ------------------------------------------------------------------------------------------
	-docker run --rm --network host -eFROM_ROOT=0 -eCLI_IMPORT=0 example
	@echo ------------------------------------------------------------------------------------------
	-docker run --rm --network host -eFROM_ROOT=1 -eCLI_IMPORT=0 example
	@echo ------------------------------------------------------------------------------------------
	-docker run --rm --network host -eFROM_ROOT=0 -eCLI_IMPORT=1 example
	@echo ------------------------------------------------------------------------------------------
	-docker run --rm --network host -eFROM_ROOT=1 -eCLI_IMPORT=1 example
	@echo ------------------------------------------------------------------------------------------

stop:
	-docker stop example-config-server
	-docker rm example-config-server

run: start stop
all: maven docker run
