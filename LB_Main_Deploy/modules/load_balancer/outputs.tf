output "lb_id" {
  description = "The ID of the Load Balancer."
  value       = azurerm_lb.internal_lb.id
}

output "lb_name" {
  description = "The name of the Load Balancer."
  value       = azurerm_lb.internal_lb.name
}