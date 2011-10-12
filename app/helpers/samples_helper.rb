module SamplesHelper
  def sample_name_for(sample)
    sample.name.blank? ? File.basename(sample.audio.url) : sample.name
  end

  def sample_description_for(sample)
    sample.description.blank? ? "No description added yet." : sample.description
  end
end
