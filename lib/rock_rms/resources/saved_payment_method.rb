module RockRMS
  class Client
    module SavedPaymentMethod
      def list_saved_payment_methods(options = {})
        res = get(saved_payment_method_path, options)
        Response::SavedPaymentMethod.format(res)
      end

      def create_saved_payment_method(
        gateway_id:,
        gateway_person_id: nil,
        payment_detail_id:,
        person_alias_id:,
        name:,
        reference_number:
      )
        options = {
          'FinancialGatewayId'       => gateway_id,
          'FinancialPaymentDetailId' => payment_detail_id,
          'Name'                     => name,
          'PersonAliasId'            => person_alias_id,
          'ReferenceNumber'          => reference_number
        }

        if gateway_person_id
          options['GatewayPersonIdentifier'] = gateway_person_id
        end

        post(saved_payment_method_path, options)
      end

      def update_saved_payment_method(
        id,
        gateway_id: nil,
        gateway_person_id: nil,
        payment_detail_id: nil,
        person_alias_id: nil,
        name: nil,
        reference_number: nil
      )
        options = {}

        options['FinancialGatewayId']       = gateway_id        if gateway_id
        options['GatewayPersonIdentifier']  = gateway_person_id if gateway_person_id
        options['FinancialPaymentDetailId'] = payment_detail_id if payment_detail_id
        options['Name']                     = name              if name
        options['PersonAliasId']            = person_alias_id   if person_alias_id
        options['ReferenceNumber']          = reference_number  if reference_number

        patch(saved_payment_method_path(id), options)
      end

      def delete_saved_payment_method(id)
        delete(saved_payment_method_path(id))
      end

      private

      def saved_payment_method_path(id = nil)
        id ? "FinancialPersonSavedAccounts/#{id}" : 'FinancialPersonSavedAccounts'
      end
    end
  end
end
