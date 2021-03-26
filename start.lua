serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_Spyder = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_Spyder = function() 
local Create_Info = function(Token,Sudo,UserName)  
local Spyder_Info_Sudo = io.open("sudo.lua", 'w')
Spyder_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

]])
Spyder_Info_Sudo:close()
end  
if not database:get(Server_Spyder.."Token_Spyder") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_Spyder.."Token_Spyder",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_Spyder.."Id_Spyder") then
print("\27[1;34m\n»» Send Your id Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
io.write('\n\27[1;31m»» The id Is Saved\n\27[0;39;49m')
database:set(Server_Spyder.."Id_Spyder",UserName)
else
io.write('\n\27[1;31mThe id was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
local function Files_Spyder_Info()
Create_Info(database:get(Server_Spyder.."Token_Spyder"),database:get(Server_Spyder.."Id_Spyder"),database:get(Server_Spyder.."UserName_Spyder"))   
local RunSpyder = io.open("Spyder", 'w')
RunSpyder:write([[
#!/usr/bin/env bash
cd $HOME/Spyder
token="]]..database:get(Server_Spyder.."Token_Spyder")..[["
rm -fr Spyder.lua
wget "https://raw.githubusercontent.com/Tubaktele/Spyder/main/Spyder.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./Spyder.lua -p PROFILE --bot=$token
done
]])
RunSpyder:close()
local RunTs = io.open("tk", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/Spyder
while(true) do
rm -fr ../.telegram-cli
screen -S Spyder -X kill
screen -S Spyder ./Spyder
done
]])
RunTs:close()
end
Files_Spyder_Info()
database:del(Server_Spyder.."Token_Spyder");database:del(Server_Spyder.."Id_Spyder");database:del(Server_Spyder.."UserName_Spyder")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_Spyder()  
var = true
else   
f:close()  
database:del(Server_Spyder.."Token_Spyder");database:del(Server_Spyder.."Id_Spyder");database:del(Server_Spyder.."UserName_Spyder")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
