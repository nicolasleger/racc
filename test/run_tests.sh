#!/usr/bin/env bash

set -eux

test_frozen_strings=$(ruby -e 'puts (RUBY_ENGINE == "ruby" && RUBY_VERSION > "2.4")')

if [[ $test_frozen_strings == "true" ]] ; then
  echo "NOTE: enabling frozen string literals"
  rvm install rubygems 2.6.12 --force # because of an issue in rubygems 2.7 with ruby 2.5 and frozen string literals
  export RUBYOPT="--enable-frozen-string-literal --debug=frozen-string-literal"
fi

bundle exec rake test
bundle exec rake test_pure
