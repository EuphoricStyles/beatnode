module SamplesHelper
  def sample_owned_or_borrowed_timestamp(sample)
    if current_user.borrowing?(sample)
      borrowed_at = SampleBorrow.find_by_sample_id_and_user_id(sample.id, current_user.id).updated_at
      return "Grabbed from #{sample.user.username} #{pretty_timestamp(borrowed_at)}"
    elsif current_user.samples.include?(sample)
      action = "Uploaded by you #{pretty_timestamp(sample.updated_at)}"
    end
  end
end
