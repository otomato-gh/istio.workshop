# Monitoring with Istio

- All request metrics are directly exported by the Envoy proxy since Istio 1.5. The telemetry component is implemented as a Proxy-wasm plugin. Metrics  are exposed to Prometheus and visualized with Grafana dashboards

.exercise[
- Browse to `istio-service-dashboard` in Grafana

- Create some load by reloading your browser a few times

- Check Grafana for the following metrics:
  
  - Request success rate by source

  - Request duration

]