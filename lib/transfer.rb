class Transfer
  attr_accessor :status, :amount
  attr_reader :sender, :receiver

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
    @amount_sent = 0
  end

  def valid?
    (sender.status == 'open' && receiver.status == 'open') && (sender.valid? && receiver.valid?)
  end

  def execute_transaction
    if sender.valid? && sender.balance >= @amount
      sender.balance -= @amount
      receiver.balance += @amount
      @status = "complete"
      @amount_sent = @amount
      @amount = 0
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
# binding.pry
    if @status == "complete"
      sender.balance += @amount_sent
      receiver.balance -= @amount_sent
      @amount = 0
      @status = "reversed"
    end
  end


end
