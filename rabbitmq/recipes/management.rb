# install the management / monitoring web console
#
# currently very much hardcoding that we expect version 2.6.1

plugins = %w{
  rabbitmq_management-2.6.1.ez
  rabbitmq_management_agent-2.6.1.ez
  rabbitmq_mochiweb-2.6.1.ez
  mochiweb-1.3-rmq2.6.1-git9a53dbd.ez
  webmachine-1.7.0-rmq2.6.1-hg0c4b60a.ez
  amqp_client-2.6.1.ez
}

plugin_dir = "/usr/lib/rabbitmq/lib/rabbitmq_server-2.6.1/plugins/"
url_prefix = "http://www.rabbitmq.com/releases/plugins/v2.6.1/"
plugins.each do |plugin|
  execute "wget " + url_prefix + plugin do
    cwd plugin_dir
    creates plugin_dir + plugin
    notifies :restart, resources(:service => "rabbitmq-server")
  end
end

rabbitmq_user "guest" do
  tag "monitoring"
  action :set_tag
end
