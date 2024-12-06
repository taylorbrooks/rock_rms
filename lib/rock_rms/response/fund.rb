module RockRMS
  module Response
    class Fund < Base
      MAP = {
        campus_id: 'CampusId',
        name: 'Name',
        public_name: 'PublicName',
        description: 'Description',
        is_active: 'IsActive',
        is_public: 'IsPublic',
        is_tax_deductible: 'IsTaxDeductible',
        gl_code: 'GlCode',
        foreign_id: 'ForeignId'
      }.freeze

      def format_single(data)
        to_h(MAP, data)
      end
    end
  end
end
