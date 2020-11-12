module RockRMS
  class Client
    module ServiceJob
      def list_service_jobs(options = {})
        res = get('ServiceJobs', options)
        Response::ServiceJob.format(res)
      end

      def update_service_job(id, cron: nil)
        options = {
          'CronExpression': cron
        }

        patch("ServiceJobs/#{id}", options)
      end
    end
  end
end
