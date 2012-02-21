#--
# Copyright (c) 2010-2012, Kenneth Kalmer, John Mettraux.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#++


module Ruote
module Amqp

  class Participant
    include Ruote::LocalParticipant

    def initialize(options)

      @options = options
    end

    def on_workitem

      exchange.publish(
        encode_workitem, :routing_key => par_or_opt('routing_key'))

      reply if par_or_opt('forget')
    end

    protected

    def encode_workitem

      workitem.as_json
    end

    def exchange

      con = AMQP.connect(par_or_opt('amqp_connection') || {})
      cha = AMQP::Channel.new(con)

      exn, exo = Array(par_or_opt('exchange')) || [ 'direct/', {} ]
        #
        # defaults to the "default exchange"...

      m = exn.match(/^([a-z]+)\/(.*)$/)

      raise ArgumentError.new(
        "couldn't determine exchange from #{ex.inspect}"
      ) unless m

      AMQP::Exchange.new(cha, m[1].to_sym, m[2], exo || {})
    end

    def par_or_opt(key, default=nil, &default_block)

      @options['static'] ? nil : workitem.params[key] || @options[key]
    end
  end
end
end

