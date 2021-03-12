require_relative 'spec_helper'

describe("Instrumented Nginx") {

  specify("status page enabled") {
    check = healthcheck
    check.should == { "status" => "OK"  }.to_json

    resp = status
    requests_info = resp.split("\n")[2]

    resp.should =~ /^Active connections/
    requests_info.should =~ three_digits
    stat_1 = requests_info.match three_digits
    stat_1 = stat_1[3]

    healthcheck

    resp = status
    requests_info = resp.split("\n")[2]

    stat_2 = requests_info.match three_digits
    stat_2 = stat_2[3]

    stat_2.to_i.should == stat_1.to_i + 2
  }

  specify("websocket app gets proxied") {
    data = "test"

    url = "ws://localhost:81"

    on_close = -> (close_code, _) {
      close_code.should == 1000
    }

    resp = status
    requests_info = resp.split("\n")[2]
    stat_1 = requests_info.match three_digits
    stat_1 = stat_1[3]

    Kontena::Websocket::Client.connect(url) do |client|
      client.send data
      client.close 1000

      client.read do |message|
        message.should == "-> TEST"
        # sleep 10
      end

      on_close.(client.close_code, client.close_reason)
    end

    resp = status
    requests_info = resp.split("\n")[2]
    stat_2 = requests_info.match three_digits
    stat_2 = stat_2[3]

    stat_2.to_i.should == stat_1.to_i + 2
  }

}
