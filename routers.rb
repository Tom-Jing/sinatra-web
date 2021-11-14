enable :sessions

not_found do
    erb :err404
end

get '/' do
    @title = "Home"
    erb :home 
end

get '/home' do
    @title = "Home"
    erb :home
end

get '/about' do
    @title = "About"
    erb :about
end

get '/login' do
    if session[:user] == true
        redirect "/gamb"
    else
        @title = "Log in"
        erb :login
    end
end

get '/signup' do
    if session[:user] == true
        redirect "/gamb"
    else
        @title = "Sign up"
        erb :signup
    end
end

get '/logout' do
    if session[:user] != true
        redirect to ('/home')
    else
        user = Player.get(session[:username])
        user.update(:totalWin => user.totalWin + session[:win].to_i, :totalLost => user.totalLost + session[:lose].to_i, 
            :totalProfit => user.totalProfit + session[:profit].to_i)
        @title = "logout"
        session.clear
        erb :logout
    end
end

get '/gamb' do
    if session[:user] != true
        session[:validLogin] = "Please login or sign up first before start game!"
        erb :home
    else
        @title = "Game on"
        erb :gamb
    end
end

post '/logout' do
    user = Player.get(session[:username])
    user.update(:totalWin => user.totalWin + session[:win].to_i, :totalLost => user.totalLost + session[:lose].to_i, 
        :totalProfit => user.totalProfit + session[:profit].to_i)
    session.clear
    redirect "/home"
end

post '/login' do
    if Player.get(params[:username]) != nil
        @user = Player.get(params[:username])
        if params[:password] == @user.password
            session[:user] = true
            session[:validLogin] = "Welcome #{params[:username]}"
            session[:username] = @user.username
            session[:totalWin] = @user.totalWin
            session[:totalLost] = @user.totalLost
            session[:totalProfit] = @user.totalProfit
            session[:win] = 0
            session[:lose] = 0
            session[:profit] = 0
            redirect "/gamb"
        else
            session[:validLogin] = "Invalid username/password, please try again"
            erb :login
        end 
    else
        session[:validLogin] = "Invalid username/password, please try again"
        erb :login
    end
end

post '/signup' do
    if Player.get(params[:username]) != nil
        session[:validSign] = "User already exist! Try different name"
        redirect to ('/signup')
    else
        player = Player.new
        player.username = params[:username]
        player.password = params[:password]
        player.totalWin = 0
        player.totalLost = 0
        player.totalProfit = 0
        if params[:username].empty? || params[:password].empty?
            session[:validSign] = "Invalid entry, please fill again."
            redirect to ('/signup')
        else
            session[:validLogin] = "Success, welcome new member!"
            player.save
            redirect to ('/home')
        end
    end
end

post '/placeBet' do
    user = Player.get(session[:username])
    if params[:betAmount] == "" or params[:betOn] == ""
        session[:result] = "Inputs are empty, try again"
        erb :gamb
    else
        if params[:betAmount] !~ /\d/ or params[:betOn] !~ /[1-6]/
           session[:result] = "Inputs must be number! and bet on range should be 1 to 6"
           erb :gamb
        else 
            @random = 1 + rand(6)
            guess = params[:betOn].to_i
            money = params[:betAmount].to_i
            if guess == @random
                session[:win] += 1
                session[:profit] += money*2
                session[:result] = "Win, you got the right number! The dice number is: "
                session[:totalWin] = user.totalWin + session[:win]
                session[:totalProfit] = user.totalProfit + session[:profit]
            else
                session[:lose] += 1
                session[:profit] -= money
                session[:result] = "Lose, try again! The dice number is: "
                session[:totalLost] = user.totalLost + session[:lose]
                session[:totalProfit] = user.totalProfit + session[:profit]
            end
            erb :gamb
        end
    end
    

end
