module OmniauthMacros
 
 def facebook_hash
 	OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
   	"provider"=>"facebook",
   	"uid"=>"115483839416294",
   	"info"=>{
    	"email" => "stefano_fsdnitt_milani@tfbnw.net",
    	"name" => "Stefano Milani",
    	"first_name"=>"Stefano",
    	"last_name" => "Milani",
    	
   	},
   	"credentials"=> { 
  		"token" => "fb_token"
    }
 	})
	end

 def twitter_hash
 	OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
   	"provider"=>"twitter",
   	"uid"=>"tw_uid",
   	"info"=>{
    	"email" => "stefano_fsdnitt_milani@tfbnw.net",
    	"name" => "Stefano Milani"
    	
   	},
   	"credentials"=> { 
  		"token" => "tw_token"
    }
 	})
	end


end