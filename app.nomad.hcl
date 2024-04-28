// variable "env_var" { type = string}

job "odroidm1application" {

   datacenters = ["dc1"]
   type = "service"

  //  group "notary-front" {
  //   prevent_reschedule_on_lost = true
  //   count = 1
  //   max_client_disconnect      = "12h"
    

  //   reschedule {
  //   attempts  = 0
  //   unlimited = false
  //    }


    
     
 
  //    task "frontend" {
  //        driver = "raw_exec"

  //         config {
  //   # When running a binary that exists on the host, the path must be absolute/
  //   command = "/home/odroid/scripts/run/front.sh"
  //  #args    = ["/home/odroid/scripts/run/front.sh","-flag","1"]
  //   # args = ["1"]
  //        }

  //      constraint {
  //   attribute = "${node.unique.id}"
  //   value     = "8aba09e7-7eba-45c1-92b1-160e3270131b"
  //        }

         
  //   //     resources {
  //   //     cpu    = 100
  //   //     memory = 500
       
  //   //   }
  //     }
    
  // }

 group "notary-back" {
    //  prevent_reschedule_on_lost = true
     count = 1
    //  max_client_disconnect      = "12h"
    

    //   reschedule {
    //   attempts  = 0
    //   unlimited = false
    // }
     

 
     task "backend" {
         driver = "raw_exec"




          config {
    # When running a binary that exists on the host, the path must be absolute/
    command = "/home/odroid/scripts/run/back.sh"
   #args    = ["/home/odroid/scripts/run/front.sh","-flag","1"]
    # args = ["1"]
         }

           env {
               DATABASE_NAME = "postgres"
                POSTGRES_HOST = "192.168.0.171"
                POSTGRES_USER = "postgres"
                POSTGRES_PORT  = 5432
                POSTGRES_PASSWORD="postgres"
                CELERY_BROKER_URL="amqp://guest:guest@192.168.0.145:5672/"

                
            }

       constraint {
    attribute = "${node.unique.id}"
    value     = "8aba09e7-7eba-45c1-92b1-160e3270131b"
         }


//       template {
//                 data        = <<EOH
// {{ range nomadService "db" }}
// DB_CONNECTION="host={{ .Address }} port={{ .Port }} user=user password=password dbname=db_name"
// {{ end }}
// EOH
//                 destination = "local/env.txt"
//                 env         = true
//             }
         
    //     resources {
    //     cpu    = 100
    //     memory = 500
       
    //   }
      }
    
  }


  // group "notary-selinon1" {
  //    prevent_reschedule_on_lost = true
  //    count = 1
  //    max_client_disconnect      = "12h"
     
  //     reschedule {
  //     attempts  = 0
  //     unlimited = false
  //   }
   
 
  //    task "selinon1" {
  //        driver = "raw_exec"

  //         config {
  //   # When running a binary that exists on the host, the path must be absolute/
  //   command = "/home/odroid/scripts/run/selinon1.sh"
  //  #args    = ["/home/odroid/scripts/run/front.sh","-flag","1"]
  //   # args = ["1"]
  //        }

  //                   env {
  //              DATABASE_NAME = "postgres"
  //               POSTGRES_HOST = "192.168.0.145"
  //               POSTGRES_USER = "postgres"
  //               POSTGRES_PORT  = 5432
  //               POSTGRES_PASSWORD="postgres"
  //               CELERY_BROKER_URL="amqp://guest:guest@192.168.0.145:5672/"

                
  //           }


  //      constraint {
  //   attribute = "${node.unique.id}"
  //   value     = "8aba09e7-7eba-45c1-92b1-160e3270131b"
  //        }

         
  //       resources {
  //       cpu    = 100
  //       memory = 500
       
  //     }
  //     }
    
  // }

  

  //  group "notary-selinon0" {
  //     prevent_reschedule_on_lost = true
  //   count = 1
  //    max_client_disconnect      = "12h"
   

  //     reschedule {
  //     attempts  = 0
  //     unlimited = false
  //   }
     
 
  //    task "selinon0" {
  //        driver = "raw_exec"

  //         config {
  //   # When running a binary that exists on the host, the path must be absolute/
  //   command = "/home/odroid/scripts/run/selinon0.sh"
  //  #args    = ["/home/odroid/scripts/run/front.sh","-flag","1"]
  //   # args = ["1"]
  //        }

  //            env {
  //              DATABASE_NAME = "postgres"
  //               POSTGRES_HOST = "192.168.0.145"
  //               POSTGRES_USER = "postgres"
  //               POSTGRES_PORT  = 5432
  //               POSTGRES_PASSWORD="postgres"
  //               CELERY_BROKER_URL="amqp://guest:guest@192.168.0.145:5672/"

                
  //           }

         

  //      constraint {
  //   attribute = "${node.unique.id}"
  //   value     = "8aba09e7-7eba-45c1-92b1-160e3270131b"
  //        }

         
  //   //     resources {
  //   //     cpu    = 100
  //   //     memory = 500
       
  //   //   }
  //     }
    
  // }


  //  group "notary-selinon2" {
  //    prevent_reschedule_on_lost = true
  //    count = 1
  //    max_client_disconnect      = "12h"
     
    

  //     reschedule {
  //     attempts  = 0
  //     unlimited = false
  //   }
    

 
  //    task "selinon2" {
  //        driver = "raw_exec"

  //         config {
  //   # When running a binary that exists on the host, the path must be absolute/
  //   command = "/home/odroid/scripts/run/selinon2.sh"
  //  #args    = ["/home/odroid/scripts/run/front.sh","-flag","1"]
  //   # args = ["1"]
  //        }

  //            env {
  //              DATABASE_NAME = "postgres"
  //               POSTGRES_HOST = "192.168.0.145"
  //               POSTGRES_USER = "postgres"
  //               POSTGRES_PORT  = 5432
  //               POSTGRES_PASSWORD="postgres"
  //               CELERY_BROKER_URL="amqp://guest:guest@192.168.0.145:5672/"

                
  //           }


  //      constraint {
  //   attribute = "${node.unique.id}"
  //   value     = "8aba09e7-7eba-45c1-92b1-160e3270131b"
  //        }

         
  //   //     resources {
  //   //     cpu    = 100
  //   //     memory = 500
       
  //   //   }
  //     }
    
  // }




  //   group "database" {
  //    prevent_reschedule_on_lost = true
  //    count = 1   
  //    max_client_disconnect      = "12h"
     
    

  //   reschedule {
  //     attempts  = 0
  //     unlimited = false
  //   }
  //    network {
  //           mode = "host"
  //           port "db" {
  //               static = 5432   
  //               to     = 5432
  //           }
  //       }

   
  //    volume "postgres" {
  //     type      = "host"
  //     read_only = false
  //     source    = "postgres"
  //   }

  //   task "postgresql" {
  //     driver = "docker"

  //     config {
  //       image        = "postgres"
  //       ports = ["db"]

       
  //     }


  //       service {
  //     name     = "db"
  //     provider = "nomad"
  //     port     = "db"
  //   }    

       
  //      env {
  //   POSTGRES_USER     = "postgres"
  //   POSTGRES_PASSWORD = "postgres"
  //   //  POSTGRES_HOST= "localhost"
  //   // POSTGRES_HOST_AUTH_METHOD= "trust"
  // }

  //      volume_mount {
  //       volume      = "postgres"
  //       destination = "/var/lib/postgresql/data"
  //       read_only   = false
  //   //     // propagation_mode = "" (VolumeMountPropagationPrivate       = "private" 
 	// // VolumeMountPropagationHostToTask    = "host-to-task" 
 	// // VolumeMountPropagationBidirectional = "bidirectional" )

  //     }

  //   //   resources {
  //   //     cpu    = 100
  //   //     memory = 500
  //   //   }
  //   }
  // }



//   group "rabbit-mq" {
//      count = 1


//           network {
//             mode = "host"
//             port "rabbit" {
//                 static = 5672
//                 to     = 5672
//             }
//         }
 
//      task "rabbit" {
//          driver = "docker"   

//             config {
//         image        = "rabbitmq:3-management"
//         ports = ["rabbit"]

       
//       }


//        constraint {
//     attribute = "${node.unique.id}"
//     value     = "8aba09e7-7eba-45c1-92b1-160e3270131b"
//          }

         
//         resources {
//         cpu    = 100
//         memory = 500
       
//       }
//       }
    
//   }


  
//   group "redis-group" {
//     count = 1

//      network {
//             mode = "host"
//             port "redis" {
//                 static = 6379
//                 to     = 6379
//             }
//         }

//     //  volume "redis" {
//     //   type      = "host"
//     //   read_only = false
//     //   source    = "redis"
//     // }    

//     task "redis-task" {
//       driver = "docker"

//       config {
//         image = "redis"
//         // command = "redis-server /usr/local/etc/redis/redis.conf"
//         ports = ["redis"]
//       }

//       resources {
//         cpu    = 100
//         memory = 500
//       }

   
//    constraint {
//     attribute = "${node.unique.id}"
//     value     = "8aba09e7-7eba-45c1-92b1-160e3270131b"
//          }

//     //     volume_mount {
//     //     volume      = "redis"
//     //     destination = "/usr/local/etc/redis/redis.conf"
//     //     read_only   = false
//     // }
//   }




// }
}