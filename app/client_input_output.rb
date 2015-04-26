module ClientInputOutput
  def ask(message)
    print message
    yield if block_given?
  end

  def user_input
    $stdin.gets.chomp
  end

  def tell(message)
    puts message
  end

  def exit_application(message)
    tell "Error: #{message}"
    user_input and abort
  end
end
