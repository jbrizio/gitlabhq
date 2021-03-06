# frozen_string_literal: true

require 'io/console'

module LiveDebugger
  def live_debug
    puts
    puts "Current example is paused for live debugging."
    puts "Opening #{current_url} in your default browser..."
    puts "The current user credentials are: #{@current_user.username} / #{@current_user.password}" if @current_user
    puts "Press any key to resume the execution of the example!!"

    `open #{current_url}`

    loop until $stdin.getch

    puts "Back to the example!"
  end
end
