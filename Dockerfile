FROM alpine:3.4
#FROM --platform=linux/amd64 alpine:3.4

ENV DEBIAN_FRONTEND noninteractive

# install Ruby
RUN apk add --no-cache --update ruby ruby-dev ruby-bundler python py-pip git build-base libxml2-dev libxslt-dev
RUN pip install boto s3cmd

# install fake-s3
COPY fakes3.gemspec Gemfile Gemfile.lock /app/
COPY lib/fakes3/version.rb /app/lib/fakes3/
WORKDIR /app
RUN bundle install
COPY . /app/

# run fake-s3
RUN mkdir -p /fakes3_root
CMD ["bin/fakes3", "-r",  "/fakes3_root", "-p",  "4569"]
EXPOSE 4569