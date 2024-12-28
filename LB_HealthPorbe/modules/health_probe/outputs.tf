output "probe_ids" {
  value = [for probe in azurerm_lb_probe.probe : probe.id]
  description = "The IDs of the created health probes"
}