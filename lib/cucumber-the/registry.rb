module Cucumber
  module The
    class Registry
      def []=(name, value)
        thread_registry[name] = value
      end

      def [](name)
        thread_registry[name]
      end

      private
      def thread_registry
        Thread.current[:the_registry] ||= {}
      end
    end
  end
end
