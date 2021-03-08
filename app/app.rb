require_relative 'env'

class App < Roda
  plugin :json
  plugin :not_found
  plugin :error_handler

  route do |r|
    r.root {
      R["test"] = "#{rand 100}"
      { hello: "world - #{R["test"]}" }
    }
  end
end
