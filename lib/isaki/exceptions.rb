module Isaki
  IsakiError  = Class.new(StandardError)
  LoginFailed = Class.new(IsakiError)
end
