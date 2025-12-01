# DNS Atlantis Test Repository

This is a test repository for validating Atlantis GitOps workflows with DNS changes.

## Quick Start

1. Create a PR that modifies DNS records
2. Atlantis will auto-plan on PR creation
3. Comment `atlantis apply` to apply changes

## Structure

```
dns/
  test_zone/
    test_domain_com/
      dns/
        main.tf          # DNS records
        terragrunt.hcl   # Terragrunt config
```

## Test Scenarios

- Add a new A record
- Add a new CNAME record
- Modify an existing record
- Delete a record
