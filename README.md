# Json Exporter
![GitHub code size in bytes](https://img.shields.io/github/repo-size/UstyuzhaninAV/json_exporter)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/UstyuzhaninAV/json_exporter)
![.github/workflows/main.yml](https://github.com/UstyuzhaninAV/json_exporter/workflows/.github/workflows/main.yml/badge.svg?branch=master)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/ustiuzhanin/json_exporter)

This Prometheus exporter operates similar to the Blackbox exporters. It downloads a JSON file and provides a numerical gauge value from within that file.
Which value to pick is defined through JsonPath.

## Parameters

 - `target`: URL / Json-file to download
 - `jsonpath`: the field name to read the value from, this follows the syntax provided by [oliveagle/jsonpath](https://github.com/oliveagle/jsonpath)

## Docker usage

    docker build -t json_exporter .
    docker -d -p 9116:9116 --name json_exporter json_exporter

The related metrics can then be found under:

    http://localhost:9116/probe?target=http://validate.jsontest.com/?json=%7B%22key%22:%22value%22%7D&jsonpath=$.parse_time_nanoseconds

## Prometheus Configuration

The json exporter needs to be passed the target and the json as a parameter, this can be
done with relabelling.

Example config:
```yml
scrape_configs:
  - job_name: 'json'
    metrics_path: /probe
    params:
      jsonpath: [$.parse_time_nanoseconds] # Look for the nanoseconds field
    static_configs:
      - targets:
        - http://validate.jsontest.com/?json=%7B%22key%22:%22value%22%7D
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 127.0.0.1:9116  # Json exporter.
    metric_relabel_configs:
      - source_labels: value
        target_label: parse_time

```

## License

MIT License
