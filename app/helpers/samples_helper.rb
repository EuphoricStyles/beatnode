module SamplesHelper
  include ApplicationHelper

  def sample_owned_or_borrowed_timestamp(user, sample)
    if user.borrowing?(sample)
      borrowed_at = SampleBorrow.find_by_sample_id_and_user_id(sample.id, user.id).created_at
      "Grabbed from #{sample.user.username} #{pretty_timestamp(borrowed_at)}"
    elsif user.samples.include?(sample)
      "Uploaded #{pretty_timestamp(sample.created_at)}"
    end
  end
end
