class ErrorSerializer
  def self.format(message, status = 400)
    {
      errors: [
        {
          status: status.to_s,
          detail: message
        }
      ]
    }
  end
end
