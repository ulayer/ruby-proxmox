# encoding: utf-8

module Openvz
    # Get template list
    #
    # :call-seq:
    #   templates -> Hash
    #
    # Return a Hash of all templates
    #
    # Example:
    #
    #   templates
    #
    # Example return:
    #
    #   {
    #     'ubuntu-10.04-standard_10.04-4_i386' => {
    #         'format' => 'tgz',
    #         'content' => 'vztmpl',
    #         'volid' => 'local:vztmpl/ubuntu-10.04-standard_10.04-4_i386.tar.gz',
    #         'size' => 142126884
    #     },
    #     'ubuntu-12.04-standard_12.04-1_i386' => {
    #         'format' => 'tgz',
    #         'content' => 'vztmpl',
    #         'volid' => 'local:vztmpl/ubuntu-12.04-standard_12.04-1_i386.tar.gz',
    #          'size' => 130040792
    #     }
    #  }
    #
    def templates
        data = http_action_get "nodes/#{@node}/storage/local/content"
        template_list = {}
        data.each do |ve|
          name = ve['volid'].gsub(%r{local:vztmpl\/(.*).tar.gz}, '\1')
          template_list[name] = ve
        end
        template_list
      end
  
      # Get CT list
      #
      # :call-seq:
      #   openvz_get -> Hash
      #
      # Return a Hash of all openvz container
      #
      # Example:
      #
      #   openvz_get
      #
      # Example return:
      #   {
      #     '101' => {
      #           'maxswap' => 536870912,
      #           'disk' => 405168128,
      #           'ip' => '192.168.1.5',
      #           'status' => 'running',
      #           'netout' => 272,
      #           'maxdisk' => 4294967296,
      #           'maxmem' => 536870912,
      #           'uptime' => 3068073,
      #           'swap' => 0,
      #           'vmid' => '101',
      #           'nproc' => '10',
      #           'diskread' => 0,
      #           'cpu' => 0.00031670581100007,
      #           'netin' => 0,
      #           'name' => 'test2.domain.com',
      #           'failcnt' => 0,
      #           'diskwrite' => 0,
      #           'mem' => 22487040,
      #           'type' => 'openvz',
      #           'cpus' => 1
      #     },
      #     [...]
      #   }
      def openvz_get
        data = http_action_get "nodes/#{@node}/openvz"
        ve_list = {}
        data.each do |ve|
          ve_list[ve['vmid']] = ve
        end
        ve_list
      end
  
      # Create CT container
      #
      # :call-seq:
      #   openvz_post(ostemplate, vmid) -> String
      #   openvz_post(ostemplate, vmid, options) -> String
      #
      # Return a String as task ID
      #
      # Examples:
      #
      #   openvz_post('ubuntu-10.04-standard_10.04-4_i386', 200)
      #   openvz_post('ubuntu-10.04-standard_10.04-4_i386', 200, {'hostname' => 'test.test.com', 'password' => 'testt' })
      #
      # Example return:
      #
      #   UPID:localhost:000BC66A:1279E395:521EFC4E:vzcreate:200:root@pam:
      #
      def openvz_post(ostemplate, vmid, config = {})
        config['vmid'] = vmid
        config['ostemplate'] = "local%3Avztmpl%2F#{ostemplate}.tar.gz"
        vm_definition = config.to_a.map { |v| v.join '=' }.join '&'
  
        http_action_post("nodes/#{@node}/openvz", vm_definition)
      end
  
      # Delete CT
      #
      # :call-seq:
      #   openvz_delete(vmid) -> String
      #
      # Return a string as task ID
      #
      # Example:
      #
      #   openvz_delete(200)
      #
      # Example return:
      #
      #   UPID:localhost:000BC66A:1279E395:521EFC4E:vzdelete:200:root@pam:
      #
      def openvz_delete(vmid)
        http_action_delete "nodes/#{@node}/openvz/#{vmid}"
      end
  
      # Get CT status
      #
      # :call-seq:
      #   openvz_delete(vmid) -> String
      #
      # Return a string as task ID
      #
      # Example:
      #
      #   openvz_delete(200)
      #
      # Example return:
      #
      #   UPID:localhost:000BC66A:1279E395:521EFC4E:vzdelete:200:root@pam:
      #
      def openvz_status(vmid)
        http_action_get "nodes/#{@node}/openvz/#{vmid}/status/current"
      end
  
      # Start CT
      #
      # :call-seq:
      #   openvz_start(vmid) -> String
      #
      # Return a string as task ID
      #
      # Example:
      #
      #   openvz_start(200)
      #
      # Example return:
      #
      #   UPID:localhost:000BC66A:1279E395:521EFC4E:vzstart:200:root@pam:
      #
      def openvz_start(vmid)
        http_action_post "nodes/#{@node}/openvz/#{vmid}/status/start"
      end
  
      # Stop CT
      #
      # :call-seq:
      #   openvz_stop(vmid) -> String
      #
      # Return a string as task ID
      #
      # Example:
      #
      #   openvz_stop(200)
      #
      # Example return:
      #
      #   UPID:localhost:000BC66A:1279E395:521EFC4E:vzstop:200:root@pam:
      #
      def openvz_stop(vmid)
        http_action_post "nodes/#{@node}/openvz/#{vmid}/status/stop"
      end
  
      # Shutdown CT
      #
      # :call-seq:
      #   openvz_shutdown(vmid) -> String
      #
      # Return a string as task ID
      #
      # Example:
      #
      #   openvz_shutdown(200)
      #
      # Example return:
      #
      #   UPID:localhost:000BC66A:1279E395:521EFC4E:vzshutdown:200:root@pam:
      #
      def openvz_shutdown(vmid)
        http_action_post "nodes/#{@node}/openvz/#{vmid}/status/shutdown"
      end
  
      # Get CT config
      #
      # :call-seq:
      #   openvz_config(vmid) -> String
      #
      # Return a string as task ID
      #
      # Example:
      #
      #   openvz_config(200)
      #
      # Example return:
      #
      #   {
      #     'quotaugidlimit' => 0,
      #     'disk' => 0,
      #     'ostemplate' => 'ubuntu-10.04-standard_10.04-4_i386.tar.gz',
      #     'hostname' => 'test.test.com',
      #     'nameserver' => '127.0.0.1 192.168.1.1',
      #     'memory' => 256,
      #     'searchdomain' => 'domain.com',
      #     'onboot' => 0,
      #     'cpuunits' => 1000,
      #     'swap' => 256,
      #     'quotatime' => 0,
      #     'digest' => 'e7e6e21a215af6b9da87a8ecb934956b8983f960',
      #     'cpus' => 1,
      #     'storage' => 'local'
      #   }
      #
      def openvz_config(vmid)
        http_action_get "nodes/#{@node}/openvz/#{vmid}/config"
      end
  
      # Set CT config
      #
      # :call-seq:
      #   openvz_config_set(vmid, parameters) -> Nil
      #
      # Return nil
      #
      # Example:
      #
      #   openvz_config(200, { 'swap' => 2048 })
      #
      # Example return:
      #
      #   nil
      #
      def openvz_config_set(vmid, data)
        http_action_put("nodes/#{@node}/openvz/#{vmid}/config", data)
      end
end