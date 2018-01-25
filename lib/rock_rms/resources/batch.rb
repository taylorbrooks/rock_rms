module RockRMS
  class Client
    module Batch
      def list_batches(options = {})
        get(batches_path, options)
      end

      def find_batch(id)
        get(batches_path(id))
      end

      def create_batch(name:, start_time:, end_time:, foreign_key: nil)
        options = {
          'Name' => name,
          'BatchStartDateTime' => start_time,
          'BatchEndDateTime' => end_time,
          'ForeignKey' => foreign_key
        }

        post(batches_path, options)
      end

      def update_batch(id, options = {})
        options = options.collect{|k,v| [k.to_s, v]}.to_h
        patch(batches_path(id), options)
      end

      private

      def batches_path(id = nil)
        id ? "FinancialBatches/#{id}" : 'FinancialBatches'
      end
    end
  end
end
