require "./spec_helper"
require "../src/system.cr"
require "socket"

describe Netblog do
  it "#resolve_host returns an ipaddress:port\n" do
    p Netblog.resolve_hostname(System.hostname)
    Netblog.resolve_hostname(System.hostname).to_s.should eq("192.168.33.17:7")
  end

  it "get_ip returns a raw ip address\n" do
    p Netblog.resolve_ip_address
    Netblog.resolve_ip_address.should be_a(String)
  end
end
