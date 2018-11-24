class FileUploader < Shrine
  plugin :logging

  def generate_location(io,context)
    date = verbose_date(Time.now) if context[:record]
    type = context[:record].class.name.downcase if context[:record]
    [type,date,super].compact.join("/")
  end
end