module RockRMS
  class Client
    module Batch
      def list_batches(options = {})
        res = get(batches_path, options)
        Response::Batch.format(res)
      end

      def find_batch(id)
        res = get(batches_path(id))
        Response::Batch.format(res)
      end

      def create_batch(
        name:,
        start_time:,
        end_time:,
        foreign_key: nil,
        campus_id: nil,
        status: 1,
        control_amount: nil,
        control_count: nil
      )
        options = {
          'Name' => name,
          'BatchStartDateTime' => start_time,
          'CampusId' => campus_id,
          'BatchEndDateTime' => end_time,
          'ForeignKey' => foreign_key,
          'Status' => status,
          'ControlAmount' => control_amount,
          'ControlItemCount' => control_count
        }

        post(batches_path, options)
      end

      def update_batch(id, options = {})
        options = options.collect { |k, v| [k.to_s, v] }.to_h
        patch(batches_path(id), options)
      end

      def delete_batch(id)
        delete(batches_path(id))
      end

      private

      def batches_path(id = nil)
        id ? "FinancialBatches/#{id}" : 'FinancialBatches'
      end
    end
  end
end
