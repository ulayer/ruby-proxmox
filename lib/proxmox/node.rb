# Implements Proxmox API
# https://pve.proxmox.com/pve-docs/api-viewer/index.html
class Node
  attr_reader :cpu,:level, :maxcpu, :maxmem, :mem, :node, :ssl_fingerprint, :status, :uptime, :id, :type, :disk, :maxdisk
  def initialize(**opts)
    @cpu = opts[:cpu]
    @level = opts[:level]
    @maxcpu = opts[:maxcpu]
    @maxmem = opts[:maxmem]
    @mem = opts[:mem]
    @node = opts[:node]
    @ssl_fingerprint = opts[:ssl_fingerprint]
    @status = opts[:status]
    @uptime = opts[:uptime]
    @id = opts[:id]
    @type = opts[:type]
    @disk = opts[:disk]
    @maxdisk = opts[:maxdisk]
  end

  def ==(other_object)
    if (other_object.class.equal? self.class)
      other_object.node == self.node
    else
      false
    end
  end

  def to_s
    return "cpu = #{cpu} level = #{level} maxcpu = #{maxcpu} maxmem = #{maxmem} mem = #{mem} node = #{node} ssl_fingerprint = #{ssl_fingerprint} status = #{status} uptime = #{uptime} id = #{id} type = #{type} disk = #{disk} maxdisk = #{maxdisk}"
  end

  def self.factory_from_json(json_data)
    Node.new(cpu: json_data['cpu'],
             level: json_data['level'],
             maxcpu: json_data['maxcpu'],
             maxmem: json_data['maxmem'],
             mem: json_data['mem'],
             node: json_data['node'],
             ssl_fingerprint: json_data['ssl_fingerprint'],
             status: json_data['status'],
             uptime: json_data['uptime'],
             id: json_data['id'],
             type: json_data['type'],
             disk: json_data['disk'],
             maxdisk: json_data['maxdisk'],)
  end
end