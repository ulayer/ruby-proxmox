# encoding: utf-8

require 'proxmox/version'
require 'rest_client'
require 'json'

require './proxmox/openvz'
require './proxmox/qemu'

# This module encapsulates ability to manage Proxmox server
module Proxmox
  # Object to manage Proxmox server
  class Proxmox
    include Openvz
    include Qemu


    # Return connection status
    # - connected
    # - error
    attr_reader :connection_status

    # Create a object to manage a Proxmox server through API
    #
    # :call-seq:
    #   new(pve_cluster, node, username, password, realm, ssl_options) -> Proxmox
    #
    # Example:
    #
    #   Proxmox::Proxmox.new('https://the-proxmox-server:8006/api2/json/', 'node', 'root', 'secret', 'pam', {verify_ssl: false})
    #
    def initialize(pve_cluster, node, username, password, realm, ssl_options = {})
      @pve_cluster = pve_cluster
      @node = node
      @username = username
      @password = password
      @realm = realm
      @ssl_options = ssl_options
      @connection_status = 'error'
      @site = RestClient::Resource.new(@pve_cluster, @ssl_options)
      @auth_params = create_ticket
    end

    def get(path, args = {})
      http_action_get(path, args)
    end

    def post(path, args = {})
      http_action_post(path, args)
    end

    def put(path, args = {})
      http_action_put(path, args)
    end

    def delete(path)
      http_action_delete(path)
    end

    # Get task status
    #
    # :call-seq:
    #   task_status(task-id) -> String
    #
    # - taksstatus
    # - taskstatus:exitstatus
    #
    # Example:
    #
    #   taskstatus 'UPID:localhost:00051DA0:119EAABC:521CCB19:vzcreate:203:root@pam:'
    #
    # Examples return:
    #   - running
    #   - stopped:OK
    #
    def task_status(upid)
      data = http_action_get "nodes/#{@node}/tasks/#{URI.encode upid}/status"
      status = data['status']
      exitstatus = data['exitstatus']
      if exitstatus
        "#{status}:#{exitstatus}"
      else
        "#{status}"
      end
    end
    
    private

    # Methods manages auth
    def create_ticket
      post_param = { username: @username, realm: @realm, password: @password }
      @site['access/ticket'].post post_param do |response, _request, _result, &_block|
        if response.code == 200
          extract_ticket response
        else
          @connection_status = 'error'
        end
      end
    end

    # Method create ticket
    def extract_ticket(response)
      data = JSON.parse(response.body)
      ticket = data['data']['ticket']
      csrf_prevention_token = data['data']['CSRFPreventionToken']
      unless ticket.nil?
        token = 'PVEAuthCookie=' + ticket.gsub!(/:/, '%3A').gsub!(/=/, '%3D')
      end
      @connection_status = 'connected'
      {
        CSRFPreventionToken: csrf_prevention_token,
        cookie: token
      }
    end

    # Extract data or return error
    def check_response(response)
      if response.code == 200
        JSON.parse(response.body)['data']
      else
        'NOK: error code = ' + response.code.to_s
      end
    end

    # Methods manage http dialogs
    def http_action_post(url, data = {})
      @site[url].post data, @auth_params do |response, _request, _result, &_block|
        check_response response
      end
    end

    def http_action_put(url, data = {})
      @site[url].put data, @auth_params do |response, _request, _result, &_block|
        check_response response
      end
    end

    def http_action_get(url, data = {})
      @site[url].get @auth_params.merge(data) do |response, _request, _result, &_block|
        check_response response
      end
    end

    def http_action_delete(url)
      @site[url].delete @auth_params do |response, _request, _result, &_block|
        check_response response
      end
    end
  end
end
