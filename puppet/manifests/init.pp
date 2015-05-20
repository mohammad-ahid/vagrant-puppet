exec { 'apt-get update':
	#command      => '/bin/echo',
	path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
	#refreshonly => true,
}

package { 'vim':
	ensure => present,
}

file { '/var/www':
	ensure => directory,
}

include nginx, php
