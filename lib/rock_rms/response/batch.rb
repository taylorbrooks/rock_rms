module RockRMS
  module Response
    class Batch < Base
      MAP = {
        id: 'Id',
        name: 'Name',
        control_amount: 'ControlAmount',
        transactions: 'Transactions',
        start_date: 'BatchStartDateTime',
        end_date: 'BatchEndDateTime',
        campus_id: 'CampusId',
        is_campus: 'Campus',
        status: 'Status',
        foreign_key: 'ForeignKey'
      }.merge(TIMESTAMPS).freeze

      def format_single(data)
        response = to_h(MAP, data)
        response[:transactions] = Transaction.format(response[:transactions])
        response[:amount]       = calculate_total(response[:transactions])
        response[:start_date]   = date_parse(response[:start_date])
        response[:end_date]     = date_parse(response[:end_date])
        response
      end

      def calculate_total(transactions)
        transactions.reduce(0) { |sum, txn| sum + txn[:amount] }
      end

      def date_parse(string)
        if string
          DateTime.parse(string)
        else
          nil
        end
      end
    end
  end
end
