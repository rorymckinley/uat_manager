module RSpec
  module Mocks
    module Methods
      def should_receive(sym, opts={}, &block)
        __mock_proxy.add_message_expectation(opts[:expected_from] || caller(1)[0], sym.to_sym, opts, &block)
      end

      def should_not_receive(sym, &block)
        __mock_proxy.add_negative_message_expectation(caller(1)[0], sym.to_sym, &block)
      end
      
      def stub(sym_or_hash, opts={}, &block)
        if Hash === sym_or_hash
          sym_or_hash.each {|method, value| stub!(method).and_return value }
        else
          __mock_proxy.add_stub(caller(1)[0], sym_or_hash.to_sym, opts, &block)
        end
      end
      
      def unstub(sym)
        __mock_proxy.remove_stub(sym)
      end
      
      alias_method :stub!, :stub
      alias_method :unstub!, :unstub
      
      # :call-seq:
      #   double.stub_chain("foo.bar") { :baz }
      #   double.stub_chain(:foo, :bar) { :baz }
      #
      # Stubs a chain of methods. Especially useful with fluent and/or
      # composable interfaces.
      #
      # == Examples
      #
      #   Article.stub_chain("recent.published") { [Article.new] }
      def stub_chain(*chain)
        methods = chain.join('.').split('.')
        if methods.length > 1
          if matching_stub = __mock_proxy.__send__(:find_matching_method_stub, methods[0].to_sym)
            methods.shift
            matching_stub.invoke.stub_chain(*methods)
          else
            next_in_chain = Object.new
            stub(methods.shift) { next_in_chain }
            next_in_chain.stub_chain(*methods)
          end
        else
          stub(methods.shift)
        end
      end
      
      def received_message?(sym, *args, &block) #:nodoc:
        __mock_proxy.received_message?(sym.to_sym, *args, &block)
      end
      
      def rspec_verify #:nodoc:
        __mock_proxy.verify
      end

      def rspec_reset #:nodoc:
        __mock_proxy.reset
      end
      
      def as_null_object
        __mock_proxy.as_null_object
      end
      
      def null_object?
        __mock_proxy.null_object?
      end

    private

      def __mock_proxy
        if Mock === self
          @mock_proxy ||= Proxy.new(self, @name, @options)
        else
          @mock_proxy ||= Proxy.new(self)
        end
      end
    end
  end
end
