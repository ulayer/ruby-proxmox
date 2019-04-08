module Qemu
     # Current Qemu VM
     def qemu_current(vmid)
        http_action_get("nodes/#{@node}/qemu/#{vmid}/status/current")
      end
  
      # Start Qemu VM
      def qemu_start(vmid)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/status/start")
      end
  
      # Stop Qemu VM
      def qemu_stop(vmid)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/status/stop")
      end
  
      # Resume Qemu VM
      def qemu_resume(vmid)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/status/resume")
      end
  
      # Suspend Qemu VM
      def qemu_suspend(vmid)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/status/suspend")
      end
  
      # Shutdown Qemu VM
      def qemu_shutdown(vmid)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/status/shutdown")
      end
  
      # Reset Qemu VM
      def qemu_reset(vmid)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/status/reset")
      end
  
  
      def qemu_agent_exec(vmid, data)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/agent/exec", data)
      end
  
      def qemu_agent_exec_status(vmid, pid)
        http_action_get("nodes/#{@node}/qemu/#{vmid}/agent/exec-status?pid=#{pid}")
      end
  
      def qemu_agent_file_read(vmid, file)
        http_action_get("nodes/#{@node}/qemu/#{vmid}/agent/file-read?file=#{file}")
      end
  
      def qemu_agent_file_write(vmid, file, content)
        data = {
          file: file,
          content: content,
        }
        http_action_post("nodes/#{@node}/qemu/#{vmid}/agent/file-write", data)
      end
  
      def qemu_agent_fsfreeze_status(vmid)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/agent/fsfreeze-status")
      end
  
      def qemu_agent_fsfreeze_freeze(vmid)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/agent/fsfreeze-freeze")
      end
  
      def qemu_agent_fsfreeze_thaw(vmid)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/agent/fsfreeze-thaw")
      end
  
      def qemu_agent_fstrim(vmid)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/agent/fstrim")
      end
  
      def qemu_agent_get_fsinfo(vmid)
        http_action_get("nodes/#{@node}/qemu/#{vmid}/agent/get-fsinfo")
      end
  
      def qemu_agent_get_host_name(vmid)
        http_action_get("nodes/#{@node}/qemu/#{vmid}/agent/get-host-name")
      end
  
      def qemu_agent_get_memory_block_info(vmid)
        http_action_get("nodes/#{@node}/qemu/#{vmid}/agent/get-memory-block-info")
      end
  
      def qemu_agent_get_memory_blocks(vmid)
        http_action_get("nodes/#{@node}/qemu/#{vmid}/agent/get-memory-blocks")
      end
  
      def qemu_agent_get_osinfo(vmid)
        http_action_get("nodes/#{@node}/qemu/#{vmid}/agent/get-osinfo")
      end
  
      def qemu_agent_get_time(vmid)
        http_action_get("nodes/#{@node}/qemu/#{vmid}/agent/get-time")
      end
  
      def qemu_agent_get_timezone(vmid)
        http_action_get("nodes/#{@node}/qemu/#{vmid}/agent/get-timezone")
      end
  
      def qemu_agent_get_users(vmid)
        http_action_get("nodes/#{@node}/qemu/#{vmid}/agent/get-users")
      end
  
      def qemu_agent_get_vcpus(vmid)
        http_action_get("nodes/#{@node}/qemu/#{vmid}/agent/get-vcpus")
      end
  
      def qemu_agent_info(vmid)
        http_action_get("nodes/#{@node}/qemu/#{vmid}/agent/info")
      end
  
      def qemu_agent_network_get_interfaces(vmid)
        http_action_get("nodes/#{@node}/qemu/#{vmid}/agent/network-get-interfaces")
      end
  
      def qemu_agent_ping(vmid)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/agent/ping")
      end
  
      def qemu_agent_set_user_password(vmid, username, password, crypt=0)
        data = {
          username: username,
          password: password,
        }
        http_action_post("nodes/#{@node}/qemu/#{vmid}/agent/set-user-password", data)
      end
  
      def qemu_agent_shutdown(vmid)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/status/shutdown")
      end
  
      def qemu_agent_suspend_disk(vmid)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/status/suspend-disk")
      end
  
      def qemu_agent_suspend_hybrid(vmid)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/status/suspend-hybrid")
      end
  
      def qemu_agent_suspend_ram(vmid)
        http_action_post("nodes/#{@node}/qemu/#{vmid}/status/suspend-ram")
      end
end