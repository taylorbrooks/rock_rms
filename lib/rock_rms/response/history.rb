module RockRMS
  module Response
    class History < Base
      MAP = {
        id: 'Id',
        verb: 'Verb',
        change_type: 'ChangeType',
        value_name: 'ValueName',
        old_value: 'OldValue',
        new_value: 'NewValue',
        alias_id: 'CreatedByPersonAliasId'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end
