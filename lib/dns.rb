
def set_record(dynect_object, record_type, dns_zone, fqdn, value)
  # First, see if the record exists or not:
  zone = dynect_object.zones.get(dns_zone)
  record = zone.records.find{|r| r.name == fqdn}
  datatype = ""
  if record_type == "CNAME"
    datatype = 'cname'
  elsif record_type == "A"
    datatype = 'address'
  else
    raise("Unknown record type")
  end
  if record.nil?
    puts "No old record, creating clean"
    # Record doesn't exist, create:
    # We only handle a records and cnames here:
    dynect_object.post_record( record_type, dns_zone, fqdn, {datatype => value, :ttl => 30})
  else
    puts "Deleting old record"
    # Fog can't do put requests against dynect yet, so we have to delete
    # the record, then create a new one.
    dynect_object.delete_record( record_type, dns_zone, fqdn, record.id)
    puts "Creating new record"
    dynect_object.post_record( record_type, dns_zone, fqdn, {datatype => value, :ttl => 30})
  end
  zone.publish()
end

def set_cname(dynect_object, zone, fqdn, value)
  set_record(dynect_object, "CNAME", zone, fqdn, value)
end