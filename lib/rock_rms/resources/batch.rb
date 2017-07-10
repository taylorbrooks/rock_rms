module RockRMS
  class Client
    module Batch

      def list_batches(options = {})
        res = get(batches_path, options)
      end

      def find_batch(id)
        res = get(batches_path(id))
      end

      def create_batch(options = {})
        options = {
          "Name" => options[:name],
          "BatchStartDateTime" => options[:start_time],
          "BatchEndDateTime" => options[:end_time],
        }
        post(batches_path, options)
      end

      def update_batch(id, options = {})
        patch(batches_path(id), options)
      end

      private

      def batches_path(id = nil)
        id ? "FinancialBatches/#{id}" : "FinancialBatches"
      end

    end
  end
end
