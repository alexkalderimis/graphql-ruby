# frozen_string_literal: true

module GraphQL
  class Dataloader
    class Source
      # Called by {Dataloader} to prepare the {Source}'s internal state
      # @api private
      def setup(dataloader)
        @pending_keys = []
        @results = {}
        @dataloader = dataloader
      end

      attr_reader :dataloader

      # @return [Dataloader::Request] a pending request for a value from `key`. Call `.load` on that object to wait for the result.
      def request(key)
        if !@results.key?(key)
          @pending_keys << key
        end
        Dataloader::Request.new(self, key)
      end

      # @return [Dataloader::Request] a pending request for a values from `keys`. Call `.load` on that object to wait for the results.
      def request_all(keys)
        pending_keys = keys.select { |k| !@results.key?(k) }
        @pending_keys.concat(pending_keys)
        Dataloader::RequestAll.new(self, keys)
      end

      # @param key [Object] A loading key which will be passed to {#fetch} if it isn't already in the internal cache.
      # @return [Object] The result from {#fetch} for `key`. If `key` hasn't been loaded yet, the Fiber will yield until it's loaded.
      def load(key)
        if @results.key?(key)
          result_for(key)
        else
          @pending_keys << key
          sync
          result_for(key)
        end
      end

      # @param keys [Array<Object>] Loading keys which will be passed to `#fetch` (or read from the internal cache).
      # @return [Object] The result from {#fetch} for `keys`. If `keys` haven't been loaded yet, the Fiber will yield until they're loaded.
      def load_all(keys)
        if keys.any? { |k| !@results.key?(k) }
          pending_keys = keys.select { |k| !@results.key?(k) }
          @pending_keys.concat(pending_keys)
          sync
        end

        keys.map { |k| result_for(k) }
      end

      # Subclasses must implement this method to return a value for each of `keys`
      # @param keys [Array<Object>] keys passed to {#load}, {#load_all}, {#request}, or {#request_all}
      # @return [Array<Object>] A loaded value for each of `keys`. The array must match one-for-one to the list of `keys`.
      def fetch(keys)
        # somehow retrieve these from the backend
        raise "Implement `#{self.class}#fetch(#{keys.inspect}) to return a record for each of the keys"
      end

      # Wait for a batch, if there's anything to batch.
      # Then run the batch and update the cache.
      # @return [void]
      def sync
        @dataloader.yield
      end

      # @return [Boolean] True if this source has any pending requests for data.
      def pending?
        @pending_keys.any?
      end

      # Called by {GraphQL::Dataloader} to resolve and pending requests to this source.
      # @api private
      # @return [void]
      def run_pending_keys
        return if @pending_keys.empty?
        fetch_keys = @pending_keys.uniq
        @pending_keys = []
        results = fetch(fetch_keys)
        fetch_keys.each_with_index do |key, idx|
          @results[key] = results[idx]
        end
      rescue StandardError => error
        fetch_keys.each { |key| @results[key] = error }
      ensure
        nil
      end

      # These arguments are given to `dataloader.with(source_class, ...)`. The object
      # returned from this method is used to de-duplicate batch loads under the hood
      # by using it as a Hash key.
      #
      # By default, the arguments are all put in an Array. To customize how this source's
      # batches are merged, override this method to return something else.
      #
      # For example, if you pass `ActiveRecord::Relation`s to `.with(...)`, you could override
      # this method to call `.to_sql` on them, thus merging `.load(...)` calls when they apply
      # to equivalent relations.
      #
      # @param batch_args [Array<Object>]
      # @param batch_kwargs [Hash]
      # @return [Object]
      def self.batch_key_for(*batch_args, **batch_kwargs)
        [*batch_args, **batch_kwargs]
      end

      attr_reader :pending_keys

      private

      # Reads and returns the result for the key from the internal cache, or raises an error if the result was an error
      # @param key [Object] key passed to {#load} or {#load_all}
      # @return [Object] The result from {#fetch} for `key`.
      # @api private
      def result_for(key)
        result = @results[key]

        raise result if result.class <= StandardError

        result
      end
    end
  end
end
