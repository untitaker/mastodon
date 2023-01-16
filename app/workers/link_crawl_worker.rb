# frozen_string_literal: true

class LinkCrawlWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'pull', retry: 0

  def perform(status_id)
    status = Status.find(status_id)
    Sentry.set_tags('mastodon.status.domain': status.account.domain)
    FetchLinkCardService.new.call(status)
  rescue ActiveRecord::RecordNotFound
    true
  end
end
