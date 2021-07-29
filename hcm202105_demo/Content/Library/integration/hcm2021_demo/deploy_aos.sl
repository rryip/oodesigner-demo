namespace: integration.hcm2021_demo
flow:
  name: deploy_aos
  inputs:
    - target_host: 172.16.239.129
    - target_host_username: root
    - target_host_password:
        default: Cloud_1234
        sensitive: true
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 252.89236450195312
        'y': 84.44444274902344
      install_java:
        x: 397
        'y': 89
      install_tomcat:
        x: 554
        'y': 88
      install_aos_application:
        x: 738.892333984375
        'y': 126.23609924316406
        navigate:
          eba408fd-58f6-75b4-a931-a6994196ee19:
            targetId: e4d33bcc-fc64-5a52-43b7-250b8ad8eb33
            port: SUCCESS
    results:
      SUCCESS:
        e4d33bcc-fc64-5a52-43b7-250b8ad8eb33:
          x: 849.111083984375
          'y': 100.55903625488281
