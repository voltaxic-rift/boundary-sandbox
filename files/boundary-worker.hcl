listener "tcp" {
  purpose = "proxy"
  tls_disable = true
}

worker {
  # Name attr must be unique across workers
  name = "boundary-worker"
  description = "A default worker created demonstration"
  address = 127.0.0.1

  # Workers must be able to reach controllers on :9202
  controllers = [
    "127.0.0.1"
  ]

  public_addr = "192.168.33.10"
}

# must be same key as used on controller config
kms "aead" {
  purpose = "worker-auth"
  aead_type = "aes-gcm"
  key = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
  key_id = "global_worker-auth"
}