# frozen_string_literal: true

module ShowoffApi
  class Response
    attr_reader :code, :message, :data

    def initialize(res)
      @code = (res['code'] == 0) ? :success : :fail
      @message = res['message']
      @data = res['data']
    end
  end
end
