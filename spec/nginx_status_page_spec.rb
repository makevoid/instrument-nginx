require_relative 'spec_helper'

describe("Instrumented Nginx") {

  it("haz status page") {
    resp = Excon.get "http://localhost/health"
    resp.body.should == { "status" => "OK"  }.to_json
  }

  # specify("status page enabled") { # better spec name :)
  #   # ...
  # }

}
