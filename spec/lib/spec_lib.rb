module SpecLib

  def healthcheck
    resp = Excon.get "http://#{HOST_URL}/health"
    resp.body
  end

  def status
    resp = Excon.get "http://#{HOST_URL}/basic_status"
    resp.body
  end

  def three_digits
    /\s+(\d+)\s+(\d+)\s+(\d+)/
  end

end
