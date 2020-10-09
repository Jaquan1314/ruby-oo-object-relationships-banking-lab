class Transfer
  attr_accessor :sender, :receiver, :status, :amount
  def initialize(sender, receiver, status="pending", amount)
    @sender = sender
    @receiver = receiver
    @status = status
    @amount = amount
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if  @status == "pending" && sender.balance > amount && valid?
      sender.balance -= amount
      receiver.balance += amount
      @status = "complete"
    elsif sender.balance < amount || !valid?
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
      # elsif status = "closed"
      #   @status = 'rejected'
    end
  end

  def reverse_transfer
    if @status == "complete"
      receiver.balance -= amount
      sender.balance += amount
      @status = "reversed"
    end
  end
end