exec {"apt-update":
  command => "/usr/bin/apt-get update"
}
package { ["default-jre", "tomcat8"]:
    ensure => installed,
    require => Exec["apt-update"]
}
service { "tomcat8":
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => Package["tomcat8"]    
}
file { "/var/lib/tomcat8/webapps/vraptor-musicjungle.war":
    source => "/vagrant/manifests/vraptor-musicjungle.war",
    owner => "tomcat8",
    group => "tomcat8",
    mode => 0644,
    require => Package["tomcat8"],
    notify => Service["tomcat8"]
}
