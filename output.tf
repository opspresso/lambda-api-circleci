# output

output "url" {
  value = "https://${module.dev-lambda.domain}/webhook"
}
