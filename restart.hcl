job "restart" {
  datacenters = ["dc1"]
  type        = "batch"

  group "templates" {
    count = 1

    task "pull-templates" {
      driver = "raw_exec"
      config {
    # When running a binary that exists on the host, the path must be absolute/
    command = "/home/odroid/scripts/restart/pull.sh"
   #args    = ["/home/odroid/scripts/run/front.sh","-flag","1"]
    # args = ["1"]
         }

     constraint {
    attribute = "${node.unique.id}"
    value     = "c5d884b5-a6b5-a2c9-feec-37a80f7aba03"
         }

    }
  }
}