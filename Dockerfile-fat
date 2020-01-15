FROM ruby:latest as build

COPY . /app
RUN cd /app \
 && echo "gem: --no-document" > ~/.gemrc \
 && gem install bundler:2.1.3 \
 && bundle install \
 && bundle exec rake build

FROM ruby:latest

COPY --from=build ./app/pkg/* .

RUN apt-get update \
    && apt-get install wget apt-transport-https gnupg lsb-release -y \
    && wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key |apt-key add - \
    && echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | tee -a /etc/apt/sources.list.d/trivy.list \
    && apt-get update -y \
    && apt-get install trivy -y \
    && trivy --download-db-only 

RUN echo "gem: --no-document" > ~/.gemrc

RUN gem install sherloc-*.gem && rm -rf sherloc-*.gem && export TRIVY_TIMEOUT_SEC=360s

ENTRYPOINT ["sherloc"]
