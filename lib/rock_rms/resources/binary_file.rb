module RockRMS
  class Client
    module BinaryFile
      def upload_binary_file(
        file:,
        mime_type:,
        binary_file_type_id:
      )
        query_string = "BinaryFileTypeId=#{binary_file_type_id}"
        converted_file = Faraday::UploadIO.new(file, mime_type)

        post("BinaryFiles/Upload?#{query_string}", { file: converted_file })
      end
    end
  end
end
