module RockRMS
  module Response
    class Base
      attr_reader :data

      BASE_MAPPING = {
        id: 'Id',
        guid: 'Guid',
        created_date_time: 'CreatedDateTime',
        modified_date_time: 'ModifiedDateTime',
        created_by_person_alias_id: 'CreatedByPersonAliasId',
        attributes: 'Attributes',
        attribute_values: 'AttributeValues'
      }.freeze

      def self.format(data)
        new(data).format
      end

      def initialize(data)
        @data = data
      end

      def format
        if data.is_a?(Array)
          data.map { |item| format_single(item) }
        else
          format_single(data)
        end
      end

      def to_h(dict, data)
        return {} if data.nil?

        dict
          .merge(BASE_MAPPING)
          .each_with_object({}) do |(l, r), object|
            if l == :attributes || l == :attribute_values
              format_klass = l == :attributes ? Attribute : AttributeValue
              object[l] = format_attributes(data[r], format_klass)
            else
              object[l] = data[r]
            end
          end
      end

      def format_attributes(res, klass)
        return res if res.nil?

        res.each_with_object({}) do |(attr, val), object|
          object[attr] = klass.format(val)
        end
      end
    end
  end
end
