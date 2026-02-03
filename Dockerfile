FROM ruby:3.3

RUN apt-get update -qq && apt-get install -y \
  default-mysql-client \
  nodejs \
  npm \
  libnss3 \
  libnspr4 \
  libatk1.0-0 \
  libatk-bridge2.0-0 \
  libcups2 \
  libdrm2 \
  libxkbcommon0 \
  libxcomposite1 \
  libxdamage1 \
  libxfixes3 \
  libxrandr2 \
  libgbm1 \
  libasound2 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install
RUN gem install foreman

# Install Playwright browsers
RUN PLAYWRIGHT_CLI_VERSION=$(bundle exec ruby -e "require 'playwright'; puts Playwright::COMPATIBLE_PLAYWRIGHT_VERSION.strip") && \
    npm install playwright@${PLAYWRIGHT_CLI_VERSION} && \
    ./node_modules/.bin/playwright install chromium

COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
