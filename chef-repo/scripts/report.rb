require 'google_spreadsheet'

def time_difference_in_hms(unix_time)
  now = Time.now.to_i
  difference = now - unix_time.to_i
  hours = (difference / 3600).to_i
  difference = difference % 3600
  minutes = (difference / 60).to_i
  seconds = (difference % 60)
  return [hours, minutes, seconds]
end

def put_headers object,list
  cnt = 1
  list.each do |title|
   object[1,cnt] = title
   cnt +=1
  end
end

abort("usage: knife exec report  QUERY") unless ARGV[2]

q = Chef::Search::Query.new
nodes = q.search(:node, ARGV[2])[0]

session = GoogleSpreadsheet.login ENV["GOOGLE_EMAIL"], ENV["GOOGLE_PASSWORD"]
sheet = session.create_spreadsheet "Node Report #{Time.now.strftime "%Y%m%d"}"

ws = sheet.worksheets.first
ws.title=("Base Info")

put_headers(ws,["Name","IP Address","Run List","Recipes","Up Time","Ohai Time","Provider"])

i = 1
nodes.each do |node|
  i += 1
  ws[i,1] = node.name
  ws[i,2] = node.cloud.public_ips
  ws[i,3] = node.run_list.to_s
  ws[i,4] = ( node.node.run_list.expand.recipes * " " )
  ws[i,5] = node.uptime
  hours, minutes, seconds = time_difference_in_hms(node["ohai_time"])
  hours_text   = "#{hours} hour#{hours == 1 ? ' ' : 's'}"
  minutes_text = "#{minutes} minute#{minutes == 1 ? ' ' : 's'}"
  if hours > 24
      text = hours_text
    elsif hours >= 1
      text = hours_text
    else
      text = minutes_text
  end
  ws[i,6] = text
  ws[i,7] = node.cloud.provider
end

ws.save

ws2 = sheet.add_worksheet "EC2 Info" 

put_headers(ws2,["Name","Public Hostname","Availability Zone","Instance Id","Instance Type","Public IP","Local IP","AMI Id","Security Groups"])

i = 1
nodes.each do |node|
  if node.cloud.provider == "ec2" 
    i +=1    
    ws2[i,1] = node.name
    ws2[i,2] = node.ec2.public_hostname
    ws2[i,3] = node.ec2.placement_availability_zone
    ws2[i,4] = node.ec2.instance_id
    ws2[i,5] = node.ec2.instance_type
    ws2[i,6] = node.ec2.public_ipv4
    ws2[i,7] = node.ec2.local_ipv4
    ws2[i,8] = node.ec2.ami_id
    ws2[i,9] =(  node.ec2.security_groups * "," )
  end
end

ws2.save

ws3 = sheet.add_worksheet "Rackspace  Info" 

put_headers(ws3,["Name","Public Hostname","Public IP","Local IP"])

i = 1
nodes.each do |node|
  if node.cloud.provider == "rackspace" 
    i +=1    
    ws3[i,1] = node.name
    ws3[i,2] = node.fqdn
    ws3[i,3] = node.rackspace.public_ip
    ws3[i,4] = node.rackspace.private_ip
  end
end

ws3.save

ws4 = sheet.add_worksheet "System Info" 

put_headers(ws4,["Name","Machine","OS","Version","Release","Platform Version","Memory Total","Memory Free","Buffers","Cached"])

i = 1
nodes.each do |node|
    i +=1    
    ws4[i,1] = node.name
    ws4[i,2] = node.kernel.machine
    ws4[i,3] = node.kernel.name
    ws4[i,4] = node.kernel.os
    ws4[i,5] = node.kernel.version
    ws4[i,6] = node.kernel.release
    ws4[i,7] = node.platform_version
    ws4[i,8] = node.memory.total
    ws4[i,9] = node.memory.free
    ws4[i,10] = node.memory.buffers
    ws4[i,11] = node.memory.cached
end

ws4.save

exit 0
