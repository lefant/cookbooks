# install the management / monitoring web console

execute "rabbitmq-plugins enable rabbitmq_management" do
  not_if "rabbitmq-plugins list rabbitmq_management|grep '\\[E\\] rabbitmq_management'"
  notifies :restart, resources(:service => "rabbitmq-server")
end

rabbitmq_user "guest" do
  tag "monitoring"
  action :set_tag
end
