module Cucumber
  module The
    class Registry
      def []=(name, value)
        thread_registry[name.to_s] = value
      end

      def [](name)
        thread_registry[name.to_s] || raise_error(name)
      end

      def has_key?(name)
        thread_registry.has_key?(name.to_s)
      end

      def clear
        thread_registry.clear
      end

      def method_missing(name, *args)
        key_name = name.to_s
        if key_name.chomp! '='
          self[key_name] = args.first
        else
          self[key_name]
        end
      end

      def responds_to(name, *)
        true
      end

      private
      def thread_registry
        Thread.current[:the_registry] ||= {}
      end

      def raise_error(name, trace = caller(2))
        raise RuntimeError, error_message(name), trace
      end

      def error_message(name)
        formatted_name = name.to_s.gsub('_', ' ')
        %(Don't know what "the #{formatted_name}" is. Did you forget to assign it and/or run a prerequisite step before this step?)
      end
    end
  end
end
