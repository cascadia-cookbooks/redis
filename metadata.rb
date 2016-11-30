name 'cop_redis'
maintainer 'Copious Inc.'
maintainer_email 'engineering@copiousinc.com'
license 'MIT'
description 'Installs and configures Redis.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.2'

source_url 'https://github.com/copious-cookbooks/redis'
issues_url 'https://github.com/copious-cookbooks/redis/issues'

supports 'ubuntu', '>= 14.04'
supports 'debian', '>= 8.0'
supports 'fedora', '>= 19'
supports 'rhel', '>= 7.0'

depends 'apt'
