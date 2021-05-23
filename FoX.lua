redis = require('redis') 
https = require ("ssl.https") 
serpent = dofile("./library/serpent.lua") 
json = dofile("./library/JSON.lua") 
JSON  = dofile("./library/dkjson.lua")
URL = require('socket.url')  
utf8 = require ('lua-utf8') 
database = redis.connect('127.0.0.1', 6379) 
id_server = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
--------------------------------------------------------------------------------------------------------------
local AutoSet = function() 
local create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Info"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)    
file:close()  
end  
if not database:get(id_server..":token") then
io.write('\27[0;31m\n ارسل لي توكن البوت الان ↓ :\na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n\27')
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
print('\27[0;31m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n التوكن غير صحيح تاكد منه ثم ارسله')
else
io.write('\27[0;31m تم حفظ التوكن بنجاح \na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n27[0;39;49m')
database:set(id_server..":token",token)
end 
else
print('\27[0;35m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n لم يتم حفظ التوكن ارسل لي التوكن الان')
end 
os.execute('lua FoX.lua')
end
if not database:get(id_server..":SUDO:ID") then
io.write('\27[0;35m\n ارسل لي ايدي المطور الاساسي ↓ :\na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n\27[0;33;49m')
local SUDOID = io.read()
if SUDOID ~= '' then
io.write('\27[1;35m تم حفظ ايدي المطور الاساسي \na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n27[0;39;49m')
database:set(id_server..":SUDO:ID",SUDOID)
else
print('\27[0;31m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n لم يتم حفظ ايدي المطور الاساسي ارسله مره اخره')
end 
os.execute('lua FoX.lua')
end
if not database:get(id_server..":SUDO:USERNAME") then
io.write('\27[1;31m ↓ ارسل معرف المطور الاساسي :\n SEND ID FOR SIDO : \27[0;39;49m')
local SUDOUSERNAME = io.read():gsub('@','')
if SUDOUSERNAME ~= '' then
io.write('\n\27[1;34m تم حفظ معرف المطور :\n\27[0;39;49m')
database:set(id_server..":SUDO:USERNAME",'@'..SUDOUSERNAME)
else
print('\n\27[1;34m لم يتم حفظ معرف المطور :')
end 
os.execute('lua FoX.lua')
end
local create_config_auto = function()
config = {
token = database:get(id_server..":token"),
SUDO = database:get(id_server..":SUDO:ID"),
UserName = database:get(id_server..":SUDO:USERNAME"),
 }
create(config, "./Info.lua")   
end 
create_config_auto()
token = database:get(id_server..":token")
SUDO = database:get(id_server..":SUDO:ID")
install = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '') 
print('\n\27[1;34m doneeeeeeee senddddddddddddd :')
file = io.open("FoX", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/FoX
token="]]..database:get(id_server..":token")..[["
while(true) do
rm -fr ../.telegram-cli
if [ ! -f ./tg ]; then
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉┉ ┉ ┉ ┉ ┉ ┉ ┉"
echo "TG IS NOT FIND IN FILES BOT"
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
exit 1
fi
if [ ! $token ]; then
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
echo -e "\e[1;36mTOKEN IS NOT FIND IN FILE INFO.LUA \e[0m"
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉┉ ┉"
exit 1
fi
echo -e "\033[38;5;208m"
echo -e "                                                  "
echo -e "\033[0;00m"
echo -e "\e[36m"
./tg -s ./FoX.lua -p PROFILE --bot=$token
done
]])  
file:close()  
file = io.open("FX", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/FoX
while(true) do
rm -fr ../.telegram-cli
screen -S FoX -X kill
screen -S FoX ./FoX
done
]])  
file:close() 
os.execute('rm -fr $HOME/.telegram-cli')
end 
local serialize_to_file = function(data, file, uglify)  
file = io.open(file, "w+")  
local serialized  
if not uglify then   
serialized = serpent.block(data, {comment = false, name = "Info"})  
else   
serialized = serpent.dump(data) 
end  
file:write(serialized)  
file:close() 
end 
local load_redis = function()  
local f = io.open("./Info.lua", "r")  
if not f then   
AutoSet()  
else   
f:close()  
database:del(id_server..":token")
database:del(id_server..":SUDO:ID")
end  
local config = loadfile("./Info.lua")() 
return config 
end 
_redis = load_redis()  
--------------------------------------------------------------------------------------------------------------
print([[
 ********          **     **
/**/////          //**   ** 
/**        ******  //** **  
/*******  **////**  //***   
/**////  /**   /**   **/**  
/**      /**   /**  ** //** 
/**      //******  **   //**
//        //////  //     // 
> CH › @IIIIlI8
~> DEVELOPER › @ZzZz5Z
~> DEVELOPER › @X_GGX
]])
sudos = dofile("./Info.lua") 
SUDO = tonumber(sudos.SUDO)
sudo_users = {SUDO}
bot_id = sudos.token:match("(%d+)")  
token = sudos.token 
--- start functions ↓
--------------------------------------------------------------------------------------------------------------
io.popen("mkdir File_Bot") 
t = "\27[35m".."\nAll Files Started : \n____________________\n"..'\27[m'
i = 0
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
i = i + 1
t = t.."\27[39m"..i.."\27[36m".." - \27[10;32m"..v..",\27[m \n"
end
end
print(t)
function vardump(value)  
print(serpent.block(value, {comment=false}))   
end 
sudo_users = {SUDO,1200805273,798700870}   
function SudoBot(msg)  
local FoX = false  
for k,v in pairs(sudo_users) do  
if tonumber(msg.sender_user_id_) == tonumber(v) then  
FoX = true  
end  
end  
return FoX  
end 
function HH6HHH(msg) 
local hash = database:sismember(bot_id.."HH6HHH:Sudo", msg.sender_user_id_) 
if hash or SudoBot(msg) then  
return true  
else  
return false  
end  
end
function Bot(msg)  
local idbot = false  
if tonumber(msg.sender_user_id_) == tonumber(bot_id) then  
idbot = true    
end  
return idbot  
end
function Sudo(msg) 
local hash = database:sismember(bot_id..'Sudo:User', msg.sender_user_id_) 
if hash or SudoBot(msg) or HH6HHH(msg) or Bot(msg)  then  
return true  
else  
return false  
end  
end
function CoSu(msg)
local hash = database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or HH6HHH(msg) or Sudo(msg) or Bot(msg)  then   
return true 
else 
return false 
end 
end
function BasicConstructor(msg)
local hash = database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or HH6HHH(msg) or Sudo(msg) or CoSu(msg) or Bot(msg)  then   
return true 
else 
return false 
end 
end
function Constructor(msg)
local hash = database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or HH6HHH(msg) or Sudo(msg) or BasicConstructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Manager(msg)
local hash = database:sismember(bot_id..'Manager'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or HH6HHH(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Mod(msg)
local hash = database:sismember(bot_id..'Mod:User'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or HH6HHH(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Special(msg)
local hash = database:sismember(bot_id..'Special:User'..msg.chat_id_,msg.sender_user_id_) 
if hash or SudoBot(msg) or HH6HHH(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Mod(msg) or CoSu(msg) or Bot(msg)  then       
return true 
else 
return false 
end 
end
function Can_or_NotCan(user_id,chat_id)
if tonumber(user_id) == tonumber(798700870) then  
var = true  
elseif tonumber(user_id) == tonumber(1200805273) then
var = true 
elseif tonumber(user_id) == tonumber(SUDO) then
var = true  
elseif tonumber(user_id) == tonumber(bot_id) then
var = true  
elseif database:sismember(bot_id.."HH6HHH:Sudo", user_id) then
var = true  
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = true  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = true  
elseif database:sismember(bot_id..'Mamez:User'..chat_id, user_id) then  
var = true  
else  
var = false  
end  
return var
end 
function Rutba(user_id,chat_id)
if tonumber(user_id) == tonumber(1200805273) then  
var = 'مطوࢪ فوڪس'
elseif tonumber(user_id) == tonumber(798700870) then
var = 'مطور السورس'
elseif tonumber(user_id) == tonumber(SUDO) then
var = 'المطور الاساسي'  
elseif database:sismember(bot_id.."HH6HHH:Sudo", user_id) then 
var = 'المطور الاساسي²'  
elseif tonumber(user_id) == tonumber(bot_id) then  
var = 'البوت'
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = database:get(bot_id.."Sudo:Rd"..msg.chat_id_) or 'المطور'  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var =  'المالك'
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = database:get(bot_id.."BasicConstructor:Rd"..msg.chat_id_) or 'المنشئ اساسي'
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = database:get(bot_id.."Constructor:Rd"..msg.chat_id_) or 'المنشئ'  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = database:get(bot_id.."Manager:Rd"..msg.chat_id_) or 'المدير' 
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = database:get(bot_id.."Mod:Rd"..msg.chat_id_) or 'الادمن'  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = database:get(bot_id.."Special:Rd"..msg.chat_id_) or 'المميز'  
else  
var = database:get(bot_id.."Memp:Rd"..msg.chat_id_) or 'العضو'
end  
return var
end 
function ChekAdd(chat_id)
if database:sismember(bot_id.."Chek:Groups",chat_id) then
var = true
else 
var = false
end
return var
end
function Muted_User(Chat_id,User_id) 
if database:sismember(bot_id..'Muted:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end
function Ban_User(Chat_id,User_id) 
if database:sismember(bot_id..'Ban:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end 
function GBan_User(User_id) 
if database:sismember(bot_id..'GBan:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function Gmute_User(User_id) 
if database:sismember(bot_id..'Gmute:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function AddChannel(User)
local var = true
if database:get(bot_id..'add:ch:id') then
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchatmember?chat_id="..database:get(bot_id..'add:ch:id').."&user_id="..User);
data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false
end
end
return var
end

function dl_cb(a,d)
end
function getChatId(id)
local chat = {}
local id = tostring(id)
if id:match('^-100') then
local channel_id = id:gsub('-100', '')
chat = {ID = channel_id, type = 'channel'}
else
local group_id = id:gsub('-', '')
chat = {ID = group_id, type = 'group'}
end
return chat
end
function chat_kick(chat,user)
tdcli_function ({
ID = "ChangeChatMemberStatus",
chat_id_ = chat,
user_id_ = user,
status_ = {ID = "ChatMemberStatusKicked"},},function(arg,data) end,nil)
end
function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function DeleteMessage(chat,id)
tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},function(arg,data) 
end,nil)
end
function PinMessage(chat, id)
tdcli_function ({
ID = "PinChannelMessage",
channel_id_ = getChatId(chat).ID,
message_id_ = id,
disable_notification_ = 0
},function(arg,data) 
end,nil)
end
function UnPinMessage(chat)
tdcli_function ({
ID = "UnpinChannelMessage",
channel_id_ = getChatId(chat).ID
},function(arg,data) 
end,nil)
end
local function GetChat(chat_id) 
tdcli_function ({
ID = "GetChat",
chat_id_ = chat_id
},cb, nil) 
end  
function getInputFile(file) 
if file:match('/') then infile = {ID = "InputFileLocal", path_ = file} elseif file:match('^%d+$') then infile = {ID = "InputFileId", id_ = file} else infile = {ID = "InputFilePersistentId", persistent_id_ = file} end return infile 
end
function ked(User_id,Chat_id)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..Chat_id.."&user_id="..User_id)
end
function s_api(web) 
local info, res = https.request(web) local req = json:decode(info) if res ~= 200 then return false end if not req.ok then return false end return req 
end 
local function sendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..token local url = send_api..'/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text) if reply_to_message_id ~= 0 then url = url .. '&reply_to_message_id=' .. reply_to_message_id  end if markdown == 'md' or markdown == 'markdown' then url = url..'&parse_mode=Markdown' elseif markdown == 'html' then url = url..'&parse_mode=HTML' end return s_api(url)  
end
local function Send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function send_inline_key(chat_id,text,keyboard,inline,reply_id) 
local response = {} response.keyboard = keyboard response.inline_keyboard = inline response.resize_keyboard = true response.one_time_keyboard = false response.selective = false  local send_api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) if reply_id then send_api = send_api.."&reply_to_message_id="..reply_id end return s_api(send_api) 
end
local function GetInputFile(file)  
local file = file or ""   if file:match('/') then  infile = {ID= "InputFileLocal", path_  = file}  elseif file:match('^%d+$') then  infile = {ID= "InputFileId", id_ = file}  else  infile = {ID= "InputFilePersistentId", persistent_id_ = file}  end return infile 
end
local function sendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra) 
tdcli_function ({  ID = request_id,    chat_id_ = chat_id,    reply_to_message_id_ = reply_to_message_id,    disable_notification_ = disable_notification,    from_background_ = from_background,    reply_markup_ = reply_markup,    input_message_content_ = input_message_content,}, callback or dl_cb, extra) 
end
local function sendAudio(chat_id,reply_id,audio,title,caption)  
tdcli_function({ID="SendMessage",  chat_id_ = chat_id,  reply_to_message_id_ = reply_id,  disable_notification_ = 0,  from_background_ = 1,  reply_markup_ = nil,  input_message_content_ = {  ID="InputMessageAudio",  audio_ = GetInputFile(audio),  duration_ = '',  title_ = title or '',  performer_ = '',  caption_ = caption or ''  }},dl_cb,nil)
end  
local function sendVideo(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, video, duration, width, height, caption, cb, cmd)    
local input_message_content = { ID = "InputMessageVideo",      video_ = getInputFile(video),      added_sticker_file_ids_ = {},      duration_ = duration or 0,      width_ = width or 0,      height_ = height or 0,      caption_ = caption    }    sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)  
end
function sendDocument(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, dl_cb, cmd) 
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = disable_notification,from_background_ = from_background,reply_markup_ = reply_markup,input_message_content_ = {ID = "InputMessageDocument",document_ = getInputFile(document),caption_ = caption},}, dl_cb, cmd) 
end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)  
local input_message_content = {   ID = "InputMessageVoice",   voice_ = getInputFile(voice),  duration_ = duration or 0,   waveform_ = waveform,    caption_ = caption  }  sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendSticker(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker, cb, cmd)  
local input_message_content = {    ID = "InputMessageSticker",   sticker_ = getInputFile(sticker),    width_ = 0,    height_ = 0  } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo,caption)   
tdcli_function ({ ID = "SendMessage",   chat_id_ = chat_id,   reply_to_message_id_ = reply_to_message_id,   disable_notification_ = disable_notification,   from_background_ = from_background,   reply_markup_ = reply_markup,   input_message_content_ = {   ID = "InputMessagePhoto",   photo_ = getInputFile(photo),   added_sticker_file_ids_ = {},   width_ = 0,   height_ = 0,   caption_ = caption  },   }, dl_cb, nil)  
end
function Reply_Status(msg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "IIIIlI8")
local NameUser = "◐ بواسطه » ["..data.first_name_.."](T.me/"..UserName..")"
local NameUserr = "◐ اسم المستخدم » ["..data.first_name_.."](T.me/"..UserName..")"
if status == "reply" then
send(msg.chat_id_, msg.id_,NameUserr.."\n"..text)
return false
end
else
send(msg.chat_id_, msg.id_,"◐ الحساب محذوف يرجى استخدام الامر بصوره صحيحه")
end
end,nil)   
end 
function Total_Msg(msgs)  
local FoX_Msg = ''  
if msgs < 100 then 
FoX_Msg = 'غير متفاعل' 
elseif msgs < 200 then 
FoX_Msg = 'بده يتحسن' 
elseif msgs < 400 then 
FoX_Msg = 'شبه متفاعل' 
elseif msgs < 700 then 
FoX_Msg = 'متفاعل' 
elseif msgs < 1200 then 
FoX_Msg = 'متفاعل قوي' 
elseif msgs < 2000 then 
FoX_Msg = 'متفاعل جدا' 
elseif msgs < 3500 then 
FoX_Msg = 'اقوى تفاعل'  
elseif msgs < 4000 then 
FoX_Msg = 'متفاعل نار' 
elseif msgs < 4500 then 
FoX_Msg = 'قمة التفاعل'
elseif msgs < 5500 then 
FoX_Msg = 'اقوى متفاعل' 
elseif msgs < 7000 then 
FoX_Msg = 'ملك التفاعل' 
elseif msgs < 9500 then 
FoX_Msg = 'امبروطور التفاعل' 
elseif msgs < 10000000000 then 
FoX_Msg = 'رب التفاعل'  
end 
return FoX_Msg 
end
function Get_Info(msg,chat,user) 
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. chat ..'&user_id='.. user..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "creator" then
Send(msg.chat_id_,msg.id_,'\n◐ مالك الكروب')   
return false  end 
if Json_Info.result.status == "member" then
Send(msg.chat_id_,msg.id_,'\n◐ مجرد عضو هنا ')   
return false  end
if Json_Info.result.status == 'left' then
Send(msg.chat_id_,msg.id_,'\n◐ الشخص غير موجود هنا ')   
return false  end
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = 'ꪜ'
else
info = '✘'
end
if Json_Info.result.can_delete_messages == true then
delete = 'ꪜ'
else
delete = '✘'
end
if Json_Info.result.can_invite_users == true then
invite = 'ꪜ'
else
invite = '✘'
end
if Json_Info.result.can_pin_messages == true then
pin = 'ꪜ'
else
pin = '✘'
end
if Json_Info.result.can_restrict_members == true then
restrict = 'ꪜ'
else
restrict = '✘'
end
if Json_Info.result.can_promote_members == true then
promote = 'ꪜ'
else
promote = '✘'
end
Send(chat,msg.id_,'\n- الرتبة : مشرف  '..'\n- والصلاحيات هي ↓ \nٴ━━━━━━━━━━'..'\n- تغير معلومات الكروب ↞ ❴ '..info..' ❵'..'\n- حذف الرسائل ↞ ❴ '..delete..' ❵'..'\n- حظر المستخدمين ↞ ❴ '..restrict..' ❵'..'\n- دعوة مستخدمين ↞ ❴ '..invite..' ❵'..'\n- تثبيت الرسائل ↞ ❴ '..pin..' ❵'..'\n- اضافة مشرفين جدد ↞ ❴ '..promote..' ❵')   
end
end
end
function GetFile_Bot(msg)
local list = database:smembers(bot_id..'Chek:Groups') 
local t = '{"BOT_ID": '..bot_id..',"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = 'FoX Chat'
link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_) or ''
ASAS = database:smembers(bot_id..'Basic:Constructor'..v)
MNSH = database:smembers(bot_id..'Constructor'..v)
MDER = database:smembers(bot_id..'Manager'..v)
MOD = database:smembers(bot_id..'Mod:User'..v)
if k == 1 then
t = t..'"'..v..'":{"FoX":"'..NAME..'",'
else
t = t..',"'..v..'":{"FoX":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"ASAS":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './'..bot_id..'.json', '- عدد كروبات التي في البوت { '..#list..'}')
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
function AddFile_Bot(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if tonumber(File_Name:match('(%d+)')) ~= tonumber(bot_id) then 
send(chat,msg.id_," ◐  ملف نسخه ليس لهاذا البوت")
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
send(chat,msg.id_," ◐  جاري ...\n ◐  رفع الملف الان")
else
send(chat,msg.id_,"* ◐ عذرا الملف ليس بصيغة {JSON} يرجى رفع الملف الصحيح*")
end      
local info_file = io.open('./'..bot_id..'.json', "r"):read('*a')
local groups = JSON.decode(info_file)
for idg,v in pairs(groups.GP_BOT) do
database:sadd(bot_id..'Chek:Groups',idg)  
database:set(bot_id..'lock:tagservrbot'..idg,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..idg,'del')    
end
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
database:sadd(bot_id..'Constructor'..idg,idmsh)
end
end
if v.MDER then
for k,idmder in pairs(v.MDER) do
database:sadd(bot_id..'Manager'..idg,idmder)  
end
end
if v.MOD then
for k,idmod in pairs(v.MOD) do
database:sadd(bot_id..'Mod:User'..idg,idmod)  
end
end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
database:sadd(bot_id..'Basic:Constructor'..idg,idASAS)  
end
end
end
send(chat,msg.id_,"\n ◐ تم رفع الملف بنجاح وتفعيل الكروبات\n ◐ ورفع {الامنشئين الاساسين ; والمنشئين ; والمدراء; والادمنيه} بنجاح")
end
local function trigger_anti_spam(msg,type)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
local Name = '['..utf8.sub(data.first_name_,0,40)..'](tg://user?id='..data.id_..')'
if type == 'kick' then 
Text = '\n ◐ العضــو » '..Name..'\n ◐ قام بالتكرار هنا وتم طرده '  
sendText(msg.chat_id_,Text,0,'md')
chat_kick(msg.chat_id_,msg.sender_user_id_) 
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end 
if type == 'del' then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_})    
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
end 
if type == 'keed' then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '\n ◐ العضــو » '..Name..'\n ◐ قام بالتكرار هنا وتم تقييده '  
sendText(msg.chat_id_,Text,0,'md')
return false  
end  
if type == 'mute' then
Text = '\n ◐ العضــو » '..Name..'\n ◐ قام بالتكرار هنا وتم طرده '  
sendText(msg.chat_id_,Text,0,'md')
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end
end,nil)   
end  
function plugin_Foxx(msg)
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
plugin = dofile("File_Bot/"..v)
if plugin.Foxx and msg then
pre_msg = plugin.Foxx(msg)
end
end
end
send(msg.chat_id_, msg.id_,pre_msg)  
end

--------------------------------------------------------------------------------------------------------------
function SourceFoX(msg,data) -- بداية العمل
if msg then
local text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
database:incr(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
database:sadd(bot_id..'User_Bot',msg.sender_user_id_)  
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
if database:get(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ◐" then   
send(msg.chat_id_, msg.id_," ◐ تم الغاء الاذاعه")
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id.."Chek:Groups") 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
database:set(bot_id..'Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
send(msg.chat_id_, msg.id_," ◐ تمت الاذاعه الى *~ "..#list.." ~* كروب ")
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'UserBot' then
if text == '/start' then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if HH6HHH(msg) then
local bl = '-  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙  المطور الاساسي \n سوࢪس فوڪس \n يمكنك تحكم في البوتات من الكيبورد أسفل \n[تابع جديدنا](t.me/IIIIlI8) '
local keyboard = {
	{'◐معلومات الكيبورد◐'},
	  {'◐ضع اسم للبوت◐'},
{'◐تعطيل التواصل◐','◐تفعيل التواصل◐'},
        {'◐الاحصائيات◐'},
{'◐المشتركين◐','◐المجموعات◐'},
{'◐تنظيف المجموعات◐','◐تنظيف المشتركين◐'},
{'المطورين◐','المميزين عام◐'},
{'◐قائمه الكتم عام◐','◐قائمة حظر عام◐'},
{'◐اذاعه خاص◐','◐اذاعه◐'},
{'◐اذاعه بالتثبيت◐'},
{'◐اذاعه بالتوجيه خاص◐','◐اذاعه بالتوجيه◐'},
{'◐ضع كليشه ستارت◐','◐حذف كليشه ستارت◐'},
{'◐الاشتراك الاجباري◐','◐وضع قناة الاشتراك◐'},
{'◐تغير رساله الاشتراك◐','◐حذف رساله الاشتراك◐'},
{'◐تغير الاشتراك◐'},
{'◐تعطيل الاشتراك◐','◐تفعيل الاشتراك◐'},
{'◐تفعيل البوت خدمي◐','◐تعطيل البوت خدمي◐'},
{'◐جلب خزن البوت◐'},
{'اضف كت تويت'},
{'حذف كت تويت'},
{'◐تحديث السورس◐'}, 
{'◐معلومات السيرفر◐'}, 
{'الاصدار◐'},
{'الغاء'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
else
if not database:get(bot_id..'Start:Time'..msg.sender_user_id_) then
local start = database:get(bot_id.."Start:Bot")  
if start then 
SourceMODEDEVr = start
else
SourceMODEDEVr = '- هلا عزيزي\n- انا بوت اسمي '..Namebot..'\n- اختصاصي حمايه المجموعات\n من التفليش وبعض الاوامر الخدميه للتسليه والخ…\n-لتفعيلي اتبع الخطوات…↓\n- اضفني الي مجموعتك وقم بترقيتي ادمن واكتب كلمه { تفعيل }  ويستطيع >{ منشئ او المشرفين } بتفعيلي فقط\n[◐𝘊𝘩 𝘴𝘰𝘶𝘳𝘴𝘦◐](http://t.me/IIIIlI8)'
end 
send(msg.chat_id_, msg.id_, SourceMODEDEVr) 
end
end
database:setex(bot_id..'Start:Time'..msg.sender_user_id_,300,true)
return false
end
if not HH6HHH(msg) and not database:sismember(bot_id..'Ban:User_Bot',msg.sender_user_id_) and not database:get(bot_id..'Tuasl:Bots') then
send(msg.sender_user_id_, msg.id_,' 𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 \n سيتم الرد عليك قريبا')
tdcli_function ({ID = "ForwardMessages", chat_id_ = SUDO,    from_chat_id_ = msg.sender_user_id_,    message_ids_ = {[0] = msg.id_},    disable_notification_ = 1,    from_background_ = 1 },function(arg,data) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,ta) 
vardump(data)
if data and data.messages_[0].content_.sticker_ then
local Name = '['..string.sub(ta.first_name_,0, 40)..'](tg://user?id='..ta.id_..')'
local Text = '◐تم ارسال الملصق من ↓\n - '..Name
sendText(SUDO,Text,0,'md')
end 
end,nil) 
end,nil)
end
if SudoBot(msg) and msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
id_user = result.forward_info_.sender_user_id_    
end     
tdcli_function ({ID = "GetUser",user_id_ = id_user},function(arg,data) 
if text == 'حظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '◐ المستخدم > '..Name..'\nتم حظره من التواصل '
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 
if text =='الغاء الحظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '◐ المستخدم > '..Name..'\n تم حظره من التواصل '
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 

tdcli_function({ID='GetChat',chat_id_ = id_user},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = id_user, action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,ta) 
if ta.code_ == 400 or ta.code_ == 5 then
local MODEDEV_Msg = '\n◐ فشل ارسال رسالتك لان العضو قام بحظر البوت'
send(msg.chat_id_, msg.id_,MODEDEV_Msg) 
return false  
end 
if text then    
send(id_user,msg.id_,text)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '◐ المستخدم > '..Name..'\n◐تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end    
if msg.content_.ID == 'MessageSticker' then    
sendSticker(id_user, msg.id_, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '◐ المستخدم > '..Name..'\n◐ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end      
if msg.content_.ID == 'MessagePhoto' then    
sendPhoto(id_user, msg.id_, 0, 1, nil,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '◐ المستخدم > '..Name..'\n◐ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageAnimation' then    
sendDocument(id_user, msg.id_, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '◐ المستخدم > '..Name..'\n◐ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageVoice' then    
sendVoice(id_user, msg.id_, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '◐ المستخدم > '..Name..'\n◐ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
end,nil)
end,nil)
end,nil)
end,nil)
end 
if text == '◐تفعيل التواصل◐' and HH6HHH(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n◐تم تفعيل التواصل' 
else
Text = '\n◐ بالتاكيد تم تفعيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == '◐تعطيل التواصل◐' and HH6HHH(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n تم تعطيل التواصل' 
else
Text = '\n◐ بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == '◐تفعيل البوت خدمي◐' and HH6HHH(msg) then  
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n تم تفعيل البوت خدمي ' 
else
Text = '\n◐ البوت الان يتم تفعيله في المجموعات من قبل المشرفين + المالكين '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == '◐تعطيل البوت خدمي◐' and HH6HHH(msg) then  
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n تم تعطيل البوت خدمي' 
else
Text = '\n◐ اهلا عزيزي المطور البوت تم تعطيله من التفعيل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and database:get(bot_id..'Start:Bots') then
if text == 'الغاء' or text == 'الغاء ◐' then   
send(msg.chat_id_, msg.id_,' الغاء حفظ كليشه ستارت')
database:del(bot_id..'Start:Bots') 
return false
end 
database:set(bot_id.."Start:Bot",text)  
send(msg.chat_id_, msg.id_,'◐ تم حفظ كليشه ستارت') 
database:del(bot_id..'Start:Bots') 
return false
end
if text == '◐ضع كليشه ستارت◐' and HH6HHH(msg) then 
database:set(bot_id..'Start:Bots',true) 
send(msg.chat_id_, msg.id_,'◐ ارسل لي الكليشه الان') 
return false
end
if text == '◐حذف كليشه ستارت◐' and HH6HHH(msg) then 
database:del(bot_id..'Start:Bot') 
send(msg.chat_id_, msg.id_,'◐تم حذف كليشه ستارت') 
end
if text == '◐معلومات السيرفر◐' and HH6HHH(msg) then 
send(msg.chat_id_, msg.id_, io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '◐ { نظام التشغيل } ◐\n*>> '"$linux_version"'*' 
echo '*◐━━━━━━━━━◐*\n◐{ الذاكره العشوائيه }◐\n*>> '"$memUsedPrc"'*'
echo '*◐━━━━━━━━━◐*\n◐{ وحـده الـتـخـزيـن }◐\n*>> '"$HardDisk"'*'
echo '*◐━━━━━━━━━◐*\n◐{ الـمــعــالــج }◐\n*>> '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '*◐━━━━━━━━━◐*\n◐{ الــدخــول }◐\n*>> '`whoami`'*'
echo '*◐━━━━━━━━━◐*\n◐{ مـده تـشغيـل الـسـيـرفـر }\n*>> '"$uptime"'*'
]]):read('*all'))  
end
if text == '◐تحديث السورس◐' and mHH6HHH(msg) then 
os.execute('rm -rf FoX.lua')
os.execute('wget https://raw.githubusercontent.com/Source-FoX/FoX/master/FoX.lua')
send(msg.chat_id_, msg.id_,' ◐∫ تم تحديث السورس \n ◐∫ لديك اخر اصدار لسورس فوكس\n ◐∫ الاصدار » { 1.3v}')
dofile('FoX.lua')  
end
if text == 'الاصدار◐' and HH6HHH(msg) then 
database:del(bot_id..'Srt:Bot') 
send(msg.chat_id_, msg.id_,' ◐∫ اصدار سورس فوكس \n ◐∫ الاصدار »{ 1.3v}')
end
if text == '◐معلومات الكيبورد◐' and HH6HHH(msg) then 
database:del(bot_id..'Sart:Bot') 
send(msg.chat_id_, msg.id_,'- اهلا عزيزى مطور اساسي \n- معلومات كتالي↓\n1◐ الاحصائيات { لعرض عدد الكروبات، والمشتركين في البوت }\n2◐ تفعيل التواصل{ لتفعيل التواصلعبر البوت خاص بك}\n3◐ تعطيل التواصل{ لتعطيل التواصلعبر البوت خاص بك }\n4◐ قائمه العام { لعرض المحظورين عام في البوت }\n5◐ المطورين { لعرض المطورين في بوتك } \n6◐ ضع اسم للبوت { لختيار اسم لبوت خاص بك }\n7◐ حذف كليشه ستارت { حذف كليشه عندما يضغط العضو علي كلمه /start }\n8◐ ضع كليشه ستارت { لختيار كلايشه /start حديده }\n9◐ اذاعه { ارسال رساله لجميع الكروبات في بوتك }\n10◐ اذاعه خاص { ارسال رساله لجميع مشتركين بوتك!}\n11◐ تعطيل الاشتراك الاجباري { لتعطيل الاشتراك جباري خاص بوتك}\n12◐ تفعيل الاشتراك الاجباري { لتفعيل الاشتراك الاجباري بوتك }\n13◐اذاعه بالتوجيه { ارسال رساله بالتوجيه الي جميع الكروبات }\n14◐ اذاعه بالتوجيه خاص { ارسال رساله بالتوجيه الي جميع المشتركين }\n15◐ حذف رساله الاشتراك { لحذف رساله الاشتراك التي اضفتها }\n16◐ تغير رساله الاشتراك { لتغير رساله الاشتراك خاصه بوتك وتختار غيرها }\n17◐ تغير الاشتراك{لتغير ◐الاشتراك الاجباري◐ خاص بوتك واضافت قناة غيرها }\n18◐ تفعيل الاشتراكالاول { لتفعيل الاشتراكجباري عندما تفعيل البوت اول مَـرّھٌ }\n19◐ الاشتراك الاجباري { لظهار القناة مفعل الاشتراك عليها }\n20◐ تفعيل البوت الخدمي { يمكن هاذا امر ان منشئ الكروب يفعل البوت م̷ـــِْن دون حتياجه لمطور البوت\n21◐ تعطيل البوت الخدمي { يمك هل خاصيه ان تفعيل البوت اله مطورين البوت فقط }\n22◐ تنظيف المشتركين { يمكنك ازاله المشتركين الوهمين عبر هل امر }\n23◐ تنظيف الكروبات { يمكن ازاله المجموعات الوهميه عبر عل امر }\n24◐ جلب نسخه احتياطيه { لعرض ملف المجموعات بوتك }\n25◐ تحديث السورس { لتحديث السورس خاص بوتك }\n26◐ الغاء { للغاء الامر الذي طلبته }\n===ء====================\n- اوامر كيبورت المطور اساسي معا شرح\n- قناة السورس [ضغط هنا](t.me/IIIIlI8)') 
end
if text == "◐ضع اسم للبوت◐" and HH6HHH(msg) then  
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"◐ ارسل لي الاسم الان ")  
return false
end
if text == '◐الاحصائيات◐' and HH6HHH(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '◐ عدد المجموعات >  {'..Groups..'}'..'\n ◐ عدد المشتركين >  {'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == '◐المشتركين◐' and HH6HHH(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n◐ المشتركين>{`'..Users..'`}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == '◐المجموعات◐' and HH6HHH(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n ◐ المجموعات> {`'..Groups..'`}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == ("المميزين عام◐") and HH6HHH(msg) then
local list = database:smembers(bot_id..'Mamez:User')
t = "\n*◐ قائمه مميزين العام \n *◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."︙"..k.." >  ([@"..username.."])\n"
else
end
end
if #list == 0 then
t = "◐ لا يوجد مميز العام"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("المطورين◐") and HH6HHH(msg) then
local list = database:smembers(bot_id..'Sudo:User')
t = "\n*◐ قائمه المطورين \n *◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."︙ "..k.."︙  >  ([@"..username.."])\n"
else
end
end
if #list == 0 then
t = "◐ لا يوجد مطورين ◐"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("◐قائمة حظر عام◐") and HH6HHH(msg) then
local list = database:smembers(bot_id..'GBan:User')
t = "\n*◐ قائمة المحظورين عام \n *◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."︙ "..k.."︙ >  ([@"..username.."])\n"
else
end
end
if #list == 0 then
t = "◐ لا يوجد محظورين عام ◐"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("◐قائمه الكتم عام◐") and HH6HHH(msg) then
local list = database:smembers(bot_id..'Gmute:User')
t = "\n*◐ قائمه المكتومين عام\n *◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."︙ "..k.."︙ >  ([@"..username.."])\n"
else
end
end
if #list == 0 then
t = "◐ لا يوجد مكتومين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text=="◐اذاعه خاص◐" and msg.reply_to_message_id_ == 0 and HH6HHH(msg) then 
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"◐ ارسل لي سواء >> { ملصق, متحركه, صوره, رساله }\n◐ للخروج ارسل الغاء ") 
return false
end 
if text=="◐اذاعه◐" and msg.reply_to_message_id_ == 0 and HH6HHH(msg) then 
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"◐ ارسل لي سواء >> { ملصق, متحركه, صوره, رساله }\n◐ للخروج ارسل الغاء ") 
return false
end  
if text=="◐اذاعه بالتثبيت◐" and msg.reply_to_message_id_ == 0 and HH6HHH(msg) then 
database:setex(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"ارسل لي سواء ~ { ملصق, متحركه, صوره, رساله }\n◐للخروج ارسل الغاء ") 
return false
end 
if text=="◐اذاعه بالتوجيه◐" and msg.reply_to_message_id_ == 0  and HH6HHH(msg) then 
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"◐ ارسل لي التوجيه الان") 
return false
end 
if text=="◐اذاعه بالتوجيه خاص◐" and msg.reply_to_message_id_ == 0  and HH6HHH(msg) then 
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"◐ ارسل لي التوجيه الان") 
return false
end 
if text == '◐جلب خزن البوت◐' and HH6HHH(msg) then 
GetFile_Bot(msg)
end
if text == "◐تنظيف المشتركين◐" and HH6HHH(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ] '..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'◐ لا يوجد مشتركين وهميين في البوت \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'◐ عدد المشتركين الان > ( '..#pv..' )\n◐ تم ازالة > ( '..sendok..' ) من المشتركين\n◐ الان عدد المشتركين الحقيقي > ( '..ok..' ) مشترك \n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "◐تنظيف المجموعات◐" and HH6HHH(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'◐ لا يوجد مجموعات وهميه في البوت\n')   
else
local MODEDEV = (w + q)
local sendok = #group - MODEDEV
if q == 0 then
MODEDEV = ''
else
MODEDEV = '\n◐  تم ازالة > { '..q..' } مجموعات من البوت'
end
if w == 0 then
MODEDEVk = ''
else
MODEDEVk = '\n تم ازالة > {'..w..'} مجموعه لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'◐ عدد المجموعات الان > { '..#group..' }'..MODEDEVk..''..MODEDEV..'\n*◐ الان عدد المجموعات الحقيقي > { '..sendok..' } مجموعات\n')   
end
end
end,nil)
end
return false
end
if text and text:match("^رفع مطور @(.*)$") and HH6HHH(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n◐ العضو > ['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n تم ترقيته مطور في البوت'
texts = usertext..status
else
texts = ' يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and HH6HHH(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n◐ العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '\n تم ترقيته مطور في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n◐ العضو > '..userid..''
status  = '\n تم ترقيته مطور في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and HH6HHH(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n◐ العضو > ['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n تم تنزيله من المطورين'
texts = usertext..status
else
texts = ' يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and HH6HHH(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ◐ < جط ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n◐العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n◐العضو > '..userid..''
status  = '\n تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end

end
------------------------------------------------------------------------

if text and not Special(msg) then  
local MODEDEV1_Msg = database:get(bot_id.."MODEDEV1:Add:Filter:Rp2"..text..msg.chat_id_)   
if MODEDEV1_Msg then 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◐ العضو> ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n ◐'..MODEDEV1_Msg)
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end,nil)
end
end
if database:get(bot_id..'Set:Name:Bot'..msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ◐' then   
send(msg.chat_id_, msg.id_,"◐ تم الغاء حفظ اسم البوت") 
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
return false  
end 
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
database:set(bot_id..'Name:Bot',text) 
send(msg.chat_id_, msg.id_, " تم حفظ اسم البوت")  
return false
end 
if database:get(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ◐' then   
send(msg.chat_id_, msg.id_," تم الغاء الاذاعه للخاص") 
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'User_Bot') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_,"◐ تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")     
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ◐' then   
send(msg.chat_id_, msg.id_," تم الغاء الاذاعه") 
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'Chek:Groups') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_,"◐ تمت الاذاعه الى >>{"..#list.."} مجموعه في البوت ")     
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ◐' then   
send(msg.chat_id_, msg.id_,"◐ تم الغاء الاذاعه") 
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'Chek:Groups')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_,"◐ تمت الاذاعه الى >>{"..#list.."} مجموعات في البوت ")     
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ◐' then   
send(msg.chat_id_, msg.id_,"◐ تم الغاء الاذاعه") 
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'User_Bot')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_,"◐ تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")     
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "◐ تم الغاء الامر ") 
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local username = string.match(text, "@[%a%d_]+") 
tdcli_function ({    
ID = "SearchPublicChat",    
username_ = username  
},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, '◐ المعرف لا يوجد فيه قناة')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, '◐ عذا لا يمكنك وضع معرف حسابات في الاشتراك ') 
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'◐ عذا لا يمكنك وضع معرف مجوعه في الاشتراك ') 
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,'◐ البوت ادمن في القناة \n تم تفعيل الاشتراك الاجباري في \n ايدي القناة ('..data.id_..')\n◐ معرف القناة ([@'..data.type_.channel_.username_..'])') 
database:set(bot_id..'add:ch:id',data.id_)
database:set(bot_id..'add:ch:username','@'..data.type_.channel_.username_)
else
send(msg.chat_id_, msg.id_,'◐ البوت ليس ادمن في القناة يرجى ترقيته ادمن ثم اعادة المحاوله ') 
end
return false  
end
end,nil)
end
if database:get(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "◐ تم الغاء الامر ") 
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local texxt = string.match(text, "(.*)") 
database:set(bot_id..'text:ch:user',texxt)
send(msg.chat_id_, msg.id_,'◐ تم تغيير رسالة الاشتراك بنجاح ')
end

local status_welcome = database:get(bot_id..'Chek:Welcome'..msg.chat_id_)
if status_welcome and not database:get(bot_id..'lock:tagservr'..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink" then
tdcli_function({ID = "GetUser",user_id_=msg.sender_user_id_},function(extra,result) 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
t = GetWelcomeGroup
else  
t = '\n◐ نورت حبي \n◐  name \n◐ user' 
end 
t = t:gsub('name',result.first_name_) 
t = t:gsub('user',('@'..result.username_ or 'لا يوجد')) 
send(msg.chat_id_, msg.id_,t)
end,nil) 
end 
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.photo_ then  
if database:get(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) then 
if msg.content_.photo_.sizes_[3] then  
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ 
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ 
end 
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,' ◐ عذرآ البوت ليس ادمن بالقناه ')
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,' ◐ … عذرآ البوت لايملك صلاحيات')
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
else
send(msg.chat_id_, msg.id_,' ◐ تم تغيير صورة الكروب')
end
end, nil) 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
end   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_," ◐ تم الغاء وضع الوصف")
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)
return false  
end 
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
https.request('https://api.telegram.org/bot'..token..'/setChatDescription?chat_id='..msg.chat_id_..'&description='..text) 
send(msg.chat_id_, msg.id_,' ◐ تم تغيير وصف الكروب')
return false  
end 
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_," ◐ تم الغاء حفظ الترحيب")
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
database:set(bot_id..'Get:Welcome:Group'..msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,' ◐ تم حفظ ترحيب الكروب')
return false   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) then
if text == 'الغاء' then
send(msg.chat_id_,msg.id_," ◐ تم الغاء حفظ الرابط")
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local Link = text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)")   
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_," ◐ تم حفظ الرابط بنجاح")
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
--------------------------------------------------------------------------------------------------------------
if FoX_Msg and not Special(msg) then  
local FoX_Msg = database:get(bot_id.."Add:Filter:Rp2"..text..msg.chat_id_)   
if FoX_Msg then    
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ◐ العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n ◐ ["..FoX_Msg.."] \n")
else
send(msg.chat_id_,0," ◐ العضو : {["..data.first_name_.."](T.ME/IIIIlI8)}\n ◐ ["..FoX_Msg.."] \n")
end
end,nil)   
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
--------------------------------------------------------------------------------------------------------------
if not Special(msg) and msg.content_.ID ~= "MessageChatAddMembers" and database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") then 
floods = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") or 'nil'
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 5
local post_count = tonumber(database:get(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
if post_count > tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5) then 
local ch = msg.chat_id_
local type = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") 
trigger_anti_spam(msg,type)  
end
database:setex(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_, tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 3), post_count+1) 
local edit_id = data.text_ or 'nil'  
NUM_MSG_MAX = 5
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") then
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") 
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") then
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") 
end 
end 
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id..'lock:Fshar'..msg.chat_id_) and not Special(msg) then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Fars'..msg.chat_id_) and not Special(msg) then 
list = {"ڄ","گ","که","پی","خسته","برم","راحتی","بیام","بپوشم","گرمه","چه","چ","ڬ","ٺ","چ","ڇ","ڿ","ڀ","ڎ","ݫ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن", "خالی بند","عزیزم خوبی","سلامت باشی","میخوام","خوببی","ميدم","کی اومدی","خوابیدین"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Engilsh'..msg.chat_id_) and not Special(msg) then 
list = {'a','u','y','l','t','b','A','Q','U','J','K','L','B','D','L','V','Z','k','n','c','r','q','o','z','I','j','m','M','w','d','h','e'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id..'lock:text'..msg.chat_id_) and not Special(msg) then       
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
return false     
end     
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then 
database:incr(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if msg.content_.ID == "MessageChatAddMembers" and not Special(msg) then   
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
local mem_id = msg.content_.members_  
for i=0,#mem_id do  
chat_kick(msg.chat_id_,mem_id[i].id_)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatJoinByLink" and not Special(msg) then 
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
chat_kick(msg.chat_id_,msg.sender_user_id_)
return false  
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("@[%a%d_]+") or msg.content_.caption_:match("@(.+)") then  
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("@[%a%d_]+") or text and text:match("@(.+)") then    
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("#[%a%d_]+") or msg.content_.caption_:match("#(.+)") then 
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("#[%a%d_]+") or text and text:match("#(.+)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("/[%a%d_]+") or msg.content_.caption_:match("/(.+)") then  
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("/[%a%d_]+") or text and text:match("/(.+)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if not Special(msg) then 
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.content_.caption_:match(".[Pp][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or msg.content_.caption_:match("[Tt].[Mm][Ee]/") then 
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or text and text:match(".[Pp][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or text and text:match("[Tt].[Mm][Ee]/") and not Special(msg) then
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Special(msg) then     
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVideo' and not Special(msg) then     
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Special(msg) then     
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.game_ and not Special(msg) then     
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAudio' and not Special(msg) then     
if database:get(bot_id.."lock:Audio"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVoice' and not Special(msg) then     
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.reply_markup_ and msg.reply_markup_.ID == 'ReplyMarkupInlineKeyboard' and not Special(msg) then     
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageSticker' and not Special(msg) then     
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if tonumber(msg.via_bot_user_id_) ~= 0 and not Special(msg) then
if database:get(bot_id.."lock:inline"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.forward_info_ and not Special(msg) then     
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageDocument' and not Special(msg) then     
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageUnsupported" and not Special(msg) then      
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.entities_ then 
if msg.content_.entities_[0] then 
if msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then      
if not Special(msg) then
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end  
end 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageContact' and not Special(msg) then      
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.text_ and not Special(msg) then  
local _nl, ctrl_ = string.gsub(text, '%c', '')  
local _nl, real_ = string.gsub(text, '%d', '')   
sens = 400  
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if msg.content_.ID == 'MessageSticker' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filtersteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.set_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, " ◐ عذرا » {[@"..data.username_.."]}\n ◐ عذرا تم منع الملصق \n" ) 
else
send(msg.chat_id_,0, " ◐ عذرا » {["..data.first_name_.."](T.ME/IIIIlI8)}\n ◐ عذرا تم منع الملصق \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

------------------------------------------------------------------------

------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filterphoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ◐ عذرا » {[@"..data.username_.."]}\n ◐ عذرا تم منع الصوره \n" ) 
else
send(msg.chat_id_,0," ◐ عذرا » {["..data.first_name_.."](T.ME/IIIIlI8)}\n ◐ عذرا تم منع الصوره \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filteranimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ◐ عذرا » {[@"..data.username_.."]}\n ◐ عذرا تم منع المتحركه \n") 
else
send(msg.chat_id_,0," ◐ عذرا » {["..data.first_name_.."](T.ME/IIIIlI8)}\n ◐ عذرا تم منع المتحركه \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

if text == 'تفعيل' and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◐ عذرا يرجى ترقيه البوت مشرف !')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not SudoBot(msg) then
send(msg.chat_id_, msg.id_,' ◐ عدد اعضاء الكروب قليله يرجى جمع >> {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,' ◐ بالتأكيد تم تفعيل الكروب')
else
sendText(msg.chat_id_,'\n ◐ بواسطه » ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n ◐ تم تفعيل الكروب {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local NumMember = data.member_count_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '◐ تم تفعيل مجموعه جديده\n'..
'\n◐بواسطة {'..Name..'}'..
'\n◐ايدي المجموعه {`'..IdChat..'`}'..
'\n◐اسم المجموعه {['..NameChat..']}'..
'\n◐عدد اعضاء المجموعه *{'..NumMember..'}*'..
'\n◐الرابط {['..LinkGp..']}'
if not SudoBot(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end,nil)
end
if text == 'تعطيل' and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if not database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,' ◐ بالتأكيد تم تعطيل الكروب')
else
sendText(msg.chat_id_,'\n ◐ بواسطه » ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n ◐ تم تعطيل الكروب {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '◐ تم تعطيل مجموعه جديده\n'..
'\n◐بواسطة {'..Name..'}'..
'\n◐ايدي المجموعه {`'..IdChat..'`}'..
'\n◐اسم المجموعه {['..NameChat..']}'..
'\n◐الرابط {['..LinkGp..']}'
if not SudoBot(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end
if text == 'تفعيل' and not Sudo(msg) and not database:get(bot_id..'Free:Bots') then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◐ عذرا يرجى ترقيه البوت مشرف !')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not SudoBot(msg) then
send(msg.chat_id_, msg.id_,' ◐ عدد اعضاء الكروب قليله يرجى جمع >> {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusEditor" or da and da.status_.ID == "ChatMemberStatusCreator" then
if da and da.user_id_ == msg.sender_user_id_ then
if da.status_.ID == "ChatMemberStatusCreator" then
var = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then
var = 'مشرف'
end
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,' ◐ تم تفعيل الكروب')
else
sendText(msg.chat_id_,'\n ◐ بواسطه » ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n ◐ تم تفعيل الكروب {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)  
database:sadd(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NumMember = data.member_count_
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '◐ تم تفعيل مجموعه جديده\n'..
'\n◐ بواسطة {'..Name..'}'..
'\n◐ موقعه في المجموعه {'..AddPy..'}' ..
'\n◐ ايدي المجموعه {`'..IdChat..'`}'..
'\n◐ عدد اعضاء المجموعه *{'..NumMember..'}*'..
'\n◐ اسم المجموعه {['..NameChat..']}'..
'\n◐ الرابط {['..LinkGp..']}'
if not SudoBot(msg) then
sendText(SUDO,Text,0,'md')
end
end
end
end
end,nil)   
end,nil) 
end,nil) 
end,nil)
end
if text and text:match("^ضع عدد الاعضاء (%d+)$") and SudoBot(msg) then
local Num = text:match("ضع عدد الاعضاء (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'Num:Add:Bot',Num) 
send(msg.chat_id_, msg.id_,' ◐ تم تعيين عدد الاعضاء سيتم تفعيل الكروبات التي اعضائها اكثر من  >> {'..Num..'} عضو')
end
if text == 'تحديث السورس' and HH6HHH(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ◐ لا تستطيع استخدام البوت \n  ◐ يرجى الاشتراك بالقناه اولا \n  ◐ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
os.execute('rm -rf FoX.lua')
os.execute('wget https://raw.githubusercontent.com/Source-FoX/FoX/master/FoX.lua')
send(msg.chat_id_, msg.id_,' ↫ تم تحديث السورس \n ◐ لديك اخر اصدار لسورس فوكس ₂₀₂₁\n ◐ الاصدار ↫ F𝗼𝘅₁')
dofile('FoX.lua')  
end

if text and text:match("^تغير الاشتراك$") and HH6HHH(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, ' ◐ حسنآ ارسل لي معرف القناة')
return false  
end
if text and text:match("^تغير رساله الاشتراك$") and HH6HHH(msg) then  
database:setex(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, ' ◐ حسنآ ارسل لي النص الذي تريده')
return false  
end
if text == "حذف رساله الاشتراك ◐" and SudoBot(msg) then  
database:del(bot_id..'text:ch:user')
send(msg.chat_id_, msg.id_, " ◐ تم مسح رساله الاشتراك ")
return false  
end
if text and text:match("^وضع قناة الاشتراك ◐$") and HH6HHH(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, ' ◐ حسنآ ارسل لي معرف القناة')
return false  
end
if text == "تفعيل الاشتراك الاجباري ◐" and HH6HHH(msg) then  
if database:get(bot_id..'add:ch:id') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_," ◐ الاشتراك الاجباري مفعل \n ◐ على القناة » ["..addchusername.."]")
else
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_," ◐ اهلا عزيزي المطور \n ◐ ارسل الان معرف قناتك")
end
return false  
end
if text == "تعطيل الاشتراك الاجباري ◐" and HH6HHH(msg) then  
database:del(bot_id..'add:ch:id')
database:del(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, " ◐ تم تعطيل الاشتراك الاجباري ")
return false  
end
if text == "الاشتراك الاجباري ◐" and HH6HHH(msg) then  
if database:get(bot_id..'add:ch:username') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "◐ تم تم تفعيل الاشتراك الاجباري \n على القناة > ["..addchusername.."]")
else
send(msg.chat_id_, msg.id_, " ◐ لا يوجد قناة في الاشتراك الاجباري ")
end
return false  
end
if text == "تعطيل الزخرفه" and Manager(msg) then
send(msg.chat_id_, msg.id_, '◐ تم تعطيل الزخرفه')
database:set(bot_id.."MODEDEV:zhrf_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل الزخرفه" and Manager(msg) then
send(msg.chat_id_, msg.id_,'◐ تم تفعيل الزخرفه')
database:set(bot_id.."MODEDEV:zhrf_Bots"..msg.chat_id_,"open")
end
if text and text:match("^زخرفه (.*)$") and database:get(bot_id.."MODEDEV:zhrf_Bots"..msg.chat_id_) == "open" then
local TextZhrfa = text:match("^زخرفه (.*)$")
zh = https.request('https://ffccffgdf.ml/almty/hd.php?en='..URL.escape(TextZhrfa)..'')
zx = JSON.decode(zh)
t = "\n◐قائمه الزخرفه \n*◐○◐○◐○◐○◐ٴ*\n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.."-  `"..v.."` \n"
end
send(msg.chat_id_, msg.id_, t..'*◐○◐○◐○◐○◐ٴ*\n◐اضغط على الاسم ليتم نسخه')
end
if text == "تعطيل الابراج" and Manager(msg) then
send(msg.chat_id_, msg.id_, '*◐ تم تعطيل الابراج*')
database:set(bot_id.."MODEDEV:brj_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل الابراج" and Manager(msg) then
send(msg.chat_id_, msg.id_,'*◐ تم تفعيل الابراج*')
database:set(bot_id.."MODEDEV:brj_Bots"..msg.chat_id_,"open")
end
if text and text:match("^برج (.*)$") and database:get(bot_id.."MODEDEV:brj_Bots"..msg.chat_id_) == "open" then
local Textbrj = text:match("^برج (.*)$")
gk = https.request('https://mode-dev.tk/Api2/Modbr.php?br='..URL.escape(Textbrj)..'')
br = JSON.decode(gk)
i = 0
for k,v in pairs(br.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "تعطيل حساب العمر" and Manager(msg) then
send(msg.chat_id_, msg.id_, '*◐ تم تعطيل حساب العمر*')
database:set(bot_id.."MODEDEV:age_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل حساب العمر" and Manager(msg) then
send(msg.chat_id_, msg.id_,'*◐ تم تفعيل حساب العمر*')
database:set(bot_id.."MODEDEV:age_Bots"..msg.chat_id_,"open")
end
if text and text:match("^احسب (.*)$") and database:get(bot_id.."MODEDEV:age_Bots"..msg.chat_id_) == "open" then
local Textage = text:match("^احسب (.*)$")
ge = https.request('https://mode-dev.tk/Api1/MODEDEVapi.php?age='..URL.escape(Textage)..'')
ag = JSON.decode(ge)
i = 0
for k,v in pairs(ag.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end

if text == "تعطيل الافلام" and Mod(msg) then
send(msg.chat_id_, msg.id_, 'تم تعطيل الافلام')
database:set(bot_id.."BLACKBOTSS:movie_bot"..msg.chat_id_,"close")
end
if text == "تفعيل الافلام" and Mod(msg) then
send(msg.chat_id_, msg.id_,'تم تفعيل الافلام')
database:set(bot_id.."BLACKBOTSS:movie_bot"..msg.chat_id_,"open")
end
if text and text:match("^فلم (.*)$") and database:get(bot_id.."BLACKBOTSS:movie_bot"..msg.chat_id_) == "open" then
local Textm = text:match("^فلم (.*)$")
data,res = https.request('https://forhassan.ml/Black/movie.php?serch='..URL.escape(Textm)..'')
if res == 200 then
getmo = json:decode(data)
if getmo.Info == true then
local Text ='قصه الفلم'..getmo.info
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'مشاهده الفلم بجوده 240',url=getmo.sd}},
{{text = 'مشاهده الفلم بجوده 480', url=getmo.Web},{text = 'مشاهده الفلم بجوده 1080', url=getmo.hd}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
if text == "غنيلي" then
data,res = https.request('https://forhassan.ml/Black/audios.php')
if res == 200 then
audios = json:decode(data)
if audios.Info == true then
local done = download_to_file(audios.info,msg.sender_user_id_..'.mp3')
sendAudio(msg.chat_id_,msg.id_,'./'..msg.sender_user_id_..'.mp3','@IIIIlI8','◐غنيلي = اغاني عشوائيه اهداء من البوت◐','end')
os.execute('rm -rf ./'..msg.sender_user_id_..'.mp3') 
end
end
end
if text == "تعطيل الانستا" and Manager(msg) then
send(msg.chat_id_, msg.id_, '*◐ تم تعطيل الانستا*')
database:set(bot_id.."BLACKBOTSS:insta_bot"..msg.chat_id_,"close")
end
if text == "تفعيل الانستا" and Manager(msg) then
send(msg.chat_id_, msg.id_,'*◐ تم تفعيل الانستا*')
database:set(bot_id.."BLACKBOTSS:insta_bot"..msg.chat_id_,"open")
end
if text and text:match("^معلومات (.*)$") and database:get(bot_id.."BLACKBOTSS:insta_bot"..msg.chat_id_) == "open" then
local Textni = text:match("^معلومات (.*)$")
data,res = https.request('https://forhassan.ml/Black/insta.php?username='..URL.escape(Textni)..'')
if res == 200 then
muaed = json:decode(data)
if muaed.Info == true then
local filee = download_to_file(muaed.ph,msg.sender_user_id_..'.jpg')
sendPhoto(msg.chat_id_, msg.id_,'./'..msg.sender_user_id_..'.jpg',muaed.info)     
os.execute('rm -rf ./'..msg.sender_user_id_..'.jpg') 
end
end
end
if text and text:match("^◐تغير الاشتراك◐$") and HH6HHH(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '◐ حسنا ارسل لي معرف القناة') 
return false  
end
if text and text:match("^◐تغير رساله الاشتراك◐$") and HH6HHH(msg) then  
database:setex(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '◐ حسنا ارسل لي النص الذي تريده') 
return false  
end
if text == "◐حذف رساله الاشتراك◐" and HH6HHH(msg) then  
database:del(bot_id..'text:ch:user')
send(msg.chat_id_, msg.id_, "◐ تم مسح رساله الاشتراك ") 
return false  
end
if text and text:match("^◐وضع قناة الاشتراك◐$") and HH6HHH(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '◐ حسنا ارسل لي معرف القناة') 
return false  
end
if text == "◐تفعيل الاشتراك◐" and HH6HHH(msg) then  
if database:get(bot_id..'add:ch:id') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_,"◐ الاشتراك الاجباري مفعل \n على القناة > ["..addchusername.."]")
else
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_," لا يوجد قناة للاشتراك الاجباري")
end
return false  
end
if text == "◐تعطيل الاشتراك◐" and HH6HHH(msg) then  
database:del(bot_id..'add:ch:id')
database:del(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "◐ تم تعطيل الاشتراك الاجباري ") 
return false  
end
if text == "◐الاشتراك الاجباري◐" and mHH6HHH(msg) then  
if database:get(bot_id..'add:ch:username') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "◐ تم تم تفعيل الاشتراك الاجباري \n على القناة > ["..addchusername.."]")
else
send(msg.chat_id_, msg.id_, "◐ لا يوجد قناة في الاشتراك الاجباري ") 
end
return false  
end
if text == "تفعيل الاضافات" and HH6HHH(msg) then
send(msg.chat_id_, msg.id_, '*◐تم تفعيل الاضافات*')
database:set(bot_id.."AL:Sre:stats","✔")
end
if text == "تعطيل الاضافات" and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '*◐تم تعطيل الاضافات*')
database:set(bot_id.."AL:Sre:stats","❌")
end
if text == "الاضافات" and Constructor(msg) then
local Xx = database:get(bot_id.."AL:Sre:stats") or "لم يتم التحديد"
send(msg.chat_id_, msg.id_,"لاضافات هي :\n— — — — — — — — — \n1- كتم الاسماء \n١- كتم اسم +(اسم)\n٢-الغاء كتم اسم +(اسم)\n٣- الاسماء المكتومه\n٤- تفعيل كتم الاسم\n٥- تعطيل كتم الاسم\n— — — — — — — — — \n2- وضع توحيد \n١- وضع توحيد +(التوحيد)\n٢- تعين عدد الكتم+(العدد)\n٣- التوحيد\n٤- تفعيل التوحيد\n٥- تعطيل التوحيد \n— — — — — — — — — \n3- تنبيه الاسماء \n ۱- تفعيل تنبيه الاسماء \n ۲- تعطيل تنبيه الاسماء\n— — — — — — — — —  \n 4- تنبيه المعرف \n ١- تفعيل تنبيه المعرف \n ۲- تعطيل تنبيه المعرف\n— — — — — — — — —  \n5- تنبيه الصور \n ۱- تفعيل تنبيه الصور \n٢- تعطيل تنبيه الصور \n— — — — — — — — — \n حاله الاضافات هي : *"..Xx.."\nاذا كانت ❌ الاضافات معطله\nاذا كانت ✔ الاضافات مفعله*")
end
function bnnaGet(user_id, cb)
tdcli_function ({
ID = "GetUser",
user_id_ = user_id
}, cb, nil)
end

if database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
if text and text:match("^كتم اسم (.*)$") and Manager(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local BlNe = text:match("^كتم اسم (.*)$")
send(msg.chat_id_, msg.id_, '◐تم كتم الاسم '..BlNe)
database:sadd(bot_id.."MODEDEV:blocname"..msg.chat_id_, BlNe)
end

if text and text:match("^الغاء كتم اسم (.*)$") and Manager(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local delBn = text:match("^الغاء كتم اسم (.*)$")
send(msg.chat_id_, msg.id_, '◐تم الغاء كتم الاسم '..delBn)
database:srem(bot_id.."MODEDEV:blocname"..msg.chat_id_, delBn)
end

if text == "مسح الاسماء المكتومه" and Constructor(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
database:del(bot_id.."MODEDEV:blocname"..msg.chat_id_)
texts = "◐ تم مسح الاسماء المكتومه "
send(msg.chat_id_, msg.id_, texts)
end
if text == "الاسماء المكتومه" and Constructor(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local All_name = database:smembers(bot_id.."MODEDEV:blocname"..msg.chat_id_)
t = "\n◐قائمة الاسماء المكتومه \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ \n"
for k,v in pairs(All_name) do
t = t..""..k.."- (["..v.."])\n"
end
if #All_name == 0 then
t = "◐لا يوجد اسماء مكتومه"
end
send(msg.chat_id_, msg.id_, t)
end
end
if text == "تفعيل كتم الاسم" and Constructor(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '◐تم التفعيل سيتم كتم العضو الذي يضع الاسماء المكتومه')
database:set(bot_id.."block:name:stats"..msg.chat_id_,"open")
end
if text == "تعطيل كتم الاسم" and Constructor(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '◐تم تعطيل سيتم كتم العضو الذي يضع الاسماء المكتومه')
database:set(bot_id.."block:name:stats"..msg.chat_id_,"close")
end
if not Manager(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
function BGBBB_name(t1,t2)
if t2.id_ then 
name_Black = ((t2.first_name_ or "") .. (t2.last_name_ or ""))
if name_Black then 
names_Black = database:smembers(bot_id.."MODEDEV:blocname"..msg.chat_id_) or ""
if names_Black and names_Black[1] then 
for i=1,#names_Black do 
if name_Black:match("(.*)("..names_Black[i]..")(.*)") then 
DeleteMessage_(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
end
end
bnnaGet(msg.sender_user_id_, BGBBB_name)
end
if database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
if text and text:match("^وضع توحيد (.*)$") and Manager(msg) and database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
local teh = text:match("^وضع توحيد (.*)$")
send(msg.chat_id_, msg.id_,'◐تم تعيين '..teh..' كتوحيد للمجموعه')
database:set(bot_id.."MODEDEV:teh"..msg.chat_id_,teh)
end
if text and text:match("^تعين عدد الكتم (.*)$") and Manager(msg) and database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
local nump = text:match("^تعين عدد الكتم (.*)$")
send(msg.chat_id_, msg.id_,'◐تم تعين  '..nump..' عدد الكتم')
database:set(bot_id.."MODEDEV:nump"..msg.chat_id_,nump)
end
if text == "التوحيد" then
local s1 = database:get(bot_id.."MODEDEV:teh"..msg.chat_id_) or "لا يوجد توحيد"
local s2 = database:get(bot_id.."MODEDEV:nump"..msg.chat_id_) or 5
send(msg.chat_id_, msg.id_,'◐التوحيد هو '..s1..'\n ◐ عدد الكتم هو : '..s2)
end
end
if text == "تفعيل التوحيد" and Constructor(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '◐تم تفعيل التوحيد')
database:set(bot_id.."kt:twh:stats"..msg.chat_id_,"open")
end
if text == "تعطيل التوحيد" and Constructor(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '◐تم تعطيل التوحيد')
database:set(bot_id.."kt:twh:stats"..msg.chat_id_,"close")
end
if not Constructor(msg) then
if database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open"  and database:get(bot_id.."MODEDEV:teh"..msg.chat_id_) then 
id = msg.sender_user_id_
function keko_tsahke_new(tshake1,tshake2)
if tshake2 and tshake2.first_name_ then 
if tshake2.first_name_:match("(.*)"..database:get(bot_id.."MODEDEV:teh"..msg.chat_id_).."(.*)") then 
database:srem(bot_id.."MODEDEV:Muted:User"..msg.chat_id_, msg.sender_user_id_)
else
local tshake_nnn = database:get(bot_id.."MODEDEV:nump"..msg.chat_id_) or 5
local tshake_nnn2 = database:get(bot_id.."MODEDEV:nump22"..msg.chat_id_..msg.sender_user_id_) or 0
if (tonumber(tshake_nnn2) == tonumber(tshake_nnn) or tonumber(tshake_nnn2) > tonumber(tshake_nnn)) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_, msg.sender_user_id_)
else 
database:incrby(bot_id.."MODEDEV:nump22"..msg.chat_id_..msg.sender_user_id_,1)
send(msg.chat_id_, msg.id_, "◐عزيزي >>["..tshake2.username_.."](https://t.me/"..(tshake2.username_ or "IIIIlI8")..")\n◐عليك وضع التوحيد ⪼ {`"..database:get(bot_id.."MODEDEV:teh"..msg.chat_id_).."`} بجانب اسمك\n◐عدد المحاولات المتبقيه {"..(tonumber(tshake_nnn) - tonumber(tshake_nnn2)).."}")
end
end
end
end
bnnaGet(id, keko_tsahke_new)
end
end
if text == "تفعيل تنبيه الاسماء" and Manager(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '◐تم تفعيل تنبيه الاسماء')
database:set(bot_id.."Ttn:BBE:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه الاسماء" and Manager(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '◐تم تعطيل تنبيه الاسماء')
database:set(bot_id.."Ttn:BBE:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:BBE:stats"..msg.chat_id_) == "open" then 
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then
local MODEDEVChengName = database:get(bot_id.."MODEDEV:Cheng:Name"..data.id_)
if not data.first_name_ then 
if MODEDEVChengName then 
send(msg.chat_id_, msg.id_, " خوش معرف جان ["..MODEDEVChengName..']')
database:del(bot_id.."MODEDEV:Cheng:Name"..data.id_) 
end
end
if data.first_name_ then 
if MODEDEVChengName ~= data.first_name_ then 
local Text = {
  "جان اسمك خوش اسم ",
"ليش غيرت اسمك يحلو ",
"هذا لحلو غير اسمه ",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."MODEDEV:Cheng:Name"..data.id_, data.first_name_) 
end
end
end
end,nil)   
end
if text == "تفعيل تنبيه المعرف" and Constructor(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '◐تم تفعيل تنبيه المعرف')
database:set(bot_id.."Ttn:Userr:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه المعرف" and Constructor(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '◐تم تعطيل تنبيه المعرف')
database:set(bot_id.."Ttn:Userr:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:Userr:stats"..msg.chat_id_) == "open" then  
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then
local MODEDEVChengUserName = database:get(bot_id.."MODEDEV:Cheng:UserName"..data.id_)
if not data.username_ then 
if MODEDEVChengUserName then 
send(msg.chat_id_, msg.id_, 1, "حذف معرفه خمطو بساع بساع  \n هاذه معرفه  : [@"..MODEDEVChengUserName..']')
database:del(bot_id.."MODEDEV:Cheng:UserName"..data.id_) 
end
end
if data.username_ then 
if MODEDEVChengUserName ~= data.username_ then 
local Text = {
'شكو غيرت معرفك شنو نشروك بقنوات نحراف 🌞😹😹😹',
"هاها شو غيرت معرفك بس لا هددوك 🤞😂😂",
"شسالفه شو غيرت معرفك 😐🌝",
"غير معرفه خمطو بساع بساع \n هاذه معرفه : @"..data.username_.."",
'ها عار مو جان معرفك \n شكو غيرته ل @'..data.username_..' ',
'ها يول شو مغير معرفك', 
"منور معرف جديد : "..data.username_.."",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."MODEDEV:Cheng:UserName"..data.id_, data.username_) 
end
end
end
end,nil)   
end
if text == "تفعيل تنبيه الصور" and Manager(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '◐تم تفعيل تنبيه الصور')
database:set(bot_id.."Ttn:Ph:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه الصور" and Manager(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '◐تم تعطيل تنبيه الصور')
database:set(bot_id.."Ttn:Ph:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:Ph:stats"..msg.chat_id_) == "open" then  
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then 
local MODEDEVChengPhoto = database:get(bot_id.."MODEDEV:Cheng:Photo"..data.id_)
if not data.profile_photo_ then 
if MODEDEVChengPhoto then 
send(msg.chat_id_, msg.id_, "حذف كل صوره الحلو 😂👌🏻")
database:del(bot_id.."MODEDEV:Cheng:Photo"..data.id_) 
end
end
if data.profile_photo_.big_.persistent_id_ then 
if MODEDEVChengPhoto ~= data.profile_photo_.big_.persistent_id_ then 
local Text = {
  "شكو غيرت صورتك  يا حلو ",
  "منور طالع حلو عل صوره جديده",
  "ها شو غيرت صورتك 🤔😹",
  "شكو غيرت صورتك شنو قطيت وحده جديده 😹😹🌚",
  "شو غيرت صورتك شنو تعاركت ويه الحب ؟😹🌞",
  "شكو غيرت الصوره شسالفه ؟؟ 🤔🌞",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."MODEDEV:Cheng:Photo"..data.id_, data.profile_photo_.big_.persistent_id_) 
end
end
end
end,nil)   
end
if text == "اضف كت تويت" and HH6HHH(msg) then
database:set(bot_id.."gamebot:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"ارسل السؤال الان ")
end
if text == "حذف كت تويت" and SudoBot(msg) then
database:del(bot_id.."gamebot:List:Manager")
return send(msg.chat_id_, msg.id_,"تم حذف الاسئله")
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."gamebot:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\nتم حفظ السؤال بنجاح')
database:set(bot_id.."gamebot:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true1uu")
database:sadd(bot_id.."gamebot:List:Manager", text)
return false end
end
if text == 'كت تويت' then
local list = database:smembers(bot_id..'gamebot:List:Manager')
quschen = list[math.random(#list)]
send(msg.chat_id_, msg.id_,quschen)
end
if database:get(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) then
if text == 'الغاء' then
send(msg.chat_id_,msg.id_,"تم الغاء حفظ الرابط")       
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local Link = text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)")   
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_,"تم حفظ الرابط بنجاح")       
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
if text == 'السورس' or text == 'سورس' or text == 'يا سورس' then
Text = [[
➪︎[𝑭𝑶𝑿 𝑺𝑶𝑼𝑹𝑪𝑬 ♔︎](t.me/IIIIlI8)⏎

➪︎[𝗠𝗢𝗥𝗣𝗛𝗜𝗡𝗘𓏶](t.me/ii_t3)⏎
➪︎[D𝗲𝘃𝗲𝗹𝗼𝗽𝗲𝗿𖥎](t.me/X_GGX)⏎]]
send(msg.chat_id_, msg.id_,Text)
return false
end
if text == 'اريد بوت' or text == 'اريد مطور' or text == 'خوش سورس' or text == 'سورس فوكس' or text == 'اريد بوت تمبلر' or text == 'سورس فوكس' then
Text = [[
◐- DEV @X_GGX مبرمج بوتات◐
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
if text == 'اريد انصب بوت' or text == 'عجبني البوت' or text == 'منو منصبلك' or text == 'منو مطور السورس' or text == 'مطور السورس' or text == 'انصبلك'  or text == 'انصبلك بوت' then
Text = [[
اهلا عزيزي
متوفر تنصيب بوتات ع سورس فوكس
احدث واسرع البوتات وضمان الثقه
للاستفسار راسل المطور @X_GGX
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
if text == '@ZzZz5Z' or text == '@X_GGX' or text == '@IIIIlI8' then
Text = [[
 هذا مطور سورس فوكس
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
if text == 'رفع خزن البوت' and SudoBot(msg) then   
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n•قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile_Bot(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'جلب خزن البوت' and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n•قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
GetFile_Bot(msg)
end
if text == 'الاوامر المضافه' and Constructor(msg) then
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_..'')
t = " *◐ قائمه الاوامر المضافه  \n◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
Cmds = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
print(Cmds)
if Cmds then 
t = t..""..k..">> ("..v..") » {"..Cmds.."}\n"
else
t = t..""..k..">> ("..v..") \n"
end
end
if #list == 0 then
t = "* ◐ لا يوجد اوامر مضافه*"
end
send(msg.chat_id_, msg.id_,'['..t..']')
end
if text == 'حذف الاوامر المضافه' or text == 'مسح الاوامر المضافه' then
if Constructor(msg) then 
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
for k,v in pairs(list) do
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
database:del(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,' *◐ تم ازالة جميع الاوامر المضافه*')  
end
end
if text == 'اضف امر' and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ◐ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,' ◐ ارسل الامر القديم')  
return false
end
if text == 'حذف امر' or text == 'مسح امر' then 
if Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄??𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
database:set(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,' ◐ ارسل الامر الذي قمت بوضعه بدلا عن القديم')  
return false
end
end
if text and database:get(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
database:set(bot_id.."Set:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,' ◐ ارسل الامر الجديد')  
database:del(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
database:set(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_,'true1') 
return false
end
if text and database:get(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_) == 'true1' then
local NewCmd = database:get(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text,NewCmd)
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,' ◐ تم حفظ الامر')  
database:del(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end
if text and text:match("^تحميل (.*)$") then
                send(msg.chat_id_, msg.id_, '⌑︙ جاري ')
                local url = text:match("^تحميل (.*)$")
                local getMe = https.request('https://api.telegram.org/bot' .. token .. '/getMe')
                local get_me_json = JSON.decode(getMe)
                Get = https.request("https://planther-ash.com/API/api.php?vid=" .. url .. "&type=mp3")
                local Json_Info = JSON.decode(Get)
                if (Json_Info.url) then
                    local download = download_to_file(Json_Info.url, msg.chat_id_ .. Json_Info.vid .. '.mp3')
                    sendAudio(msg.chat_id_, msg.id_, './' .. msg.chat_id_ .. Json_Info.vid .. '.mp3', Json_Info.title,
                        '- BY : @' .. get_me_json.result.username .. ' ' .. Json_Info.MB .. ' .')
                    os.execute('rm -rf ./' .. msg.chat_id_ .. Json_Info.vid .. '.mp3')
                else
                    send(msg.chat_id_, msg.id_, "⌑︙حدث خطأ لايمكن التحميل ")
                end
            end
--------------------------------------------------------------------------------------------------------------
if text == 'قفل الدردشه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."lock:text"..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم قفـل الدردشه*\n')  
end,nil)   
elseif text == 'قفل الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:AddMempar"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم قفـل الاضافه*\n')  
end,nil)   
elseif text == 'قفل الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Join"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم قفـل الدخول*\n')  
end,nil)   
elseif text == 'قفل البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم قفـل البوتات*\n')  
end,nil)   
elseif text == 'قفل البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم قفـل البوتات بالطرد*\n')  
end,nil)   
elseif text == 'قفل الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:set(bot_id..'lock:tagservr'..msg.chat_id_,true)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم قفـل الاشعارات*\n')  
end,nil)   
elseif text == 'قفل التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id.."lockpin"..msg.chat_id_, true) 
database:sadd(bot_id..'lock:pin',msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم قفـل التثبيت*\n')  
end,nil)   
elseif text == 'قفل التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock:edit'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم قفـل التعديل*\n')  
end,nil)   
elseif text == 'قفل الفشار' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Fshar'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم قفـل الفشار*\n')  
end,nil)   
elseif text == 'قفل الازعاج' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Ansore'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم قفـل الازعاج*\n')  
end,nil)   
elseif text == 'قفل الفارسيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Fars'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم قفـل الفارسيه*\n')  
end,nil)   
elseif text == 'قفل الانلاين' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."lock:inline"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم قفـل الانلاين*\n')  
end,nil)   
elseif text == 'قفل تعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock_edit_med'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم قفـل تعطيل الميديا*\n')  
end,nil)   
elseif text == 'قفل الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagservrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم قفـل جميع الاوامر*\n')  
end,nil)   
end
if text == 'فتح الانلاين' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:inline"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم فتح الانلاين*\n')  
end,nil)   
elseif text == 'فتح الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:AddMempar"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم فتح الاضافه*\n')  
end,nil)   
elseif text == 'فتح الدردشه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id.."lock:text"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم فتح الدردشه*\n')  
end,nil)   
elseif text == 'فتح الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Join"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم فتح الدخول*\n')  
end,nil)   
elseif text == 'فتح البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم فتح البوتات*\n')  
end,nil)   
elseif text == 'فتح البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم فتح البوتات بالطرد*\n')  
end,nil)   
elseif text == 'فتح الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:del(bot_id..'lock:tagservr'..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم فتح الاشعارات*\n')  
end,nil)   
elseif text == 'فتح التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id.."lockpin"..msg.chat_id_)  
database:srem(bot_id..'lock:pin',msg.chat_id_)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم فتح التثبيت*\n')  
end,nil)   
elseif text == 'فتح التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock:edit'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم فتح التثبيت*\n')  
end,nil)   
elseif text == 'فتح الفشار' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Fshar'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم فتح الفشار*\n')  
end,nil)   
elseif text == 'فتح الازعاج' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Azag'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم فتح الازعاج*\n')  
end,nil)   
elseif text == 'فتح الفارسيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Fshar'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم فتح الفارسيه*\n')  
end,nil)   
elseif text == 'فتح تعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock_edit_med'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم فتح تعديل الميديا*\n')  
end,nil)   
elseif text == 'فتح الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagservrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم فتح الكل*\n')  
end,nil)   
end
if text == 'قفل الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الروابط*\n')  
end,nil)   
elseif text == 'قفل الروابط بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الروابط بالتقيد*\n')  
end,nil)   
elseif text == 'قفل الروابط بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الروابط بالكتم*\n')  
end,nil)   
elseif text == 'قفل الروابط بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الروابط بالطرد*\n')  
end,nil)   
elseif text == 'فتح الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Link"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح الروابط*\n')  
end,nil)   
end
if text == 'قفل المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل المعرفات*\n')  
end,nil)   
elseif text == 'قفل المعرفات بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل المعرفات بالتقيد*\n')  
end,nil)   
elseif text == 'قفل المعرفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل المعرفات بالكتم*\n')  
end,nil)   
elseif text == 'قفل المعرفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل المعرفات بالطرد*\n')  
end,nil)   
elseif text == 'فتح المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:user:name"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح المعرفات*\n')  
end,nil)   
end
if text == 'قفل التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل التاك*\n')  
end,nil)   
elseif text == 'قفل التاك بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل التاك بالتقيد*\n')  
end,nil)   
elseif text == 'قفل التاك بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل التاك بالكتم*\n◐*الحاله >الكتم*')  
end,nil)   
elseif text == 'قفل التاك بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل التاك بالطرد\n◐*الحاله >الطرد*')  
end,nil)   
elseif text == 'فتح التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:hashtak"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح التاك*\n')  
end,nil)   
end
if text == 'قفل الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*◐تم قفل الشارحه*\n')  
end,nil)
elseif text == 'قفل الشارحه بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الشارحه بالتقيد*\n')  
end,nil) 
elseif text == 'قفل الشارحه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفل الشارحه بالكتم*\n')  
end,nil)   
elseif text == 'قفل الشارحه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الشارحه بالطرد*\n')  
end,nil)   
elseif text == 'فتح الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Cmd"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح الشارحه*\n')  
end,nil)   
end
if text == 'قفل الصور' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الصور*\n')  
end,nil)   
elseif text == 'قفل الصور بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الصور بالتقيد*\n')  
end,nil)   
elseif text == 'قفل الصور بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الصور بالكتم*\n')  
end,nil)   
elseif text == 'قفل الصور بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الصور بالطرد*\n')  
end,nil)   
elseif text == 'فتح الصور' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Photo"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح الصور*\n')  
end,nil)   
end
if text == 'قفل الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الفيديو*\n')  
end,nil)   
elseif text == 'قفل الفيديو بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الفيديو بالتقيد*\n')  
end,nil)   
elseif text == 'قفل الفيديو بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الفيديو بالكتم*\n')  
end,nil)   
elseif text == 'قفل الفيديو بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الفيديو بالطرد*\n')  
end,nil)   
elseif text == 'فتح الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Video"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح الفيديو*\n')  
end,nil)   
end
if text == 'قفل المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل المتحركه*\n')  
end,nil)   
elseif text == 'قفل المتحركه بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل المتحركه بالتقيد*\n')  
end,nil)   
elseif text == 'قفل المتحركه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل المتحركه بالكتم*\n')  
end,nil)   
elseif text == 'قفل المتحركه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل المتحركه بالطرد*\n')  
end,nil)   
elseif text == 'فتح المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Animation"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح المتحركه*\n')  
end,nil)   
end
if text == 'قفل الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' بواسطه > ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الالعاب*\n')  
end,nil)   
elseif text == 'قفل الالعاب بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الالعاب بالتقيد*\n')  
end,nil)   
elseif text == 'قفل الالعاب بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الالعاب بالكتم*\n')  
end,nil)   
elseif text == 'قفل الالعاب بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الالعاب بالطرد*\n')  
end,nil)   
elseif text == 'فتح الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:geam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' بواسطه > ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح الالعاب*\n')  
end,nil)   
end
if text == 'قفل الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' بواسطه > ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الاغاني*\n')  
end,nil)   
elseif text == 'قفل الاغاني بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الاغاني بالتقيد*\n')  
end,nil)   
elseif text == 'قفل الاغاني بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الاغاني بالكتم\n')  
end,nil)   
elseif text == 'قفل الاغاني بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الاغاني بالطرد\n')  
end,nil)   
elseif text == 'فتح الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Audio"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح الاغاني*\n')  
end,nil)   
end
if text == 'قفل الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الصوت*\n')  
end,nil)   
elseif text == 'قفل الصوت بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الصوت بالتقيد*\n')  
end,nil)   
elseif text == 'قفل الصوت بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الصوت بالكتم*\n')  
end,nil)   
elseif text == 'قفل الصوت بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الصوت بالطرد*\n')  
end,nil)   
elseif text == 'فتح الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:vico"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح الصوت*\n')  
end,nil)   
end
if text == 'قفل الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الكيبورد*\n')  
end,nil)   
elseif text == 'قفل الكيبورد بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الكيبورد بالتقيد*\n')  
end,nil)   
elseif text == 'قفل الكيبورد بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الكيبورد بالكتم*\n')  
end,nil)   
elseif text == 'قفل الكيبورد بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الكيبورد بالطرد*\n')  
end,nil)   
elseif text == 'فتح الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Keyboard"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح الكيبورد*\n')  
end,nil)   
end
if text == 'قفل الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الملصقات*\n')  
end,nil)   
elseif text == 'قفل الملصقات بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الملصقات بالتقيد*\n')  
end,nil)   
elseif text == 'قفل الملصقات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الملصقات بالكتم*\n')  
end,nil)   
elseif text == 'قفل الملصقات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الملصقات بالطرد*\n')  
end,nil)   
elseif text == 'فتح الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Sticker"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح الملصقات*\n')  
end,nil)   
end
if text == 'قفل التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل التوجيه*\n')  
end,nil)   
elseif text == 'قفل التوجيه بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل التوجيه بالتقيد*\n')  
end,nil)   
elseif text == 'قفل التوجيه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل التوجيه بالكتم*\n')  
end,nil)   
elseif text == 'قفل التوجيه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل التوجيه بالطرد*\n')  
end,nil)   
elseif text == 'فتح التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:forward"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح التوجيه*\n')  
end,nil)   
end
if text == 'قفل الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' بواسطه > ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الملفات*\n')  
end,nil)   
elseif text == 'قفل الملفات بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الملفات بالتقيد*\n')  
end,nil)   
elseif text == 'قفل الملفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الملفات بالكتم*\n')  
end,nil)   
elseif text == 'قفل الملفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الملفات بالطرد*\n')  
end,nil)   
elseif text == 'فتح الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Document"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' بواسطه > ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح الملفات*\n')  
end,nil)   
end
if text == 'قفل السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل السيلفي*\n')  
end,nil)   
elseif text == 'قفل السيلفي بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل السيلفي بالتقيد*\n')  
end,nil)   
elseif text == 'قفل السيلفي بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل السيلفي بالكتم*\n')  
end,nil)   
elseif text == 'قفل السيلفي بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل السيلفي بالطرد\n')  
end,nil)   
elseif text == 'فتح السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Unsupported"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح السيلفي*\n')  
end,nil)   
end
if text == 'قفل الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الماركداون*\n')  
end,nil)   
elseif text == 'قفل الماركداون بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الماركداون بالتقيد*\n')  
end,nil)   
elseif text == 'قفل الماركداون بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الماركداون بالكتم*\n')  
end,nil)   
elseif text == 'قفل الماركداون بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الماركداون بالطرد*\n')  
end,nil)   
elseif text == 'فتح الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Markdaun"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح الماركداون*\n')  
end,nil)   
end
if text == 'قفل الاباحي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Lock:Xn"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الاباحي*\n')  
end,nil)   
elseif text == 'فتح الاباحي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Lock:Xn"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح الاباحي*\n')  
end,nil)   
end
if text == 'قفل الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الجهات*\n')  
end,nil)   
elseif text == 'قفل الجهات بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الجهات*\n')  
end,nil)   
elseif text == 'قفل الجهات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الجهات بالكتم*\n')  
end,nil)   
elseif text == 'قفل الجهات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الجهات بالطرد*\n')  
end,nil)   
elseif text == 'فتح الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Contact"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح الجهات*\n')  
end,nil)   
end
if text == 'قفل الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الكلايش*\n')  
end,nil)   
elseif text == 'قفل الكلايش بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الكلايش بالتقيد\n◐*الحاله >التقيد*')  
end,nil)   
elseif text == 'قفل الكلايش بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الكلايش بالكتم\n◐*الحاله >الكتم')  
end,nil)   
elseif text == 'قفل الكلايش بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم قفـل الكلايش بالطرد*\n◐*الحاله >الطرد*')  
end,nil)   
elseif text == 'فتح الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Spam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..')\n*◐ الاسم >* ['..utf8.sub(data.first_name_,0,15)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح الكلايش*\n')  
end,nil)   
end
if text == 'قفل التكرار بالطرد' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'kick')  
send(msg.chat_id_, msg.id_,'*تم قفل التكرار بالطرد*\n◐*الحاله >الطرد*')
elseif text == 'قفل التكرار' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'del')  
send(msg.chat_id_, msg.id_,'*تم قفل التكرار*\n')
elseif text == 'قفل التكرار بالتقيد' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'keed')  
send(msg.chat_id_, msg.id_,'*تم قفل التكرار بالتقيد*\n◐*الحاله >التقيد*')
elseif text == 'قفل التكرار بالكتم' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'mute')  
send(msg.chat_id_, msg.id_,'*تم قفل التكرار بالكتم*\n')
elseif text == 'فتح التكرار' and Mod(msg) then 
database:hdel(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood")  
send(msg.chat_id_, msg.id_,'*تم فتح التكرار*')
end 
if text == 'فتح السوبر' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tajkervrbot'..msg.chat_id_)   
list ={"lock:hashtak","lock:user:name","lock:Spam","lock:forward","lock:Cmd","lock:text","lock:Fshar","lock:Azag","lock:edit","lock:inline","lock:forward","lock:Keyboard"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح السوبر*\n')  
end,nil)   
end
if text == 'قفل السوبر' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tajkervrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*◐ الرتبه >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n*تم فتح السوبر*\n')  
end,nil)   
end
--------------------------------------------------------------------------------------------------------------
if text == 'تحديث' and HH6HHH(msg) then    
dofile('FoX.lua')  
send(msg.chat_id_, msg.id_, '*◐تمہ تحديثہ جميـع الملفاتہ◐*') 
end 
if text == ("مسح قائمه العام") and SudoBot(msg) then
database:del(bot_id..'GBan:User')
send(msg.chat_id_, msg.id_, '\n ◐ تم مسح قائمه العام')
return false
end
if text == ("قائمه العام") and SudoBot(msg) then
local list = database:smembers(bot_id..'GBan:User')
t = "\n*◐ قائمة المحظورين عام \n*◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*"..k.."- ([@"..username.."])\n*"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ◐ لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("حظر عام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']*')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "* ◐ لا يمكنك حظر المطور الاساسي \n*")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ◐ لا تسطيع حظر البوت عام*")
return false 
end
database:sadd(bot_id..'GBan:User', result.sender_user_id_)
chat_kick(result.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '*\n ◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '*\n ◐ تم حظره عام من الكروبات*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^حظر عام @(.*)$")  and SudoBot(msg) then
local username = text:match("^حظر عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']*')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"* ◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !*")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "* ◐ لا تسطيع حظر البوت عام*")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "* ◐ لا يمكنك حظر المطور الاساسي \n*")
return false 
end
usertext = '*\n ◐ العضو » *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '*\n ◐ تم حظره عام من الكروبات*'
texts = usertext..status
database:sadd(bot_id..'GBan:User', result.id_)
else
texts = '* ◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^حظر عام (%d+)$") and SudoBot(msg) then
local userid = text:match("^حظر عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']*')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "* ◐ لا يمكنك حظر المطور الاساسي \n*")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "* ◐ لا تسطيع حظر البوت عام*")
return false 
end
database:sadd(bot_id..'GBan:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '*\n ◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '*\n ◐ تم حظره عام من الكروبات*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '*\n ◐ العضو » *'..userid..''
status  = '*\n ◐ تم حظره عام من الكروبات*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("كتم عام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']*')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "* ◐ لا يمكنك كتم المطور الاساسي \n*")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "* ◐ لا تسطيع كتم البوت عام*")
return false 
end
database:sadd(bot_id..'Gmute:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '*\n ◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '*\n ◐ تم كتمه عام من الكروبات*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم عام @(.*)$")  and SudoBot(msg) then
local username = text:match("^كتم عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']*')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"* ◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !*")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "* ◐ لا تسطيع كتم البوت عام*")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "* ◐ لا يمكنك كتم المطور الاساسي \n*")
return false 
end
usertext = '*\n ◐ العضو » *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '*\n ◐ تم كتمه عام من الكروبات*'
texts = usertext..status
database:sadd(bot_id..'Gmute:User', result.id_)
else
texts = '* ◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^كتم عام (%d+)$") and SudoBot(msg) then
local userid = text:match("^كتم عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']*')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "* ◐ لا يمكنك كتم المطور الاساسي \n*")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "* ◐ لا تسطيع كتم البوت عام*")
return false 
end
database:sadd(bot_id..'Gmute:User', userid)

tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '*\n ◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '*\n ◐ تم كتمه عام من الكروبات*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '*\n ◐ العضو » *'..userid..''
status  = '*\n ◐ تم كتمه عام من الكروبات*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("الغاء العام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']*')
end
return false
end
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '*\n ◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '*\n ◐ تم الغاء (الحظر-الكتم) عام من الكروبات*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
database:srem(bot_id..'GBan:User', result.sender_user_id_)
database:srem(bot_id..'Gmute:User', result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء العام @(.*)$") and SudoBot(msg) then
local username = text:match("^الغاء العام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']*')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
usertext = '*\n ◐ العضو » *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '*\n ◐ تم الغاء (الحظر-الكتم) عام من الكروبات*'
texts = usertext..status
database:srem(bot_id..'GBan:User', result.id_)
database:srem(bot_id..'Gmute:User', result.id_)
else
texts = '* ◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^الغاء العام (%d+)$") and SudoBot(msg) then
local userid = text:match("^الغاء العام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'* ◐ لا تستطيع استخدام البوت \n  ◐ يرجى الاشتراك بالقناه اولا \n  ◐ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']*')
end
return false
end
database:srem(bot_id..'GBan:User', userid)
database:srem(bot_id..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '*\n ◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '*\n ◐ تم الغاء (الحظر-الكتم) عام من الكروبات*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '*\n ◐ العضو » *'..userid..''
status  = '*\n ◐ تم حظره عام من الكروبات*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("مسح المطورين") and SudoBot(msg) then
database:del(bot_id..'Sudo:User')
send(msg.chat_id_, msg.id_, "\n◐  تم مسح قائمة المطورين  ")
end
if text == ("المطورين") and SudoBot(msg) then
local list = database:smembers(bot_id..'Sudo:User')
t = "\n*◐ قائمة مطورين البوت \n*◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."︙"..k.." >  ([@"..username.."])\n"
else
end
end
if #list == 0 then
t = "◐ لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, t)
end

if text == 'تفعيل all' and Manager(msg) then  
if not database:get(bot_id..'my_tagname:status'..msg.chat_id_) then
database:set(bot_id..'my_tagname:status'..msg.chat_id_,true)  
Text = '\n *◐ تم تفعيل امر all*'
else
Text = '\n *◐ بالتاكيد تم تفعيل امر all*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل all' and Manager(msg) then   
if database:get(bot_id..'my_tagname:status'..msg.chat_id_) then
Text = ' *◐ تم تعطيل امر all*'
database:del(bot_id..'my_tagname:status'..msg.chat_id_)  
else
Text = '* ◐ بالتاكيد تم تعطيل امر all*'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == "all" and Manager(msg) then
local my_ali = database:get(bot_id.."my_tagname:status"..msg.chat_id_)
if not my_ali then
send(msg.chat_id_, msg.id_,"* ◐ امر all معطل*") 
return false  
end
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_},function(ta,amir)
x = 0
tags = 0
local list = amir.members_
for k, v in pairs(list) do
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
if x == 5 or x == tags or k == 0 then
tags = x + 5
t = "#all"
end
x = x + 1
tagname = data.first_name_
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")"
if x == 5 or x == tags or k == 0 then
local Text = t:gsub('#all,','#all\n')
sendText(msg.chat_id_,Text,0,'md')
end
end,nil)
end
end,nil)
end,nil)
end

if text == ("رفع مطور") and msg.reply_to_message_id_ and HH6HHH(msg) then
function start_function(extra, result, success)
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '*\n> العضو > *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '*\n> الايدي > *'..result.sender_user_id_..'* ~\n تم ترقيته مطور في البوت*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور @(.*)$") and HH6HHH(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '*\n العضو > *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '*\n تم ترقيته مطور في البوت*'
texts = usertext..status
else
texts = '*◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and HH6HHH(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '*\n> العضو > *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '*\n تم ترقيته مطور في البوت*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '*\n◐ العضو > *'..userid..''
status  = '*\n تم ترقيته مطور في البوت*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("تنزيل مطور") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '*\n> العضو > *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '*\n> الايدي > *'..result.sender_user_id_..'* ~\n تم تنزيله من المطورين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and SudoBot(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '*\n◐ العضو > *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '*\n تم تنزيله من المطورين*'
texts = usertext..status
else
texts = '*◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and SudoBot(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '*\n◐> العضو > *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '*\n تم تنزيله من المطورين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '*\n ◐  العضو > *'..userid..''
status  = '*\n تم تنزيله من المطورين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end

------------------------------------------------------------------------
if text == ("مسح المميزين عام") and SudoBot(msg) then
database:del(bot_id..'Mamez:User')
send(msg.chat_id_, msg.id_, "\n◐  تم مسح قائمة المميزين عام  ")
end
if text == ("المميز العام") and SudoBot(msg) then
local list = database:smembers(bot_id..'Mamez:User')
t = "\n*◐ قائمة مميز العام البوت \n *◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."︙"..k.." >  ([@"..username.."])\n"
else
end
end
if #list == 0 then
t = "◐ لا يوجد مميز العام"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("رفع مميز عام") and msg.reply_to_message_id_ and SudoBot(msg) then
function start_function(extra, result, success)
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Mamez:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '*\n◐ العضو > *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '*\n◐ الايدي > *'..result.sender_user_id_..' *\n تم ترقيته مميز عام في البوت*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^رفع مميز عام @(.*)$") and SudoBot(msg) then
local username = text:match("^رفع مميز عام @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !*")   
return false 
end      
database:sadd(bot_id..'Mamez:User', result.id_)
usertext = '*\n◐ العضو > *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '*\n تم ترقيته مميز عام في البوت*'
texts = usertext..status
else
texts = '*◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مميز عام (%d+)$") and SudoBot(msg) then
local userid = text:match("^رفع مميز عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
database:sadd(bot_id..'Mamez:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '*\n◐ العضو > *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '*\n تم ترقيته مميز عام في البوت*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '*\n◐ العضو > *'..userid..''
status  = '*\n تم ترقيته مميز عام في البوت*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("تنزيل مميز عام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mamez:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '*\n◐ العضو > *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '*\n◐ الايدي > *'..result.sender_user_id_..' *\n تم تنزيله من المميز العام*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^تنزيل مميز عام @(.*)$") and SudoBot(msg) then
local username = text:match("^تنزيل مميز عام @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Mamez:User', result.id_)
usertext = '*\n◐ العضو > *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '*\n تم تنزيله من المميز العام*'
texts = usertext..status
else
texts = '*◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مميز عام (%d+)$") and SudoBot(msg) then
local userid = text:match("^تنزيل مميز عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐??𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
database:srem(bot_id..'Mamez:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '*\n◐ العضو > *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '*\n تم تنزيله من المميز العام*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '*\n◐ العضو > *'..userid..''
status  = '*\n تم تنزيله من المميز العام*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
------------------------------------------------------------------------
if text == 'تنزيل الشيوخ' and Mod(msg) then
database:del(bot_id..'Mote:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '◐تم مسح جميع الشيوخ في المجموعه  ')
end
if text == ("تاك للشيوخ") and Mod(msg) then
local list = database:smembers(bot_id..'Mote:User'..msg.chat_id_)
t = "\n◐قائمة شيوخ المجموعه \nٴ◐━━━━◐━━━━◐\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*"..k.."← الشيخ [@"..username.."]\n*"
else
t = t..""..k.."← الشيخ `"..v.."`\n"
end
end
if #list == 0 then
t = "◐لا يوجد شيوخ"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع شيخ") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n◐< جط ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'◐تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'NIII55')..')'
local  statuss  = '\n◐الايدي > '..result.sender_user_id_..'\n◐تم رفع العضو شيخ في المجموعه \n◐استلم السبحه ولعكال وصير عاقل'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل شيخ")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n◐< جط ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'NIII55')..')'
status  = '\n◐الايدي > `'..result.sender_user_id_..'`\n◐تم تنزيل العضو شيخ في المجموعه\n◐تعال جيب السبحه ولعكال وسرسح'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("مسح قائمه المالك") and Sudo(msg) then
database:del(bot_id..'CoSu'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n *◐ تم مسح قائمه المالك*')
return false
end

if text == 'قائمه المالك' and Sudo(msg) then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n*◐ قائمه المالك \n◐○◐○◐○◐○◐ٴ\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*"..k.."- ([@"..username.."])\n*"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " *◐ لا يوجد احد في قائمه المالك*"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("صيح للمالك") or text == ("تاك للمالك") then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n*◐ وينكم تعالو يريدوكم بكروب \n*◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*"..k.."- {[@"..username.."]}\n*"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " *◐ لا يوجد احد في قائمه المالك*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مالك") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n* ◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n* ◐ تم ترقيته مالك*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مالك @(.*)$") and Sudo(msg) then
local username = text:match("^رفع مالك @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n *◐ العضو » *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n *◐ تم ترقيته مالك*'
texts = usertext..status
else
texts = '*◐لا يوجد حساب بهاذا المعرف◐*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع مالك (%d+)$") and Sudo(msg) then
local userid = text:match("^رفع مالك (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n*◐ تم ترقيته مالك*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*◐ العضو » *'..userid..''
status  = '\n*◐ تم ترقيته مالك*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل مالك") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n*◐ تم تنزيله من المالكين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك @(.*)$") and Sudo(msg) then
local username = text:match("^تنزيل مالك @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n*◐ العضو » *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n*◐ تم تنزيله من المالكين*'
texts = usertext..status
else
texts = '*◐لا يوجد حساب بهاذا المعرف◐*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك (%d+)$") and Sudo(msg) then
local userid = text:match("^تنزيل مالك (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n*◐ تم تنزيله من المالكين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*◐ العضو » *'..userid..''
status  = '\n*◐ تم تنزيله من المالكين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("مسح الاساسين") and CoSu(msg) then
database:del(bot_id..'Basic:Constructor'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n *◐ تم مسح المنشئين الاساسين*')
return false
end

if text == 'المنشئين الاساسين' and CoSu(msg) then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
t = "\n *◐ قائمة المنشئين الاساسين \n*◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*"..k.."- ([@"..username.."])\n*"
else
t = t.."*"..k.."- (`"..v.."`)\n*"
end
end
if #list == 0 then
t = " *◐ لا يوجد منشئين اساسين*"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("تاك للمنشئين الاساسين") or text == ("صيح المنشئين الاساسين") then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
t = "\n *◐ وينكم تعالو يريدوكم بكروب \n*◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*"..k.."- {[@"..username.."]}\n*"
else
t = t.."*"..k.."- {"..v.."}\n*"
end
end
if #list == 0 then
t = " *◐ لا يوجد منشئين اساسين*"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("رفع منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم ترقيته منشئ اساسي*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^رفع منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n *◐ العضو » *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n *◐ تم ترقيته منشئ اساسي*'
texts = usertext..status
else
texts = ' *◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^رفع منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم ترقيته منشئ اساسي*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *◐ العضو » *'..userid..''
status  = '\n *◐ تم ترقيته منشئ اساسي*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم تنزيله من الاساسيين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^تنزيل منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n *◐ العضو » *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n *◐ تم تنزيله من الاساسيين*'
texts = usertext..status
else
texts = ' *◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^تنزيل منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم تنزيله من الاساسيين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *◐ العضو » *'..userid..''
status  = '\n *◐ تم تنزيله من الاساسيين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المنشئين' and BasicConstructor(msg) then
database:del(bot_id..'Constructor'..msg.chat_id_)
texts = ' *◐ تم مسح المنشئين* '
send(msg.chat_id_, msg.id_, texts)
end

if text == ("المنشئين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n *◐ قائمة المنشئين \n*◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t.."*"..k.."- (`"..v.."`)\n*"
end
end
if #list == 0 then
t = " *◐ لا يوجد منشئين*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمنشئين") or text == ("صيح المنشئين") then
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n *◐ وينكم تعالو يريدوكم بكروب \n*◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*"..k.."- {[@"..username.."]}\n*"
else
t = t.."*"..k.."- {"..v.."}\n*"
end
end
if #list == 0 then
t = " *◐ لا يوجد منشئين*"
end
send(msg.chat_id_, msg.id_, t)
end
if text ==("المنشئ") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_," *◐ حساب المنشئ محذوف*")
return false  
end
local UserName = (b.username_ or "IIIIlI8")
send(msg.chat_id_, msg.id_," *◐ منشئ الكروب » *["..b.first_name_.."](T.me/"..UserName..")")  
end,nil)   
end
end
end,nil)   
end
if text == "رفع منشئ" and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *◐  العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم ترقيته منشئ*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^رفع منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n *◐ العضو » *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n *◐ تم ترقيته منشئ*'
texts = usertext..status
else
texts = ' *◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^رفع منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم ترقيته منشئ*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *◐  العضو » *'..userid..''
status  = '\n *◐ تم ترقيته منشئ*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
if text and text:match("^تنزيل منشئ$") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم تنزيله من المنشئين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n *◐ العضو » *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n *◐ تم تنزيله من المنشئين*'
texts = usertext..status
else
texts = ' *◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم تنزيله من المنشئين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *◐ العضو » *'..userid..''
status  = '\n *◐ تم تنزيله من المنشئين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
------------------------------------------------------------------------
if text == 'مسح المدراء' and Constructor(msg) then
database:del(bot_id..'Manager'..msg.chat_id_)
texts = ' *◐ تم مسح المدراء* '
send(msg.chat_id_, msg.id_, texts)
end
if text == ("المدراء") and Constructor(msg) then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n *◐ قائمة المدراء \n*◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*"..k.."- ([@"..username.."])\n*"
else
t = t.."*"..k.."- (`"..v.."`)\n*"
end
end
if #list == 0 then
t = " *◐ لا يوجد مدراء*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمدراء") or text == ("صيح المدراء") then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n *◐ وينكم تعالو يريدوكم بكروب \n*◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*"..k.."- {[@"..username.."]}\n*"
else
t = t.."*"..k.."- {"..v.."}\n*"
end
end
if #list == 0 then
t = " *◐ لا يوجد مدراء*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم ترقيته مدير*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^رفع مدير @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مدير @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n *◐ العضو » *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n *◐ تم ترقيته مدير*'
texts = usertext..status
else
texts = ' *◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end 
if text and text:match("^رفع مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^رفع مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم ترقيته مدير*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *◐ العضو » *'..userid..''
status  = '\n *◐ تم ترقيته مدير*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
if text == ("تنزيل مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم تنزيله من المدراء*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مدير @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n *◐ العضو » *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n *◐ تم تنزيله من المدراء*'
texts = usertext..status
else
texts = ' *◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^تنزيل مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم تنزيله من المدراء*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *◐ العضو » *'..userid..''
status  = '\n *◐ تم تنزيله من المدراء*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text ==("رفع الادمنيه") and Manager(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_," *◐ لا يوجد ادمنيه ليتم رفعهم*") 
else
send(msg.chat_id_, msg.id_," *◐ تمت ترقيه { "..num2.." } من الادمنيه*") 
end
end,nil)   
end
if text == ("رفع مطور ثانوي") and tonumber(msg.reply_to_message_id_) ~= 0 and SudoBot(msg) then
function Function_FoX(extra, result, success)
database:sadd(bot_id.."HH6HHH:Sudo", result.sender_user_id_)
Reply_Status(msg,result.sender_user_id_,"reply","◐ تم ترقيته مطور ثانوي في البوت")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_FoX, nil)
return false 
end
if text and text:match("^رفع مطور ثانوي @(.*)$") and SudoBot(msg) then
local username = text:match("^رفع مطور ثانوي @(.*)$")
function Function_FoX(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id.."HH6HHH:Sudo", result.id_)
Reply_Status(msg,result.id_,"reply","◐ تم ترقيته مطور ثانوي في البوت")  
else
send(msg.chat_id_, msg.id_,"◐ لا يوجد حساب بهاذا المعرف")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_FoX, nil)
return false 
end
if text and text:match("^رفع مطور ثانوي (%d+)$") and SudoBot(msg) then
local userid = text:match("^رفع مطور ثانوي (%d+)$")
database:sadd(bot_id.."HH6HHH:Sudo", userid)
Reply_Status(msg,userid,"reply","◐ تم ترقيته مطور ثانوي في البوت")  
return false 
end
if text == ("تنزيل مطور ثانوي") and tonumber(msg.reply_to_message_id_) ~= 0 and SudoBot(msg) then
function Function_FoX(extra, result, success)
database:srem(bot_id.."HH6HHH:Sudo", result.sender_user_id_)
Reply_Status(msg,result.sender_user_id_,"reply","◐ تم تنزيله من المطور ثانويين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_FoX, nil)
return false 
end
if text and text:match("^تنزيل مطور ثانوي @(.*)$") and SudoBot(msg) then
local username = text:match("^تنزيل مطور ثانوي @(.*)$")
function Function_FoX(extra, result, success)
if result.id_ then
database:srem(bot_id.."HH6HHH:Sudo", result.id_)
Reply_Status(msg,result.id_,"reply","◐ تم تنزيله من المطور ثانويين")  
else
send(msg.chat_id_, msg.id_,"◐ لا يوجد حساب بهاذا المعرف")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_FoX, nil)
return false
end  
if text and text:match("^تنزيل مطور ثانوي (%d+)$") and SudoBot(msg) then
local userid = text:match("^تنزيل مطور ثانوي (%d+)$")
database:srem(bot_id.."HH6HHH:Sudo", userid)
Reply_Status(msg,userid,"reply","◐ تم تنزيله من المطور ثانويين")  
return false 
end
if text == ("الثانويين") and SudoBot(msg) then
local list = database:smembers(bot_id.."HH6HHH:Sudo")
t = "\n◐ قائمة مطورين الثانويين للبوت \n ≪━━━━━━FX━━━━━━≫ \n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "◐ لا يوجد مطورين ثانويين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("مسح الثانويين") and SudoBot(msg) then
database:del(bot_id.."HH6HHH:Sudo")
send(msg.chat_id_, msg.id_, "\n◐ تم مسح قائمة المطورين الثانويين  ")
end
if text == 'مسح الادمنيه' and Manager(msg) then
database:del(bot_id..'Mod:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' *◐ تم مسح الادمنيه*')
end
if text == ("الادمنيه") and Manager(msg) then
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n *◐ قائمة الادمنيه \n*◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*"..k.."- ([@"..username.."])\n*"
else
t = t.."*"..k.."- (`"..v.."`)\n*"
end
end
if #list == 0 then
t = " *◐ لا يوجد ادمنيه*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للادمنيه") or text == ("صيح الادمنيه") then
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n *◐ وينكم تعالو يريدوكم بكروب \n*◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*"..k.."- {[@"..username.."]}\n*"
else
t = t.."*"..k.."- {"..v.."}\n*"
end
end
if #list == 0 then
t = " *◐ لا يوجد ادمنيه*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' *◐ تم تعطيل الرفع*') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم ترقيته ادمن*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن @(.*)$") and Manager(msg) then
local username = text:match("^رفع ادمن @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' *◐ تم تعطيل الرفع*') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n *◐ العضو » *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n *◐ تم ترقيته ادمن*'
texts = usertext..status
else
texts = ' *◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^رفع ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' *◐ تم تعطيل الرفع*') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم ترقيته ادمن*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *◐ العضو » *'..userid..''
status  = '\n *◐ تم ترقيته ادمن*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم تنزيله من الادمنيه*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن @(.*)$") and Manager(msg) then
local username = text:match("^تنزيل ادمن @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n *◐ العضو » *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n *◐ تم تنزيله من الادمنيه*'
texts = usertext..status
else
texts = ' *◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^تنزيل ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم تنزيله من الادمنيه*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *◐ العضو » *'..userid..''
status  = '\n *◐ تم تنزيله من الادمنيه*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

------------------------------------------------------------------------
if text == ("طرد") and msg.reply_to_message_id_ ~=0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝑾??𝒍𝒄𝒐𝒎𝒆 𝒏𝒊𝒈𝒈𝒂 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'◐ تم تعطيل الطرد من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◐ لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'◐ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐ العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') ~'
statusk  = '\n◐ الايدي > `'..result.sender_user_id_..'` \n تم طرد العضو من هنا'
send(msg.chat_id_, msg.id_, usertext..statusk)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^طرد @(.*)$") and Mod(msg) then 
local username = text:match("^طرد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'◐ تم تعطيل الطرد من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◐لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'◐ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
usertext = '\n◐العضو > ['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
statusk  = '\n تم طرد العضو من هنا'
texts = usertext..statusk
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '◐ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  

if text and text:match("^طرد (%d+)$") and Mod(msg) then 
local userid = text:match("^طرد (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝒏??𝒈𝒈𝒂 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'◐ تم تعطيل الطرد من قبل المنشئين') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◐ لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'◐ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
chat_kick(msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
 usertext = '\n◐ العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') ~'
 statusk  = '\n تم طرد العضو من هنا'
send(msg.chat_id_, msg.id_, usertext..statusk)
else
 usertext = '\n◐ العضو > '..userid..''
 statusk  = '\n تم طرده من هنا'
send(msg.chat_id_, msg.id_, usertext..statusk)
end;end,nil)
end,nil)   
end
return false
end
------------------------------------------------------------------------
------------------------------------------------------------------------
if text == 'مسح المميزين' and Mod(msg) then
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' *◐ تم مسح المميزين*')
end
if text == ("المميزين") and Mod(msg) then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n *◐ قائمة مميزين الكروب \n*◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*"..k.."- ([@"..username.."])\n*"
else
t = t.."*"..k.."- (`"..v.."`)\n*"
end
end
if #list == 0 then
t = " *◐ لا يوجد مميزين*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمميزين") or text == ("صيح المميزين") then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n *◐ وينكم تعالو يريدوكم بكروب \n*◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*"..k.."- {[@"..username.."]}\n*"
else
t = t.."*"..k.."- {"..v.."}\n*"
end
end
if #list == 0 then
t = "* ◐ لا يوجد مميزين*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◐ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
local  statuss  = '\n *◐ تم ترقيته مميز*'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مميز @(.*)$") and Mod(msg) then
local username = text:match("^رفع مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◐ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n* ◐ العضو » *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
local  statuss  = '\n *◐ تم ترقيته مميز*'
texts = usertext..statuss
else
texts = '* ◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^رفع مميز (%d+)$") and Mod(msg) then
local userid = text:match("^رفع مميز (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◐ تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
local  statuss  = '\n *◐ تم ترقيته مميز*'
send(msg.chat_id_, msg.id_, usertext..statuss)
else
usertext = '\n *◐ العضو » *'..userid..''
local  statuss  = '\n *◐ تم ترقيته مميز*'
send(msg.chat_id_, msg.id_, usertext..statuss)
end;end,nil)
return false
end

if (text == ("تنزيل مميز")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم تنزيله من المميزين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز @(.*)$") and Mod(msg) then
local username = text:match("^تنزيل مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n* ◐ العضو » *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n* ◐ تم تنزيله من المميزين*'
texts = usertext..status
else
texts = '*◐ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز (%d+)$") and Mod(msg) then
local userid = text:match("^تنزيل مميز (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *◐ لعضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n *◐ تم تنزيله من المميزين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *◐ العضو » *'..userid..''
status  = '\n *◐ تم تنزيله من المميزين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end    
------------------------------------------------------------------------
if text == ("تاك للمطايه") and Mod(msg) then
local list = database:smembers(bot_id..'Mote:User'..msg.chat_id_)
t = "\n*◐يمطاية تعالو يردونكم 😹😭💞 . \n◐━━━━◐━━━━◐\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*︙"..k.."︙> [@"..username.."]◐\n*"
else
end
end
if #list == 0 then
t = "◐لايوجد مطايةه 😹😔💞"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع مطي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐تم رفع العضو مطي في المجموعة 😭😹💞'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل مطي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐تم تنزيل العضو مطي في المجموعة 😭😹💞'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("تاك للثولان") and Mod(msg) then
local list = database:smembers(bot_id..'Athol:User'..msg.chat_id_)
t = "\n*◐ياثولان تعالو يردونكم 😹😭💞 . \n◐━━━━◐━━━━◐\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*︙"..k.."︙> [@"..username.."]◐\n*"
else
end
end
if #list == 0 then
t = "◐لايوجد ثولان😹😔💞"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع اثول") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Athol:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐تم رفع العضو اثول في المجموعة 😭😹💞'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل اثول")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Athol:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐تم تنزيل العضو اثول في المجموعة 😭😹💞'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("تاك للانبياء") and Mod(msg) then
local list = database:smembers(bot_id..'Naby:User'..msg.chat_id_)
t = "\n*◐يا انبياء تعالو يردونكم 😹😭💞 . \n◐━━━━◐━━━━◐\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*︙"..k.."︙> [@"..username.."]◐\n*"
else
end
end
if #list == 0 then
t = "◐لايوجد انبياء 😹😔💞"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع نبي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Naby:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐رفعتلكم نبي جديد استقبلو 😹😭💞'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل نبي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| < جط ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Naby:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐متستاهل النبوه نزلتك 😹😭💞'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل العروسات' and Mod(msg) then
database:del(bot_id..'Tele:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '◐تم تنزيل جميع العروسات بالمجموعه ')
end
if text == ("تاك للعروسات") and Mod(msg) then
local list = database:smembers(bot_id..'Tele:User'..msg.chat_id_)
t = "\n*◐قائمه عروسات المجموعه \nٴ◐━━━━◐━━━━◐\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← عروسه [@"..username.."]\n"
else
t = t..""..k.."← عروسه "..v.."\n"
end
end
if #list == 0 then
t = "◐لا يوجد عروسه"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع عروسه") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n◐< جط ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'◐ تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Tele:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'NIII55')..')'
local  statuss  = '\n◐الايدي > `'..result.sender_user_id_..'`\n◐تم رفع العضو عروسه\n◐افيششش عروستنه لصاكه'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل عروسه")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n◐< جط ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Tele:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'NIII55')..')'
status  = '\n◐الايدي > `'..result.sender_user_id_..'`\n◐تم تنزيل العضو عروسه\n◐طلعي من قائمه العروسات لجج'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل الحاتات' and Mod(msg) then
database:del(bot_id..'Mode:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' تم مسح جميع الحاتات')
end
if text == ("تاك للحاتات") and Mod(msg) then
local list = database:smembers(bot_id..'Mode:User'..msg.chat_id_)
t = "\n*◐قائمه حاتات المجموعه \nٴ◐━━━━◐━━━━◐\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."> الحاته [@"..username.."]\n"
else
t = t..""..k.."> الحاته `"..v.."`\n"
end
end
if #list == 0 then
t = "مع الاسف لا يوجد حاته"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع حاته") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n◐< جط ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'NIII55')..')'
local  statuss  = '\n تم رفع العضــو الحاته في الكروب \n◐تعال يحاته ممكن نتعرف'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل حاته")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n◐< جط ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'NIII55')..')'
status  = '\n تم تنزيل العضــو الحاته من الكروب\n◐مشيي مو خوش حاتهه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل الحاتين' and Mod(msg) then
database:del(bot_id..'Modde:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, 'تم مسح جميع الحاتين')
end
if text == ("تاك للحاتين") and Mod(msg) then
local list = database:smembers(bot_id..'Modde:User'..msg.chat_id_)
t = "\n*◐قائمه حاتين المجموعه \nٴ◐━━━━◐━━━━◐\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*"..k.."> الحات [@"..username.."]\n*"
else
t = t..""..k.."> الحات `"..v.."`\n"
end
end
if #list == 0 then
t = "مع الاسف لا يوجد حات"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع حات") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n◐< جط ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Modde:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'NIII55')..')'
local  statuss  = '\n تم رفع العضــو الحات في الكروب \n◐تعال حبي الحات نطيني بوسه'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل الحاتين")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n◐< جط ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Modde:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'NIII55')..')'
status  = '\n تم تنزيل العضــو الحات من الكروب\n◐مشيي مو خوش حات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("تاك للصخول") and Mod(msg) then
local list = database:smembers(bot_id..'Zgal:User'..msg.chat_id_)
t = "\n◐ياصخول تعالو يردونكم 😹😭💞 . \n◐━━━━◐━━━━◐\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*︙"..k.."︙> [@"..username.."]◐\n*"
else
end
end
if #list == 0 then
t = "◐لايوجد صخول 😹😔💞"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع صخل") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zgal:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐تم رفع العضو صخل في المجموعة 😭😹💞'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل صخل")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zgal:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data)
usertext = '\n◐تم تنزيل العضو صخل في المجموعة 😭😹💞'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("تاك للجلاب") and Mod(msg) then
local list = database:smembers(bot_id..'Glb:User'..msg.chat_id_)
t = "\n◐ياجلاب تعالو يردونكم 😹😭💞 . \n◐━━━━◐━━━━◐\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*︙"..k.."︙> [@"..username.."]◐\n*"
else
end
end
if #list == 0 then
t = "◐لايوجد جلاب 😹😔💞"
end
end
---------
if text == ("رفع جلب") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Glb:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐تم رفع العضو جلب في المجموعة 😭😹💞'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل جلب")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Glb:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐تم تنزيل العضو جلب في المجموعة 😭😹💞'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("تاك للزواحيف") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n◐يازواحيف تعالو يردونكم 😹😭💞 . \n◐━━━━◐━━━━◐\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*︙"..k.."︙> [@"..username.."]◐\n*"
else
end
end
if #list == 0 then
t = "◐لايوجد زواحيف 😹😔💞"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع زاحف") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐تم رفع العضو زاحف في المجموعة 😭😹💞'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل زاحف")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐تم تنزيل العضو زاحف في المجموعة 😭😹💞'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("تاك للي بكلبي") and Mod(msg) then
local list = database:smembers(bot_id..'Galby:User'..msg.chat_id_)
t = "\n◐ياكلوب تعالو يردونكم 😹😭💞 . \n◐━━━━◐━━━━◐\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*︙"..k.."︙> [@"..username.."]◐\n*"
else
end
end
if #list == 0 then
t = "◐لايوجد كلوب 😹😔💞"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع بكلبي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Galby:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐رفعتك بكلبي لتجرحني 😘😭💞'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if (text == ("تنزيل بكلبي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| < جط ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Galby:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐مو كتلك لتجرحني نزلتك من كلبي 😭💞'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("تاك للتوج") and Mod(msg) then
local list = database:smembers(bot_id..'Tag:User'..msg.chat_id_)
t = "\n◐ياتوج تعالو يردونكم 😹😭💞 . \n◐━━━━◐━━━━◐\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."*︙"..k.."︙> [@"..username.."]◐\n*"
else
end
end
if #list == 0 then
t = "◐لايوجد تاج😹😔💞"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع تاج") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Tag:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐هو تاج ميحتاج ارفعه 🤴🏻💞'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل تاج")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎?? 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Tag:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐التاج ماينزل من مكانه 🤴🏻💞'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("زواج") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zoag:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐نزوج وماتباوع على غيري 🥺💞'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text == ("طلاق") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎?? ??𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐طالق طالق طالق بالعشرة 😹😭💞'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المحظورين' and Mod(msg) then
database:del(bot_id..'Ban:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n ◐  تم مسح المحظورين')
end
if text == ("المحظورين") then
local list = database:smembers(bot_id..'Ban:User'..msg.chat_id_)
t = "\n◐ قائمة محظورين المجموعه \n *◐○◐○◐○◐○◐ٴ*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "◐ لا يوجد محظورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("حظر") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'◐ تم تعطيل الحظر من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◐ لا تسطيع حظر البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'◐ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐ العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '\n◐ الايدي > '..result.sender_user_id_..' \n تم حظره من المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text and text:match("^حظر @(.*)$") and Mod(msg) then
local username = text:match("^حظر @(.*)$")
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'◐تم تعطيل الحظر من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'◐ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.id_)
usertext = '\n◐ المستخدم > ['..result.title_..'](t.me/'..(username or 'GLOBLA')..')'
status  = '\n تم حظره من المجموعه'
texts = usertext..status
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '◐  لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^حظر (%d+)$") and Mod(msg) then
local userid = text:match("^حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'◐ تم تعطيل حظر من قبل المنشئين') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◐ لا تسطيع حظر البوت")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'◐ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, userid)
chat_kick(msg.chat_id_, userid)  
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n◐> العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') ~'
status  = '\n تم حظره من المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n◐ العضو > '..userid..''
status  = '\n تم حظره من المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end,nil)   
end
return false
end
if text == ("الغاء حظر") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, ' انا لست محظورا \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐ العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '\n◐ الايدي > '..result.sender_user_id_..' \n تم الغاء حظره من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
 
if text and text:match("^الغاء حظر @(.*)$") and Mod(msg) then
local username = text:match("^الغاء حظر @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, ' انا لست محظورا \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
usertext = '\n◐ العضو > ['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n تم الغاء حظره من هنا'
texts = usertext..status
else
texts = '◐ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء حظر (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, ' انا لست محظورا \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, userid)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n◐ العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') ~'
status  = '\n تم الغاء حظره من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n◐ لعضو > '..userid..''
status  = '\n تم الغاء حظره من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المكتومين' and Mod(msg) then
database:del(bot_id..'Muted:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '◐  تم مسح قائمه المكتومين ')
end
if text == ("المكتومين") and Mod(msg) then
local list = database:smembers(bot_id..'Muted:User'..msg.chat_id_)
t = "\n قائمة المكتومين \n *◐○◐○◐○◐○◐ٴ*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
end
end
if #list == 0 then
t = "◐  لا يوجد مكتومين"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("كتم") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◐ لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐ العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
status  = '\n◐  الايدي > `'..result.sender_user_id_..'`\n تم كتمه من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم @(.*)$") and Mod(msg) then
local username = text:match("^كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ◐ < جط ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◐ لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n◐ العضو > ['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n تم كتمه من هنا'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
end
else
send(msg.chat_id_, msg.id_, '◐ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match('^كتم (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐> العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') ~'
status  = '\n تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^كتم (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n◐ العضو > ['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n◐ تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
if text and text:match("^كتم (%d+)$") and Mod(msg) then
local userid = text:match("^كتم (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◐ لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( '..Rutba(userid,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n◐> العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') ~'
status  = '\n تم كتمه من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n◐ العضو > '..userid..''
status  = '\n تم كتمه من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
if text == ("الغاء الكتم") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐> العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') ~'
status  = '\n◐> الايدي > '..result.sender_user_id_..' ~\n تم الغاء الكتم من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء الكتم @(.*)$") and Mod(msg) then
local username = text:match("^الغاء الكتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ◐ < جط ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n◐ العضو > ['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n تم الغاء الكتم من هنا'
texts = usertext..status
else
texts = '◐ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء الكتم (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء الكتم (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
database:srem(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n◐> العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') ~'
status  = '\n تم الغاء الكتم من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n◐ العضو > '..userid..''
status  = '\n تم الغاء الكتم من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("الغاء كتم") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐> العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') ~'
status  = '\n◐> الايدي > '..result.sender_user_id_..' ~\n تم الغاء الكتم من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء كتم @(.*)$") and Mod(msg) then
local username = text:match("^الغاء كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ◐ < جط ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n◐ العضو > ['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n تم الغاء الكتم من هنا'
texts = usertext..status
else
texts = '◐ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء كتم (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء كتم (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
database:srem(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n◐> العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') ~'
status  = '\n تم الغاء الكتم من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n◐ العضو > '..userid..''
status  = '\n تم الغاء الكتم من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

if text == ("تقيد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◐ لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐ العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '\n◐ الايدي > '..result.sender_user_id_..' \n تم تقيده في المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد @(.*)$") and Mod(msg) then
local username = text:match("^تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◐ لا تسطيع تقيد البوت ")
return false 
end
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( '..Rutba(result.id_,msg.chat_id_)..' )')
return false 
end      
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
 
usertext = '\n◐ العضو > ['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n تم تقيده في المجموعه'
texts = usertext..status
else
texts = '◐ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match('^تقيد (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐> العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') ~'
status  = '\n◐ تم تقيده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^تقيد (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n◐ العضو > ['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n◐ تم تقيده لمدة  { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◐ لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n◐ عذرا لا تستطيع طرد او حظر او كتم او تقيد ( '..Rutba(userid,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n◐ العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') ~'
status  = '\n تم تقيده في المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n◐ العضو > '..userid..''
status  = '\n تم تقيده في المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
------------------------------------------------------------------------
if text == ("الغاء التقيد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐ العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '\n◐ الايدي > '..result.sender_user_id_..' \n تم فك تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text == ("الغاء تقيد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐ العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '\n◐ الايدي > '..result.sender_user_id_..' \n تم فك تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء التقيد @(.*)$") and Mod(msg) then
local username = text:match("^الغاء التقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
usertext = '\n◐ العضو > ['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n تم فك تقيده'
texts = usertext..status
else
texts = '◐ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^الغاء تقيد @(.*)$") and Mod(msg) then
local username = text:match("^الغاء تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
usertext = '\n◐ العضو > ['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n تم فك تقيده'
texts = usertext..status
else
texts = '◐ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^فك تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^فك تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n◐ العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '\n تم فك تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n◐ العضو > '..userid..''
status  = '\n تم فك تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text and text:match('^رفع القيود @(.*)') and Manager(msg) then 
local username = text:match('^رفع القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if SudoBot(msg) then
database:srem(bot_id..'GBan:User',result.id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Gmute:User'..msg.chat_id_,result.id_)
usertext = '\n◐ العضو > ['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n تم الغاء القيود عنه'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
usertext = '\n◐ العضو > ['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '\n تم الغاء القيود عنه'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
end
else
Text = '◐ المعرف غلط'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == "رفع القيود" and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
if SudoBot(msg) then
database:srem(bot_id..'GBan:User',result.sender_user_id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐> العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') ~'
status  = '\n◐> الايدي > '..result.sender_user_id_..' ~\n تم الغاء القيود عنه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐> العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') ~'
status  = '\n◐> الايدي > '..result.sender_user_id_..' ~\n تم الغاء القيود عنه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match('^كشف القيود @(.*)') and Manager(msg) then 
local username = text:match('^كشف القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.id_) then
Muted = '*مكتوم*'
else
Muted = '*غير مكتوم*'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.id_) then
Ban = '*محظور*'
else
Ban = '*غير محظور*'
end
if database:sismember(bot_id..'GBan:User',result.id_) then
GBan = '*محظور عام*'
else
GBan = '*غير محظور عام*'
end
Textt = "*◐ الحظر العام > *"..GBan.."\n*◐ الحظر > *"..Ban.."\n*◐ الكتم > *"..Muted..""
send(msg.chat_id_, msg.id_,Textt)
else
Text = '*◐ المعرف غلط*'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end

if text == "كشف القيود" and Manager(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_) then
Muted = '*مكتوم*'
else
Muted = '*غير مكتوم*'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_) then
Ban = '*محظور*'
else
Ban = '*غير محظور*'
end
if database:sismember(bot_id..'GBan:User',result.sender_user_id_) then
GBan = '*محظور عام*'
else
GBan = '*غير محظور عام*'
end
if database:sismember(bot_id..'Gmute:User',result.sender_user_id_) then
Gmute = '*محظور عام*'
else
Gmute = '*غير محظور عام*'
end
Textt = "*◐ الحظر العام > *"..GBan.."\n*◐ الكتم العام > *"..Gmute.."\n*◐ الحظر > *"..Ban.."\n *الكتم > *"..Muted..""
send(msg.chat_id_, msg.id_,Textt)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text == ("رفع مشرف") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '*\n◐ العضو >* ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '*\n◐ الايدي >* '..result.sender_user_id_..' ~\n *تم رفعه مشرف بالمجموعه *'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مشرف @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '*\n◐ العضو > *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '*\n تم رفعه مشرف بالمجموعه *'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '*◐ لا يوجد حساب بهاذا المعرف*')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل مشرف") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '*\n◐ العضو > *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '*\n◐ الايدي > *'..result.sender_user_id_..' ~\n *تم تنزيله ادمن من المجموعه*'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مشرف @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '*\n◐ العضو > *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '*\n تم تنزيله مشرف من المجموعه*'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '*◐ لا يوجد حساب بهاذا المعرف*')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end



if text == ("رفع مالك") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '*\n◐ العضو > *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '*\n◐ الايدي > *'..result.sender_user_id_..' \n* تم رفع العضو مالك المجموعه*'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^مالك @(.*)$") and BasicConstructor(msg) then
local username = text:match("^مالك @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '*\n◐ العضو > *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '*\n تم رفع العضو مالك*'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
else
send(msg.chat_id_, msg.id_, '◐ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل مالك") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '*\n◐ العضو > *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..') '
status  = '*\n◐ الايدي > *'..result.sender_user_id_..' \n *تم تنزيله تنزيل مالك من المجموعه بكل الصلاحيات*'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل مالك @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◐ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '*\n◐ العضو > *['..result.title_..'](t.me/'..(username or 'IIIIlI8')..')'
status  = '*\n تم رفع عضو مالك*'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '◐ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == 'اعدادات الكروب' and Mod(msg) then    
if database:get(bot_id..'lockpin'..msg.chat_id_) then    
lock_pin = '✓'
else 
lock_pin = '✘'    
end
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then    
lock_tagservr = '✓'
else 
lock_tagservr = '✘'    
end
if database:get(bot_id..'lock:text'..msg.chat_id_) then    
lock_text = '✓'
else 
lock_text = '✘'    
end
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
lock_add = '✓'
else 
lock_add = '✘'    
end    
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
lock_join = '✓'
else 
lock_join = '✘'    
end    
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit = '✓'
else 
lock_edit = '✘'    
end
print(welcome)
if database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_) then
welcome = '✓'
else 
welcome = '✘'    
end
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit_med = '✓'
else 
lock_edit_med = '✘'    
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_, "flood") == "kick" then     
flood = 'بالطرد'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "keed" then     
flood = 'بالتقيد'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "mute" then     
flood = 'بالكتم'           
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "del" then     
flood = 'بالمسح'           
else     
flood = '✘'     
end
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
lock_photo = '✓' 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then 
lock_photo = 'بالتقيد'   
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then 
lock_photo = 'بالكتم'    
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then 
lock_photo = 'بالطرد'   
else
lock_photo = '✘'   
end    
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
lock_phon = '✓' 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then 
lock_phon = 'بالتقيد'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then 
lock_phon = 'بالكتم'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then 
lock_phon = 'بالطرد'    
else
lock_phon = '✘'    
end    
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" then
lock_links = '✓'
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" then
lock_links = 'بالتقيد'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" then
lock_links = 'بالكتم'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" then
lock_links = 'بالطرد'    
else
lock_links = '✘'    
end
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" then
lock_cmds = '✓'
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" then
lock_cmds = 'بالتقيد'    
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" then
lock_cmds = 'بالكتم'   
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" then
lock_cmds = 'بالطرد'    
else
lock_cmds = '✘'    
end
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" then
lock_user = '✓'
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" then
lock_user = 'بالتقيد'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" then
lock_user = 'بالكتم'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" then
lock_user = 'بالطرد'    
else
lock_user = '✘'    
end
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" then
lock_hash = '✓'
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" then 
lock_hash = 'بالتقيد'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" then 
lock_hash = 'بالكتم'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" then 
lock_hash = 'بالطرد'    
else
lock_hash = '✘'    
end
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_muse = '✓'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_muse = 'بالتقيد'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_muse = 'بالكتم'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_muse = 'بالطرد'    
else
lock_muse = '✘'    
end 
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
lock_ved = '✓'
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then 
lock_ved = 'بالتقيد'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then 
lock_ved = 'بالكتم'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then 
lock_ved = 'بالطرد'    
else
lock_ved = '✘'    
end
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
lock_gif = '✓'
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then 
lock_gif = 'بالتقيد'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then 
lock_gif = 'بالكتم'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then 
lock_gif = 'بالطرد'    
else
lock_gif = '✘'    
end
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
lock_ste = '✓'
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then 
lock_ste = 'بالتقيد'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then 
lock_ste = 'بالكتم'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then 
lock_ste = 'بالطرد'    
else
lock_ste = '✘'    
end
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
lock_geam = '✓'
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then 
lock_geam = 'بالتقيد'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then 
lock_geam = 'بالكتم'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then 
lock_geam = 'بالطرد'    
else
lock_geam = '✘'    
end    
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_vico = '✓'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_vico = 'بالتقيد'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_vico = 'بالكتم'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_vico = 'بالطرد'    
else
lock_vico = '✘'    
end    
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
lock_inlin = '✓'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then 
lock_inlin = 'بالتقيد'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then 
lock_inlin = 'بالكتم'    
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then 
lock_inlin = 'بالطرد'
else
lock_inlin = '✘'
end
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
lock_fwd = '✓'
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then 
lock_fwd = 'بالتقيد'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then 
lock_fwd = 'بالكتم'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then 
lock_fwd = 'بالطرد'    
else
lock_fwd = '✘'    
end    
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
lock_file = '✓'
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then 
lock_file = 'بالتقيد'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then 
lock_file = 'بالكتم'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then 
lock_file = 'بالطرد'    
else
lock_file = '✘'    
end    
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
lock_self = '✓'
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then 
lock_self = 'بالتقيد'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then 
lock_self = 'بالكتم'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then 
lock_self = 'بالطرد'    
else
lock_self = '✘'    
end
if database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'del' then
lock_bots = '✓'
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'ked' then
lock_bots = 'بالتقيد'   
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'kick' then
lock_bots = 'بالطرد'    
else
lock_bots = '✘'    
end
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
lock_mark = '✓'
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then 
lock_mark = 'بالتقيد'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then 
lock_mark = 'بالكتم'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then 
lock_mark = 'بالطرد'    
else
lock_mark = '✘'    
end
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" then    
lock_spam = '✓'
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" then 
lock_spam = 'بالتقيد'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" then 
lock_spam = 'بالكتم'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" then 
lock_spam = 'بالطرد'    
else
lock_spam = '✘'    
end        
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
rdmder = '✓'
else
rdmder = '✘'
end
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
rdsudo = '✓'
else
rdsudo = '✘'
end
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
idgp = '✓'
else
idgp = '✘'
end
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then
idph = '✓'
else
idph = '✘'
end
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
setadd = '✓'
else
setadd = '✘'
end
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
banm = '✓'
else
banm = '✘'
end
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
addme = '✓'
else
addme = '✘'
end
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
sehuser = '✓'
else
sehuser = '✘'
end
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
kickme = '✓'
else
kickme = '✘'
end
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 0
local text = 
'\n ◐ اعدادات الكروب كتالي √↓'..
'\n*ٴ◐○◐○◐○◐○◐*'..
'\n ◐  علامة ال {✓} تعني معطل'..
'\n ◐  علامة ال {✘} تعني مفعل'..
'\n*ٴ◐○◐○◐○◐○◐*'..
'\n ◐  الروابط » { '..lock_links..
' }\n'..' ◐  المعرفات » { '..lock_user..
' }\n'..' ◐  التاك » { '..lock_hash..
' }\n'..' ◐  البوتات » { '..lock_bots..
' }\n'..' ◐  التوجيه » { '..lock_fwd..
' }\n'..' ◐  التثبيت » { '..lock_pin..
' }\n'..' ◐  الاشعارات » { '..lock_tagservr..
' }\n'..' ◐  الماركدون » { '..lock_mark..
' }\n'..' ◐  التعديل » { '..lock_edit..
' }\n'..' ◐  تعديل الميديا » { '..lock_edit_med..
' }\n*ٴ◐○◐○◐○◐○◐*'..
'\n'..' ◐  الكلايش » { '..lock_spam..
' }\n'..' ◐  الكيبورد » { '..lock_inlin..
' }\n'..' ◐  الاغاني » { '..lock_vico..
' }\n'..' ◐  المتحركه » { '..lock_gif..
' }\n'..' ◐  الملفات » { '..lock_file..
' }\n'..' ◐  الدردشه » { '..lock_text..
' }\n'..' ◐   الفيديو » { '..lock_ved..
' }\n'..' ◐   الصور » { '..lock_photo..
' }\n*ٴ◐○◐○◐○◐○◐*'..
'\n'..' ◐   الصوت » { '..lock_muse..
' }\n'..' ◐  الملصقات » { '..lock_ste..
' }\n'..' ◐  الجهات » { '..lock_phon..
' }\n'..' ◐  الدخول » { '..lock_join..
' }\n'..' ◐  الاضافه » { '..lock_add..
' }\n'..' ◐  السيلفي » { '..lock_self..
' }\n'..' ◐  الالعاب » { '..lock_geam..
' }\n'..' ◐  التكرار » { '..flood..
' }\n'..' ◐  الترحيب » { '..welcome..
' }\n'..' ◐  عدد التكرار » { '..NUM_MSG_MAX..
' }\n*ٴ◐○◐○◐○◐○◐*'..
'\n ◐  علامة ال {✓} تعني مفعل'..
'\n ◐  علامة ال {✘} تعني معطل'..
'\n*ٴ◐○◐○◐○◐○◐*'..
'\n'..' ◐  امر صيح » { '..kickme..
' }\n'..' ◐  امر اطردني » { '..sehuser..
' }\n'..' ◐  امر منو ضافني » { '..addme..
' }\n'..' ◐  ردود المدير » { '..rdmder..
' }\n'..' ◐  ردود المطور » { '..rdsudo..
' }\n'..' ◐  الايدي » { '..idgp..
' }\n'..' ◐  الايدي بالصوره » { '..idph..
' }\n'..' ◐  الرفع » { '..setadd..
' }\n'..' ◐  الحظر » { '..banm..' }\n\n*ٴ◐○◐○◐○◐○◐*\n 𝘊𝘩 - [𝖋𝖔𝖝  𓅛](t.me/IIIIlI8)◐\n'
send(msg.chat_id_, msg.id_,text)     
end
if text ==('تثبيت') and msg.reply_to_message_id_ ~= 0 and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"* ◐ عذرآ تم قفل التثبيت*")  
return false  
end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"* ◐ تم تثبيت الرساله*")   
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.reply_to_message_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," *◐ انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله*")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," *◐ لا توجد رساله مثبته*")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"* ◐ ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات*")  
end
end,nil) 
end
if text == 'الغاء التثبيت' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"* ◐ عذرآ تم قفل الثبيت*")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_," *◐ تم الغاء تثبيت الرساله*")   
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," *◐ انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله*")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," *◐ لا توجد رساله مثبته*")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," *◐ ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات*")  
end
end,nil)
end
if text == 'الغاء تثبيت الكل' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"* ◐ عذرآ تم قفل الثبيت*")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"*◐ تم الغاء تثبيت الكل*")   
https.request('https://api.telegram.org/bot'..token..'/unpinAllChatMessages?chat_id='..msg.chat_id_)
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," *◐ انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله*")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," *◐ لا توجد رساله مثبته*")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," *◐ ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات*")  
end
end,nil)
end
if text and text:match('^ضع تكرار (%d+)$') and Mod(msg) then   
local Num = text:match('ضع تكرار (.*)')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodmax" ,Num) 
send(msg.chat_id_, msg.id_,' ◐ تم وضع عدد التكرار ('..Num..')')  
end 
if text and text:match('^ضع زمن التكرار (%d+)$') and Mod(msg) then   
local Num = text:match('^ضع زمن التكرار (%d+)$')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodtime" ,Num) 
send(msg.chat_id_, msg.id_,' ◐ تم وضع زمن التكرار ('..Num..')') 
end
if text == "ضع رابط" or text == 'وضع رابط' then
if msg.reply_to_message_id_ == 0  and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍??????𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
send(msg.chat_id_,msg.id_,"* ◐ حسنآ ارسل اليه الرابط الان*")
database:setex(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_,120,true) 
return false
end
end
if text == "تفعيل رابط" or text == 'تفعيل الرابط' then
if Mod(msg) then  
database:set(bot_id.."Link_Group:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"*◐ تمہ تفعيࢦ الࢪابط*") 
return false  
end
end
if text == "تعطيل رابط" or text == 'تعطيل الرابط' then
if Mod(msg) then  
database:del(bot_id.."Link_Group:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"*◐ تمہ تعطيࢦ الࢪابط*") 
return false end
end

if text == 'المطور' or text == 'مطور' then
local TEXT_SUDO = database:get(bot_id..'TEXT_SUDO')
if TEXT_SUDO then 
send(msg.chat_id_, msg.id_,TEXT_SUDO)
else
tdcli_function ({ID = "GetUser",user_id_ = SUDO},function(arg,result) 
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
end,nil)
end
end
---------------------

if text == "تفعيل صورتي" or text == 'تفعيل الصوره' then
if Constructor(msg) then  
database:set(bot_id.."my_photo:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_," *◐ تم تفعيل الصوره*") 
return false  
end
end
if text == "تعطيل الصوره" or text == 'تعطيل صورتي' then
if Constructor(msg) then  
database:del(bot_id.."my_photo:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"* ◐ تم تعطيل الصوره*") 
return false end
end
if text == "الرابط" then 
local status_Link = database:get(bot_id.."Link_Group:status"..msg.chat_id_)
if not status_Link then
send(msg.chat_id_, msg.id_,"*◐ الࢪابط معطࢦ*") 
return false  
end
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
local link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_)            
if link then                              
send(msg.chat_id_,msg.id_,' ['..ta.title_..']('..link..')')                          
else                
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
linkgp = ' ['..ta.title_..']('..linkgpp.result..')'
else
linkgp = '*◐ لا يوجد رابط ارسل ضع رابط*'
end  
send(msg.chat_id_, msg.id_,linkgp)              
end            
 end,nil)
end
if text == 'مسح الرابط' or text == 'حذف الرابط' then
if Mod(msg) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
send(msg.chat_id_,msg.id_,"* ◐ تم مسح الرابط*")           
database:del(bot_id.."Private:Group:Link"..msg.chat_id_) 
return false      
end
end
if text and text:match("^ضع صوره") and Mod(msg) and msg.reply_to_message_id_ == 0 then  
database:set(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_,true) 
send(msg.chat_id_, msg.id_,'* ◐ ارسل لي الصوره*') 
return false
end
if text == "حذف الصوره" or text == "مسح الصوره" then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
https.request('https://api.telegram.org/bot'..token..'/deleteChatPhoto?chat_id='..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'* ◐ تم ازالة صورة الكروب*') 
end
return false  
end
if text == 'ضع وصف' or text == 'وضع وصف' then  
if Mod(msg) then
database:setex(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_,'* ◐ ارسل الان الوصف*')
end
return false  
end
if text == 'ضع ترحيب' or text == 'وضع ترحيب' then  
if Mod(msg) then
database:setex(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
t  = ' ◐ *ارسل لي الترحيب الان*'
tt = '\n ◐ تستطيع اضافة مايلي !\n ◐ دالة عرض الاسم »{name}\n ◐ دالة عرض المعرف »{user}'
send(msg.chat_id_, msg.id_,t..tt) 
end
return false  
end
if text == 'الترحيب' and Mod(msg) then 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
GetWelcome = GetWelcomeGroup
else 
GetWelcome = '◐ *لم يتم تعيين ترحيب للكروب*'
end 
send(msg.chat_id_, msg.id_,'['..GetWelcome..']') 
return false  
end
if text == 'تفعيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐?? ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
database:set(bot_id..'Chek:Welcome'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,' ◐ *تم تفعيل ترحيب الكروب*') 
return false  
end
if text == 'تعطيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
database:del(bot_id..'Chek:Welcome'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,' ◐ *تم تعطيل ترحيب الكروب*') 
return false  
end
if text == 'مسح الترحيب' or text == 'حذف الترحيب' then 
if Mod(msg) then
database:del(bot_id..'Get:Welcome:Group'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,' ◐ *تم ازالة ترحيب الكروب*') 
end
end
if text and text == "منع" and msg.reply_to_message_id_ == 0 and Manager(msg)  then       
send(msg.chat_id_, msg.id_,"* ◐ ارسل الكلمه لمنعها*")  
database:set(bot_id.."FoX1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"rep")  
return false  
end    
if text then   
local tsssst = database:get(bot_id.."FoX1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_,"* ◐ ارسل التحذير عند ارسال الكلمه*")  
database:set(bot_id.."FoX1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"repp")  
database:set(bot_id.."FoX1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_, text)  
database:sadd(bot_id.."FoX1:List:Filter"..msg.chat_id_,text)  
return false  end  
end
if text then  
local test = database:get(bot_id.."FoX1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test == "repp" then  
send(msg.chat_id_, msg.id_,"* ◐ تم منع الكلمه مع التحذير*")  
database:del(bot_id.."FoX1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
local test = database:get(bot_id.."FoX1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
if text then   
database:set(bot_id.."FoX1:Add:Filter:Rp2"..test..msg.chat_id_, text)  
end  
database:del(bot_id.."FoX1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
return false  end  
end

if text == "الغاء منع" and msg.reply_to_message_id_ == 0 and Manager(msg) then    
send(msg.chat_id_, msg.id_,"* ◐ ارسل الكلمه الان*")  
database:set(bot_id.."FoX1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"reppp")  
return false  end
if text then 
local test = database:get(bot_id.."FoX1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test and test == "reppp" then   
send(msg.chat_id_, msg.id_,"* ◐ تم الغاء منعها*")  
database:del(bot_id.."FoX1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."FoX1:Add:Filter:Rp2"..text..msg.chat_id_)  
database:srem(bot_id.."FoX1:List:Filter"..msg.chat_id_,text)  
return false  end  
end


if text == 'منع' and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = ' *◐ تم منع *'
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:sadd(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = '*الملصق*'
send(msg.chat_id_, msg.id_,textt..'*( '..text..' ) بنجاح لن يتم ارسالها مجددا*')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:sadd(bot_id.."filterphoto"..msg.chat_id_,photo)
text = '*الصوره*'
send(msg.chat_id_, msg.id_,textt..'*( '..text..' ) بنجاح لن يتم ارسالها مجددا*')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:sadd(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = '*المتحركه*'
send(msg.chat_id_, msg.id_,textt..'*( '..text..' ) بنجاح لن يتم ارسالها مجددا*')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'الغاء منع' and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = ' *◐ تم الغاء منع *'
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:srem(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = '*الملصق*'
send(msg.chat_id_, msg.id_,textt..'*( '..text..' ) بنجاح يمكنهم الارسال الان*')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:srem(bot_id.."filterphoto"..msg.chat_id_,photo)
text = '*الصوره*'
send(msg.chat_id_, msg.id_,textt..'*( '..text..' ) بنجاح يمكنهم الارسال الان*')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:srem(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = '*المتحركه*'
send(msg.chat_id_, msg.id_,textt..'*( '..text..' ) بنجاح يمكنهم الارسال الان*')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end

if text == "مسح قائمه المنع"and Manager(msg) then   
local list = database:smembers(bot_id.."FoX1:List:Filter"..msg.chat_id_)  
for k,v in pairs(list) do  
database:del(bot_id.."FoX1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."FoX1:Add:Filter:Rp2"..v..msg.chat_id_)  
database:srem(bot_id.."FoX1:List:Filter"..msg.chat_id_,v)  
end  
send(msg.chat_id_, msg.id_," *◐ تم مسح قائمه المنع*")  
end

if text == "قائمه المنع" and Manager(msg) then   
local list = database:smembers(bot_id.."FoX1:List:Filter"..msg.chat_id_)  
t = "\n *◐ قائمة المنع \n*◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do  
local FoX_Msg = database:get(bot_id.."FoX1:Add:Filter:Rp2"..v..msg.chat_id_)   
t = t..""..k.."- "..v.." » {"..FoX_Msg.."}\n"    
end  
if #list == 0 then  
t = "* ◐ لا يوجد كلمات ممنوعه*"  
end  
send(msg.chat_id_, msg.id_,t)  
end  

if text == 'مسح قائمه منع المتحركات' and Manager(msg) then     
database:del(bot_id.."filteranimation"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'* ◐ تم مسح قائمه منع المتحركات*')  
end
if text == 'مسح قائمه منع الصور' and Manager(msg) then     
database:del(bot_id.."filterphoto"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'* ◐ تم مسح قائمه منع الصور*')  
end
if text == 'مسح قائمه منع الملصقات' and Manager(msg) then     
database:del(bot_id.."filtersteckr"..msg.chat_id_)
send(msg.chat_id_, msg.id_,' *◐ تم مسح قائمه منع الملصقات*')  
end
------------------

if text == 'مسح كليشه المطور' and SudoBot(msg) then
database:del(bot_id..'TEXT_SUDO')
send(msg.chat_id_, msg.id_,' *◐ تم مسح كليشه المطور*')
end
if text == 'ضع كليشه المطور' and SudoBot(msg) then
database:set(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,'* ◐ ارسل الكليشه الان*')
return false
end
if text and database:get(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_) then
if text == 'الغاء' then 
database:del(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'* ◐ تم الغاء حفظ كليشة المطور*')
return false
end
database:set(bot_id..'TEXT_SUDO',text)
database:del(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'* ◐ تم حفظ كليشة المطور*')
return false
end
-----------------
if text == 'تعين الايدي' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
database:setex(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
local Text= [[
>FoX
 ◐ ارسل الان النص
 ◐ يمكنك اضافه :
◐ `#rdphoto` ↫ تعليق الصوره
◐ `#username` ↫ اسم 
◐ `#msgs` ↫ عدد رسائل 
◐ `#photos` ↫ عدد صور 
◐ `#id` ↫ ايدي 
◐ `#auto` ↫ تفاعل 
◐ `#stast` ↫ موقع  
◐ `#edit` ↫ السحكات
◐ `#game` ↫ النقاط
*◐○◐○◐○◐○◐ٴ*
ارسل تغير الايدي لتغير ايدي جديد
𝘊𝘩 - [𝒇𝒐𝒙 ɪᴅ](t.me/ID_FoX)◐
]]
send(msg.chat_id_, msg.id_,Text)
return false  
end 
if text == 'حذف الايدي' or text == 'مسح الايدي' then
if Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
database:del(bot_id.."KLISH:ID"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '* ◐ تم ازالة كليشة الايدي*')
end
return false  
end 

if database:get(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"* ◐ تم الغاء تعين الايدي*") 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = text:match("(.*)")  
database:set(bot_id.."KLISH:ID"..msg.chat_id_,CHENGER_ID)
send(msg.chat_id_, msg.id_,'* ◐ تم تعين الايدي*')    
end

if text == 'طرد البوتات' and Mod(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah)  
local admins = tah.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if tah.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(bot_id) then
chat_kick(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
send(msg.chat_id_, msg.id_, "* ◐ لا توجد بوتات في الكروب*")
else
local t = '* ◐ عدد البوتات هنا >> {'..c..'}\n ◐ عدد البوتات التي هي ادمن >> {'..x..'}\n ◐ تم طرد >> {'..(c - x)..'} من البوتات'
send(msg.chat_id_, msg.id_,t) 
end 
end,nil)  
end   
end
if text == ("كشف البوتات") and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = "\n *◐ قائمة البوتات الموجوده \n*◐○◐○◐○◐○◐ٴ*\n*"
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,ta) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
tr = ''
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
tr = ' {★}'
end
text = text..">> [@"..ta.username_..']'..tr.."\n"
if #admins == 0 then
send(msg.chat_id_, msg.id_, " *◐ لا توجد بوتات في الكروب*")
return false 
end
if #admins == i then 
local a = '\n*◐○◐○◐○◐○◐ٴ*\n *◐ عدد البوتات التي هنا >> {'..n..'} بوت\n*'
local f = '* ◐ عدد البوتات التي هي ادمن >> {'..t..'}\n ◐ ملاحضه علامة ال (✯) تعني ان البوت ادمن \n*'
send(msg.chat_id_, msg.id_, text..a..f)
end
end,nil)
end
end,nil)
end

if database:get(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_, " *◐ تم الغاء حفظ القوانين*") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
database:set(bot_id.."Set:Rules:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_," *◐ تم حفظ قوانين الكروب*") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  

if text == 'ضع قوانين' or text == 'وضع قوانين' then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
database:setex(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_," *◐ ارسل لي القوانين الان*")  
end
end
if text == 'تفعيل الحمايه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagrvrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◐ بواسطه > ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n◐تم الامر بنجاح\n')  
end,nil)   
end
if text == 'تعطيل الحمايه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagrvrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◐ بواسطه > ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n◐ تم الامر بنجاح\n')  
end,nil)   
end
if text == 'مسح القوانين' or text == 'حذف القوانين' then  
if Mod(msg) then
send(msg.chat_id_, msg.id_," *◐ تم ازالة قوانين الكروب*")  
database:del(bot_id.."Set:Rules:Group"..msg.chat_id_) 
end
end
if text == 'القوانين' then 
local Set_Rules = database:get(bot_id.."Set:Rules:Group" .. msg.chat_id_)   
if Set_Rules then     
send(msg.chat_id_,msg.id_, Set_Rules)   
else      
send(msg.chat_id_, msg.id_," *◐ لا توجد قوانين*")   
end    
end
if text == 'قفل التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagrvrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *◐ بواسطه » *['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n* ◐ تـم قفـل التفليش *')  
end,nil)   
end
if text == 'فتح التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagrvrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *◐ بواسطه » *['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'IIIIlI8')..') \n* ◐ تـم فـتح التفليش *')  
end,nil)   
end
if text == 'طرد المحذوفين' or text == 'مسح المحذوفين' then  
if Mod(msg) then    
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
Group_Kick(msg.chat_id_, data.id_)
end
end,nil)
end
send(msg.chat_id_, msg.id_,' *◐ تم طرد المحذوفين*')
end,nil)
end
end
if text == 'الصلاحيات' and Mod(msg) then 
local list = database:smembers(bot_id..'Coomds'..msg.chat_id_)
if #list == 0 then
send(msg.chat_id_, msg.id_,' *◐ لا توجد صلاحيات مضافه*')
return false
end
t = "\n *◐ قائمة الصلاحيات المضافه \n*◐○◐○◐○◐○◐ٴ*\n*"
for k,v in pairs(list) do
var = database:get(bot_id.."Comd:New:rt:bot:"..v..msg.chat_id_)
if var then
t = t..''..k..'- '..v..' » ('..var..')\n'
else
t = t..''..k..'- '..v..'\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text and text:match("^اضف صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^اضف صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
database:set(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
database:sadd(bot_id.."Coomds"..msg.chat_id_,ComdNew)  
database:setex(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, " *◐ ارسل نوع الرتبه \n ◐ {عـضـو -- ممـيـز -- ادمـن -- مـديـر}*") 
end
if text and text:match("^مسح صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^مسح صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
database:del(bot_id.."Comd:New:rt:bot:"..ComdNew..msg.chat_id_)
send(msg.chat_id_, msg.id_, "* ◐ تم مسح الصلاحيه *\n") 
end
if database:get(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_,"* ◐ تم الغاء الامر *\n") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
if text == 'مدير' then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_"* ◐ تستطيع اضافه صلاحيات {ادمن - مميز - عضو} \n ◐ ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'ادمن' then
if not Manager(msg) then 
send(msg.chat_id_, msg.id_,"* ◐ تستطيع اضافه صلاحيات {مميز - عضو} \n ◐ ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مميز' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,"* ◐  تستطيع اضافه صلاحيات {عضو} \n ◐ ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مدير' or text == 'ادمن' or text == 'مميز' or text == 'عضو' then
local textn = database:get(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_)  
database:set(bot_id.."Comd:New:rt:bot:"..textn..msg.chat_id_,text)
send(msg.chat_id_, msg.id_, "* ◐ تـم اضـافـه الامـر*") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
if text and text:match('رفع (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('رفع (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊??𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n* ◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'..'\n *◐ تم رفعه '..RTPA..'\n*')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA) 
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'..'\n *◐ تم رفعه '..RTPA..'\n*')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'..'\n *◐ تم رفعه '..RTPA..'\n*')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)  
database:sadd(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n *◐ العضو » *['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'..'\n *◐ تم رفعه '..RTPA..'\n*')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('تنزيل (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('تنزيل (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n ◐ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'..'\n ◐ م تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n ◐ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'..'\n ◐ تم تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_) 
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n ◐ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'..'\n ◐  تم تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n ◐ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'..'\n ◐ تم تنزيله من '..RTPA..'\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('^رفع (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(رفع) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n ◐ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'IIIIlI8')..')'..'\n ◐ تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n ◐ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'IIIIlI8')..')'..'\n ◐ تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n ◐ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'IIIIlI8')..')'..'\n ◐ تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n ◐ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'IIIIlI8')..')'..'\n ◐ تم رفعه '..text1[2]..'')   
end
else
info = ' ◐ المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end 
end
if text and text:match('^تنزيل (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n ◐ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'IIIIlI8')..')'..'\n ◐ تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n ◐ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'IIIIlI8')..')'..'\n ◐ تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n ◐ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'IIIIlI8')..')'..'\n ◐ تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n ◐ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'IIIIlI8')..')'..'\n ◐ تم تنريله من '..text1[2]..'')   
end
else
info = ' ◐ المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end  
end
if text == "مسح رسايلي" or text == "مسح رسائلي" or text == "حذف رسايلي" or text == "حذف رسائلي" then  
send(msg.chat_id_, msg.id_,' *◐ تم مسح رسائلك*'  )  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if text == "رسايلي" or text == "رسائلي" or text == "msg" then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
send(msg.chat_id_, msg.id_,' *◐ عدد رسائلك » *{ '..database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_)..'}' ) 
end 
if text == 'تفعيل الاذاعه' and SudoBot(msg) then  
if database:get(bot_id..'Bc:Bots') then
database:del(bot_id..'Bc:Bots') 
Text = '\n* ◐ تم تفعيل الاذاعه*' 
else
Text = '\n* ◐ بالتاكيد تم تفعيل الاذاعه*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == '*تعطيل الاذاعه*' and SudoBot(msg) then  
if not database:get(bot_id..'Bc:Bots') then
database:set(bot_id..'Bc:Bots',true) 
Text = '\n *◐ تم تعطيل الاذاعه*' 
else
Text = '\n* ◐  بالتاكيد تم تعطيل الاذاعه*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل التواصل' and SudoBot(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n ◐ تم تفعيل التواصل' 
else
Text = '\n ◐ بالتاكيد تم تفعيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل' and SudoBot(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n ◐ تم تعطيل التواصل' 
else
Text = '\n ◐ بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت الخدمي' and SudoBot(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n ◐ تم تفعيل البوت الخدمي' 
else
Text = '\n ◐ بالتاكيد تم تفعيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت الخدمي' and SudoBot(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n ◐ تم تعطيل البوت الخدمي' 
else
Text = '\n ◐ بالتاكيد تم تعطيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match('^تنظيف (%d+)$') and Manager(msg) then
if not database:get(bot_id..'FCFFFF:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_) then           
local num = tonumber(text:match('^تنظيف (%d+)$')) 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
if num > 1000 then 
send(msg.chat_id_, msg.id_,'*◐تستطيع التنظيف 1000 رساله كحد اقصى*') 
return false  
end  
local msgm = msg.id_
for i=1,tonumber(num) do
DeleteMessage(msg.chat_id_, {[0] = msgm})
msgm = msgm - 1048576
end
send(msg.chat_id_,msg.id_,'*◐ تم حذف *{'..num..'}')  
database:setex(bot_id..'FCFFFF:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
end
end
if text == "تغير اسم البوت" or text == "تغيير اسم البوت" then 
if SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘??𝒍𝒄𝒐𝒎𝒆 ??𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_," ◐ ارسل لي الاسم الان ")  
end
return false
end

if text == ""..(database:get(bot_id..'Name:Bot') or 'فوكس').."" then  
Namebot = (database:get(bot_id..'Name:Bot') or 'فوكس')
local MODEDEV_Msg = {
'ۿۧهلا ؏ـمࢪي .',
'اكلك تحبني ؟ وتصيحني هلكد',
'ۿۧاا ڪـلبي .',
'انا '..Namebot..' موو بوت ɵ̷̥̥᷄ˬɵ̷̥̥᷅',
'مو كافي تصيح بوت ترا ورب اغادر',
'عيونه',
'ۿۧها ححب  .',
}
send(msg.chat_id_, msg.id_,'['..MODEDEV_Msg[math.random(#MODEDEV_Msg)]..']') 
return false
end
if text=="اذاعه خاص" and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,' ◐ الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ◐ لا تستطيع استخدام البوت \n  ◐ يرجى الاشتراك بالقناه اولا \n  ◐ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ◐ ارسل الان اذاعتك \n ◐ للخروج ارسل الغاء") 
return false
end 
if text=="اذاعه" and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,' ◐ الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ◐ لا تستطيع استخدام البوت \n  ◐ يرجى الاشتراك بالقناه اولا \n  ◐ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ◐ ارسل الان اذاعتك \n ◐ للخروج ارسل الغاء ") 
return false
end  
if text=="اذاعه بالتوجيه" and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,' ◐ الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ◐ لا تستطيع استخدام البوت \n  ◐ يرجى الاشتراك بالقناه اولا \n  ◐ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ◐ ارسل لي التوجيه الان") 
return false
end 
if text=="اذاعه بالتوجيه خاص" and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,' ◐  الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ◐ لا تستطيع استخدام البوت \n  ◐ يرجى الاشتراك بالقناه اولا \n  ◐ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ◐ ارسل لي التوجيه الان") 
return false
end 
if text and text:match('^ضع اسم (.*)') and Manager(msg) or text and text:match('^وضع اسم (.*)') and Manager(msg) then 
local Name = text:match('^ضع اسم (.*)') or text and text:match('^وضع اسم (.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ◐ لا تستطيع استخدام البوت \n  ◐ يرجى الاشتراك بالقناه اولا \n  ◐ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = Name },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_," ◐ البوت ليس ادمن يرجى ترقيتي !")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ◐ ليست لدي صلاحية تغير اسم الكروب")  
else
sebd(msg.chat_id_,msg.id_,' ◐ تم تغيير اسم الكروب الى {['..Name..']}')  
end
end,nil) 
end

if text == "منشن" and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = 200
},function(ta,FoX)
local t = "\n*◐ قائمة الاعضاء \n**◐○◐○◐○◐○◐ٴ*ٴ*\n*"
x = 0
local list = FoX.members_
for k, v in pairs(list) do
x = x + 1
if database:get(bot_id..'user:Name'..v.user_id_) then
t = t.."*"..x.." → {[@"..database:get(bot_id..'user:Name'..v.user_id_).."]}\n*"
else
t = t..""..x.." → {"..v.user_id_.."}\n"
end
end
send(msg.chat_id_,msg.id_,t)
end,nil)
end
if text == ("تاك") and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙   ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = 200
},function(ta,MODEDEV)
local t = "\n*◐ قائمة الاعضاء \n *◐○◐○◐○◐○◐ٴ*\n*"
x = 0
local list = MODEDEV.members_
for k, v in pairs(list) do
x = x + 1
if database:get(bot_id..'user:Name'..v.user_id_) then
t = t.."*︙"..x.."︙ >  {@"..database:get(bot_id..'user:Name'..v.user_id_).."}\n*"
else
end
end
send(msg.chat_id_,msg.id_,t)
end,nil)
end
if text == ("تنزيل الكل") and msg.reply_to_message_id_ ~= 0 and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'○  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙  ○\n○ لايمكنك استخدام البوت ○\n○ عليك الاشتراك في القناة ○\n○ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'○>]')
end
return false
end
function start_function(extra, result, success)
if tonumber(SUDO) == tonumber(result.sender_user_id_) then
send(msg.chat_id_, msg.id_,"لا تستطيع تنزيل المطور الاساسي")
return false 
end
if database:sismember(bot_id..'Sudo:User',result.sender_user_id_) then
dev = 'المطور ،' else dev = '' end
if database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_) then
crr = 'منشئ اساسي ،' else crr = '' end
if database:sismember(bot_id..'Basicmalak'..msg.chat_id_, result.sender_user_id_) then
maa = 'منشئ اساسي ،' else maa = '' end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_) then
cr = 'منشئ ،' else cr = '' end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_) then
own = 'مدير ،' else own = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_) then
mod = 'ادمن ،' else mod = '' end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_) then
vip = 'مميز ،' else vip = ''
end
if Can_or_NotCan(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n تم تنزيل العضو من الرتب التاليه \n { "..dev..''..crr..''..maa..''..cr..''..own..''..mod..''..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n ليس لديه رتب حتى استطيع تنزيله \n")
end
if tonumber(SUDO) == tonumber(msg.sender_user_id_) then
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Sudo:User',msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
elseif database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end

if text == ("مسح ردود المطور") and SudoBot(msg) then 
local list = database:smembers(bot_id..'List:Rd:Sudo')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Sudo:Gif"..v)   
database:del(bot_id.."Add:Rd:Sudo:vico"..v)   
database:del(bot_id.."Add:Rd:Sudo:stekr"..v)     
database:del(bot_id.."Add:Rd:Sudo:Text"..v)   
database:del(bot_id.."Add:Rd:Sudo:Photo"..v)
database:del(bot_id.."Add:Rd:Sudo:Video"..v)
database:del(bot_id.."Add:Rd:Sudo:File"..v)
database:del(bot_id.."Add:Rd:Sudo:Audio"..v)
database:del(bot_id..'List:Rd:Sudo')
end
send(msg.chat_id_, msg.id_," ◐ تم مسح ردود المطور")
end

if text == ("ردود المطور") and SudoBot(msg) then 
local list = database:smembers(bot_id..'List:Rd:Sudo')
text = "\n ◐ قائمة ردود المطور \n*◐○◐○◐○◐○◐ٴ*\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Sudo:Gif"..v) then
db = 'متحركه'
elseif database:get(bot_id.."Add:Rd:Sudo:vico"..v) then
db = 'بصمه'
elseif database:get(bot_id.."Add:Rd:Sudo:stekr"..v) then
db = 'ملصق'
elseif database:get(bot_id.."Add:Rd:Sudo:Text"..v) then
db = 'رساله'
elseif database:get(bot_id.."Add:Rd:Sudo:Photo"..v) then
db = 'صوره'
elseif database:get(bot_id.."Add:Rd:Sudo:Video"..v) then
db = 'فيديو'
elseif database:get(bot_id.."Add:Rd:Sudo:File"..v) then
db = 'ملف'
elseif database:get(bot_id.."Add:Rd:Sudo:Audio"..v) then
db = 'اغنيه'
end
text = text..""..k.." >> ("..v..") » {"..db.."}\n"
end
if #list == 0 then
text = " ◐ لا يوجد ردود للمطور"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id..'Text:Sudo:Bot'..msg.sender_user_id_..':'..msg.chat_id_)
if database:get(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
database:del(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Sudo:stekr"..test, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Sudo:vico"..test, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Sudo:Gif"..test, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
database:set(bot_id.."Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Sudo:Audio"..test, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Sudo:File"..test, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Sudo:Video"..test, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Sudo:Photo"..test, photo_in_group)  
end
send(msg.chat_id_, msg.id_,' ◐ تم حفظ الرد')
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,' ◐ ارسل الرد الذي تريد اضافته')
database:set(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_, 'true1')
database:set(bot_id..'Text:Sudo:Bot'..msg.sender_user_id_..':'..msg.chat_id_, text)
database:sadd(bot_id..'List:Rd:Sudo', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,' ◐ تم ازالة الرد العام')
list = {"Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
database:del(bot_id..v..text)
end
database:del(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_)
database:srem(bot_id..'List:Rd:Sudo', text)
return false
end
end
if text == 'اضف رد للكل' and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,' ◐ ارسل الكلمه تريد اضافتها')
database:set(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == 'حذف رد للكل' and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,' ◐ ارسل الكلمه تريد حذفها')
database:set(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text and not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Sudo:Gif"..text)   
local veico = database:get(bot_id.."Add:Rd:Sudo:vico"..text)   
local stekr = database:get(bot_id.."Add:Rd:Sudo:stekr"..text)     
local text1 = database:get(bot_id.."Add:Rd:Sudo:Text"..text)   
local photo = database:get(bot_id.."Add:Rd:Sudo:Photo"..text)
local video = database:get(bot_id.."Add:Rd:Sudo:Video"..text)
local document = database:get(bot_id.."Add:Rd:Sudo:File"..text)
local audio = database:get(bot_id.."Add:Rd:Sudo:Audio"..text)
------------------------------------------------------------------------
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_,text1)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, anemi, '', nil)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,'')
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
if text == ("مسح ردود المدير") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'List:Manager'..msg.chat_id_..'')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_)
database:del(bot_id..'List:Manager'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_," ◐ تم مسح ردود المدير")
end

if text == ("ردود المدير") and Manager(msg) then
local list = database:smembers(bot_id..'List:Manager'..msg.chat_id_..'')
text = "* ◐ قائمه ردود المدير \n◐○◐○◐○◐○◐ٴ\n*"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_) then
db = 'متحركه'
elseif database:get(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_) then
db = 'بصمه'
elseif database:get(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_) then
db = 'ملصق'
elseif database:get(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_) then
db = 'رساله'
elseif database:get(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_) then
db = 'صوره'
elseif database:get(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_) then
db = 'فيديو'
elseif database:get(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_) then
db = 'ملف'
elseif database:get(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_) then
db = 'اغنيه'
end
text = text..""..k..">> ("..v..") » {"..db.."}\n"
end
if #list == 0 then
text = " ◐ لا يوجد ردود للمدير"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id..'Text:Manager'..msg.sender_user_id_..':'..msg.chat_id_..'')
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
database:del(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Manager:Stekrs"..test..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Manager:Vico"..test..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Manager:Gif"..test..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
database:set(bot_id.."Add:Rd:Manager:Text"..test..msg.chat_id_, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Manager:Audio"..test..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Manager:File"..test..msg.chat_id_, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Manager:Video"..test..msg.chat_id_, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Manager:Photo"..test..msg.chat_id_, photo_in_group)  
end
send(msg.chat_id_, msg.id_,' ◐ تم حفظ الرد')
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,' ◐ ارسل الرد الذي تريد اضافته')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,'true1')
database:set(bot_id..'Text:Manager'..msg.sender_user_id_..':'..msg.chat_id_, text)
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:sadd(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_..'') == 'true2' then
send(msg.chat_id_, msg.id_,' ◐ تم ازالة الرد ')
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:del(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_)
database:srem(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false
end
end
if text == 'اضف رد' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ◐ لا تستطيع استخدام البوت \n  ◐ يرجى الاشتراك بالقناه اولا \n  ◐ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,' ◐ ارسل الكلمه التي تريد اضافتها')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == 'حذف رد' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ◐ لا تستطيع استخدام البوت \n  ◐ يرجى الاشتراك بالقناه اولا \n  ◐ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,' ◐ ارسل الكلمه التي تريد حذفها')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,'true2')
return false 
end
if text and not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
local veico = database:get(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
local stekr = database:get(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
local text1 = database:get(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
local photo = database:get(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
local video = database:get(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
local document = database:get(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
local audio = database:get(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
------------------------------------------------------------------------
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_, text1)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, anemi)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,photo_caption)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
-------------------------------
if text == ""..(database:get(bot_id..'Name:Bot') or 'فوكس').." غادر" or text == 'غادر' then  
if Sudo(msg) and not database:get(bot_id..'Left:Bot'..msg.chat_id_)  then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,'*◐كانت لحظات جميله قضينا أوقات ممتعه هنا وحان موعد الفراق شكرا لكم 💘🧸*') 
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
end
return false  
end
if text == 'بوت' then
Namebot = (database:get(bot_id..'Name:Bot') or 'فوكس')
send(msg.chat_id_, msg.id_,'*اسمي '..Namebot..'*')
end
if text == 'الاحصائيات' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '* الاحصائيات ◐* \n'..' *◐ عدد الكروبات » *{'..Groups..'}'..'\n *◐  عدد المشتركين » *{'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'الكروبات' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' *◐ عدد الكروبات » *{`'..Groups..'`}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'المشتركين' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '* ◐ عدد المشتركين » *{`'..Users..'|}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'تفعيل المغادره' and SudoBot(msg) then   
if database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = '\n◐تمہ تفعيࢦ مغادࢪة اࢦبوت◐'
database:del(bot_id..'Left:Bot'..msg.chat_id_)  
else
Text = '\n◐باࢦتاڪيد تمہ تفعيࢦ مغادࢪة اࢦبوت◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل المغادره' and SudoBot(msg) then  
if not database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = '\n◐تمہ تعطيࢦ مغادࢪة اࢦبوت◐'
database:set(bot_id..'Left:Bot'..msg.chat_id_,true)   
else
Text = '\n◐باࢦتاڪيد تمہ تعطيࢦ مغادࢪة اࢦبوت◐'
end
send(msg.chat_id_, msg.id_, Text) 
end

if text == 'تفعيل ردود المدير' and Manager(msg) then   
if database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
Text = '\n◐تمہ تفعيࢦ ࢪدود اࢦمديࢪ◐'
database:del(bot_id..'Reply:Manager'..msg.chat_id_)  
else
Text = '\n◐باࢦتاڪيد تمہ تفعيࢦ ࢪدود اࢦمديࢪ◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ردود المدير' and Manager(msg) then  
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
database:set(bot_id..'Reply:Manager'..msg.chat_id_,true)  
Text = '\n◐تمہ تعطيࢦ ࢪدود اࢦمديࢪ◐' 
else
Text = '\n◐باࢦتاڪيد تمہ تعطيࢦ ࢪدود اࢦمديࢪ◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل ردود المطور' and Manager(msg) then   
if database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:del(bot_id..'Reply:Sudo'..msg.chat_id_)  
Text = '\n◐تمہ تفعيࢦ ࢪدود اࢦمطوࢪ◐' 
else
Text = '\n◐باࢦتاڪيد تمہ تفعيࢦ ࢪدود اࢦمطوࢪ◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ردود المطور' and Manager(msg) then  
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:set(bot_id..'Reply:Sudo'..msg.chat_id_,true)   
Text = '\n◐تمہ تعطيࢦ ࢪدود اࢦمطوࢪ◐' 
else
Text = '\n◐باࢦتاڪيد تمہ تعطيࢦ ࢪدود اࢦمطوࢪ◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الايدي' and Manager(msg) then   
if database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id'..msg.chat_id_) 
Text = '\n◐تمہ تفعيࢦ اࢦايديہ◐' 
else
Text = '\n◐باࢦتاڪيد تمہ تفعيࢦ اࢦايديہ◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي' and Manager(msg) then  
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id'..msg.chat_id_,true) 
Text = '\n◐تمہ تعطيࢦ اࢦايديہ◐' 
else
Text = '\n◐باࢦتاڪيد تمہ تعطيࢦ اࢦايديہ◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الايدي بالصوره' and Manager(msg) then   
if database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id:Photo'..msg.chat_id_) 
Text = '\n◐تمہ تفعيࢦ اࢦايديہ باࢦصوࢪۿ◐' 
else
Text = '\n◐باࢦتاڪيد تمہ تفعيࢦ اࢦايديہ باࢦصوࢪۿ◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي بالصوره' and Manager(msg) then  
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true) 
Text = '\n◐تمہ تعطيࢦ اࢦايديہ باࢦصوࢪۿ◐' 
else
Text = '\n◐باࢦتاڪيد تمہ تعطيࢦ اࢦايديہ باࢦصوࢪۿ◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الحظر' and Constructor(msg) then   
if database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:del(bot_id..'Lock:kick'..msg.chat_id_) 
Text = '\n◐تمہ تفعيࢦ الحظࢪ◐' 
else
Text = '\n ◐باࢦتاڪيد تمہ تفعيࢦ الحظࢪ◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الحظر' and Constructor(msg) then  
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:set(bot_id..'Lock:kick'..msg.chat_id_,true) 
Text = '\n◐تمہ تعطيࢦ الحظࢪ◐' 
else
Text = '\n◐باࢦتاڪيد تمہ تعطيࢦ الحظࢪ◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الرفع' and Constructor(msg) then   
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:del(bot_id..'Lock:Add:Bot'..msg.chat_id_) 
Text = '\n◐تمہ تفعيࢦ الࢪفع◐' 
else
Text = '\n◐باࢦتاڪيد تمہ تفعيࢦ الࢪفع◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الرفع' and Constructor(msg) then  
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:set(bot_id..'Lock:Add:Bot'..msg.chat_id_,true) 
Text = '\n◐تمہ تعطيࢦ الࢪفع◐' 
else
Text = '\n◐باࢦتاڪيد تمہ تعطيࢦ الࢪفع◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match("^وضع لقب (.*)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local timsh = text:match("^وضع لقب (.*)$")
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◐ العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'MODEDEV')..') '
status  = '\n◐ الايدي > '..result.sender_user_id_..'\n◐تم ضافه {'..timsh..'} كلقب له'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
https.request("https://api.telegram.org/bot"..token.."/setChatAdministratorCustomTitle?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&custom_title="..timsh)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text == 'ايدي' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.sender_user_id_) or 0)
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'◐ ID ◐ ('..iduser..')\n◐USE ◐ ('..username..')\n◐ STA ◐ ('..rtp..')\n◐ MSG ◐ ('..Msguser..')')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^ايدي @(.*)$") then
local username = text:match("^ايدي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.id_) or 0)
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,' *◐ ايديه ↫*('..iduser..')\n *◐ معرفه ↫*('..username..')\n* ◐ رتبته ↫*('..rtp..')\n *◐ تعديلاته ↫*('..edit..')\n *◐ نقاطه ↫*('..NUMPGAME..')\n *◐ جهاته ↫*('..Contact..')\n *◐ رسائله ↫*('..Msguser..')')
end,nil)
else
send(msg.chat_id_, msg.id_,' *◐ المعرف غير صحيح *')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'رتبتي' then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
send(msg.chat_id_, msg.id_,'* ◐ رتبتك في البوت »* '..rtp)
end
if text == "اسمي"  then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.first_name_  then
first_name = ' *◐ اسمك الاول » *{`'..(result.first_name_)..'`}'
else
first_name = ''
end   
if result.last_name_ then 
last_name = ' *◐ اسمك الثاني » *{`'..result.last_name_..'`}' 
else
last_name = ''
end      
send(msg.chat_id_, msg.id_,first_name..'\n'..last_name) 
end,nil)
end 
if text == 'ايديي' then
send(msg.chat_id_, msg.id_,'* ◐ ايديك »* '..msg.sender_user_id_)
end
if text == 'الرتبه' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ' ['..data.first_name_..'](t.me/'..(data.username_ or 'IIIIlI8')..')'
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'*- العضو » (*'..username..'*)\n- الرتبه » ('..rtp..')*\n')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^الرتبه @(.*)$") then
local username = text:match("^الرتبه @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'*- العضو » (*'..username..'*)\n- الرتبه » ('..rtp..')*\n')
end,nil)
else
send(msg.chat_id_, msg.id_,'*- المعرف غير صحيح *')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'كشف' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'◐ الايدي > ('..iduser..')\n◐ المعرف > ('..username..')\n◐ الرتبه > ('..rtp..')\n')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^كشف @(.*)$") then
local username = text:match("^كشف @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'◐ الايدي > ('..iduser..')\n◐ المعرف > ('..username..')\n◐ الرتبه > ('..rtp..')\n')
end,nil)
else
send(msg.chat_id_, msg.id_,'◐ المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text==('عدد الكروب') and Mod(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,msg.id_," ◐ البوت ليس ادمن \n") 
return false  
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
local amir = ' *◐ عدد الادمنيه : *'..data.administrator_count_..
'\n\n *◐ عدد المطرودين : *'..data.kicked_count_..
'\n\n *◐ عدد الاعضاء : *'..data.member_count_..
'\n\n *◐ عدد رسائل الكروب : *'..(msg.id_/2097152/0.5)..
'\n\n *◐  اسم الكروب *: ['..ta.title_..']'
send(msg.chat_id_, msg.id_, amir) 
end,nil)
end,nil)
end 
if text == 'اطردني' or text == 'طردني' then
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
if Can_or_NotCan(msg.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n* ◐ عذرا لا استطيع طرد *( '..Rutba(msg.sender_user_id_,msg.chat_id_)..' )')
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=msg.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'* ◐ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !*') 
return false  
end
if (data and data.code_ and data.code_ == 3) then 
send(msg.chat_id_, msg.id_,' *◐البوت ليس ادمن يرجى ترقيتي !*') 
return false  
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_, msg.id_,' *◐ عذرا لا استطيع طرد ادمنية الكروب*') 
return false  
end
if data and data.ID and data.ID == 'Ok' then
send(msg.chat_id_, msg.id_,'*◐تمہ طࢪدڪ مِہטּ الڪࢪوبہ◐*') 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = msg.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
return false
end
end,nil)   
else
send(msg.chat_id_, msg.id_,'*◐تمہ تعطيࢦ امࢪ اطࢪدنيہ◐*') 
end
end
if text and text:match("^صيح (.*)$") then
local username = text:match("^صيح (.*)$") 
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
function start_function(extra, result, success)
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_,'* ◐ المعرف غلط* ') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
send(msg.chat_id_, msg.id_,' *◐لا استطيع اصيح معرف قنوات*') 
return false  
end
if result.type_.user_.type_.ID == "UserTypeBot" then
send(msg.chat_id_, msg.id_,'* ◐لا استطيع اصيح معرف بوتات*') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'*⚠| لا اسطيع صيح معرفات الكروبات*') 
return false  
end
if result.id_ then
send(msg.chat_id_, msg.id_,'* ◐تعال حبي يصيحونك بل كروب *[@'..username..']') 
return false
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
else
send(msg.chat_id_, msg.id_,' *◐تم تعطيل امر صيح*') 
end
return false
end

if text == 'منو ضافني' then
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,'*◐انتہ منشئ اࢦڪࢪوبہ◐*') 
return false
end
local Added_Me = database:get(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = ' *◐ الشخص الذي قام باضافتك هو »* '..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,'*◐انتہ دخلتہ عبࢪ ࢪابط ࢦتࢦح◐*') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,'*◐تمہ تعطيࢦ امࢪ منو ضافنيہ◐*') 
end
end

if text == 'تفعيل ضافني' and Manager(msg) then   
if database:get(bot_id..'Added:Me'..msg.chat_id_) then
Text = '◐تمہ تفعيࢦ امࢪ منو ضافنيہ◐'
database:del(bot_id..'Added:Me'..msg.chat_id_)  
else
Text = '\n ◐باࢦتاڪيد تمہ تفعيࢦ امࢪ منو ضافنيہ◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ضافني' and Manager(msg) then  
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
database:set(bot_id..'Added:Me'..msg.chat_id_,true)  
Text = '\n ◐تمہ تعطيࢦ امࢪ منو ضافنيہ◐'
else
Text = '\n ◐باࢦتاڪيد تمہ تعطيࢦ امࢪ منو ضافنيہ◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل صيح' and Manager(msg) then   
if database:get(bot_id..'Seh:User'..msg.chat_id_) then
Text = '\n ◐تمہ تفعيࢦ امࢪ صيح◐'
database:del(bot_id..'Seh:User'..msg.chat_id_)  
else
Text = '\n ◐باࢦتاڪيد تمہ تفعيࢦ امࢪ صيح◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تنزيل جميع الرتب' and BasicConstructor(msg) then  
database:del(bot_id..'Constructor'..msg.chat_id_)
database:del(bot_id..'Manager'..msg.chat_id_)
database:del(bot_id..'Mod:User'..msg.chat_id_)
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n ◐ تم تنزيل الكل من الرتب الاتيه \n ◐ المميزين ، الادمنيه ، المدراء ، المنشئين \n')
end
if text == 'تعطيل صيح' and Manager(msg) then  
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
database:set(bot_id..'Seh:User'..msg.chat_id_,true)  
Text = '\n ◐تمہ تعطيࢦ امࢪ صيح'
else
Text = '\n ◐باࢦتاڪيد تمہ تعطيࢦ امࢪ صيح◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل اطردني' and Manager(msg) then   
if database:get(bot_id..'Cick:Me'..msg.chat_id_) then
Text = '\n ◐تمہ تفعيࢦ امࢪ اطࢪدنيہ◐'
database:del(bot_id..'Cick:Me'..msg.chat_id_)  
else
Text = '\n ◐باࢦتاڪيد تمہ تفعيࢦ امࢪ اطࢪدنيہ◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل اطردني' and Manager(msg) then  
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
database:set(bot_id..'Cick:Me'..msg.chat_id_,true)  
Text = '\n ◐تمہ تعطيࢦ امࢪ اطࢪدنيہ◐'
else
Text = '\n ◐باࢦتاڪيد تمہ تعطيࢦ امࢪ اطࢪدنيہ◐'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "صورتي"  then
local my_ph = database:get(bot_id.."my_photo:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"◐اࢦصوࢪۿ معطࢦۿ◐") 
return false  
end
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_," ◐ عدد صورك ↫ "..result.total_count_.." صوره‌‏", msg.id_, msg.id_, "md")
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك', 1, 'md')
  end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
if text == 'تغير الايدي' and Manager(msg) then 
local List = {
[[
゠𝚄𝚂𝙴𝚁 𖨈 #username 𖥲 .
゠𝙼𝚂𝙶 𖨈 #msgs 𖥲 .
゠𝚂𝚃𝙰 𖨈 #stast 𖥲 .
゠𝙸𝙳 𖨈 #id 𖥲 .
]],
[[
➭- 𝒔𝒕𝒂𓂅 #stast 𓍯. 💕
➮- 𝒖𝒔𝒆𝒓𓂅 #username 𓍯. 💕
➭- 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯. 💕
➭- 𝒊𝒅 𓂅 #id 𓍯. 💕
]],
[[
⚕ 𓆰 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝑻𝒐 𝑮𝒓𝒐𝒖𝒑 ★
◐ 🖤 | 𝑼𝑬𝑺 : #username ‌‌‏⚚
◐ 🖤 | 𝑺𝑻𝑨 : #stast 🧙🏻‍♂ ☥
◐ 🖤 | 𝑰𝑫 : #id ‌‌‏♕
◐ 🖤 | 𝑴𝑺𝑮 : #msgs 𓆊
]],
[[
┌ 𝐔𝐒𝐄𝐑 𖤱 #username 𖦴 .
├ 𝐌𝐒𝐆 𖤱 #msgs 𖦴 .
├ 𝐒𝐓𝐀 𖤱 #stast 𖦴 .
└ 𝐈𝐃 𖤱 #id 𖦴 .
]],
[[
𓄼🇮🇶 𝑼𝒔𝒆𝒓𝑵𝒂𝒎𝒆 :#username 
𓄼🇮🇶 𝑺𝒕𝒂𝒔𝒕 :#stast 
𓄼🇮🇶 𝒊𝒅 :#id 
𓄼🇮🇶 𝑮𝒂𝒎𝒆𝑺 :#game 
𓄼🇮🇶 𝑴𝒔𝒈𝒔 :#msgs
]],
[[
❤️|-وف اتفاعل يحلو😍🙈
👨‍👧|- ☆يوزرك #username 🎫
💌|- ☆رسائلك #msgs 💌
🎫|- ☆ايديك #id   🥇
🎟|- ☆موقعك #stast 🌐 
🤸‍♂|- ☆جفصاتك #edit  🌬
🥉|- ☆تفاعلك #auto 🚀
🏆|- ☆مجوهراتك #game 🕹
🌏|- ☆اشترك يحلو🌐《 قناة الكروب》
]],
[[
➞: 𝒔𝒕𝒂?? #stast 𓍯➸💞.
➞: 𝒖𝒔𝒆𝒓𓂅 #username 𓍯➸💞.
➞: 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯➸💞.
➞: 𝒊𝒅 𓂅 #id 𓍯➸💞.
]],
[[
☆◐𝐮𝐬𝐞𝐫 : #username 𖣬  
☆◐𝐦𝐬𝐠  : #msgs 𖣬 
☆◐𝐬𝐭𝐚 : #stast 𖣬 
☆◐𝐢𝐝  : #id 𖣬
]],
[[
- 𓏬 𝐔𝐬𝐄𝐫 : #username 𓂅 .
- 𓏬 𝐌𝐬𝐆  : #msgs 𓂅 .
- 𓏬 𝐒𝐭𝐀 : #stast 𓂅 .
- 𓏬 𝐈𝐃 : #id 𓂅 .
]],
[[
ᯓ 𝗨𝗦𝗘𝗥𝗡𝗮𝗺𝗘  #username 🇺🇸 ꙰
ᯓ 𝗦𝗧𝗮𝗦𝗧  #stast 🇺🇸 ꙰
ᯓ 𝗜𝗗  #id 🇺🇸 ꙰
ᯓ 𝗚𝗮𝗺𝗘𝗦  #game 🇺🇸 ꙰
ᯓ 𝗺𝗦𝗚𝗦  #msgs 🇺🇸 ꙰
ᯓ 𝙥𝙝𝙤𝙩𝙤𝙨  #photos 🇺🇸 ꙰
ᯓ 𝙖𝙪𝙩𝙤  #auto 🇺🇸 ꙰
ᯓ 𝙚𝙙𝙞𝙩  #edit 🇺🇸 ꙰
]],
[[
- ايديڪ  ⁞ #id 💘 ٬
- يوزرڪ القميل ⁞ #username 💘 ٬
- رسائلڪ  الطيفهہَ ⁞ #msgs 💘 ٬
- رتبتڪ الحلوه ⁞ #stast  💘٬
- سحڪاتڪ الفول ⁞ #edit 💘 ٬
- نقاطڪ يحــلو ⁞ #game 💘 ٬
]],
[[
⌯  𝗨𝗦𝗘𝗥𝗡𝗮𝗺𝗘 . #username 🇺🇸 -
⌯  𝗦𝗧𝗮𝗦𝗧 . #stast 🇺🇸 -
⌯ 𝗜𝗗 . #id 🇺🇸 -
⌯ 𝗚𝗮𝗺𝗘𝗦 . #game 🇺🇸 -
⌯ 𝗺𝗦𝗚𝗦 . #msgs 🇺🇸 -
]],
[[
.𖣂 𝙪𝙨𝙚𝙧𝙣𝙖𝙢𝙚 , #username  
.𖣂 𝙨𝙩𝙖𝙨𝙩 , #stast  
.𖣂 𝙡𝘿 , #id  
.𖣂 𝙂𝙖𝙢𝙨 , #game 
.𖣂 𝙢𝙨𝙂𝙨 , #msgs
]]}
local Text_Rand = List[math.random(#List)]
database:set(bot_id.."KLISH:ID"..msg.chat_id_,Text_Rand)
send(msg.chat_id_, msg.id_,'◐ تم تغير الايدي ارسل ايدي لرؤيته')
end
if text == ("ايدي") and msg.reply_to_message_id_ == 0 and not database:get(bot_id..'Bot:Id'..msg.chat_id_) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da)  tdcli_function ({ ID = "SendChatAction",  chat_id_ = msg.sender_user_id_, action_ = {  ID = "SendMessageTypingAction", progress_ = 100}  },function(arg,ta)  tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)  tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,amir,success) 
if da.status_.ID == "ChatMemberStatusCreator" then 
rtpa = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then 
rtpa = 'مشرف' 
elseif da.status_.ID == "ChatMemberStatusMember" then 
rtpa = 'عضو'
end
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 1) 
local nummsggp = tonumber(msg.id_/2097152/0.5)
local nspatfa = tonumber(Msguser / nummsggp * 100)
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0)
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
local iduser = msg.sender_user_id_
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
local photps = (amir.total_count_ or 0)
local interaction = Total_Msg(Msguser)
local rtpg = rtpa
local amira = {
"اروح فـدوه للـحلوين",
"فديت الصاك محح",
"فـدشـي عمـي",
"دغـيرهـا شبـي هـاذ",
"شهل الگيمر",
"شهل الصوره تخمبش",
"فديت الحلو",
 "بـبكن حـلك",
}
local rdphoto = amira[math.random(#amira)]
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then      
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then   
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, amir.photos_[0].sizes_[1].photo_.persistent_id_,get_id_text)       
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_, '\n ليس لديك صور في حسابك \n['..get_id_text..']')      
end 
end
else
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, amir.photos_[0].sizes_[1].photo_.persistent_id_,''..rdphoto..'\n ◐ ايديك ↫ '..msg.sender_user_id_..'\n ◐ معرفك ↫ '..username..'\n ◐ رتبتك ↫ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n ◐ موقعك ↫ '..rtpa..'\n ◐ تفاعلك ↫ '..Total_Msg(Msguser)..'\n ◐ رسائلك ↫ '..Msguser..'\n ◐ نسبه تفاعلك ↫ '..string.sub(nspatfa, 1,5)..' %\n ◐ السحكات ↫ '..edit..'\n ◐ نقاطك ↫ '..NUMPGAME..'\n')
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'[\n ◐ ايديك ↫ '..msg.sender_user_id_..'\n ◐ معرفك ↫ '..username..'\n ◐ رتبتك ↫ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n ◐ موقعك ↫ '..rtpa..'\n ◐ تفاعلك ↫ '..Total_Msg(Msguser)..'\n ◐ رسائلك ↫ '..Msguser..'\n ◐ نسبه  تفاعلك ↫ '..string.sub(nspatfa, 1,5)..' %\n ◐ السحكات ↫ '..edit..'\n ◐ نقاطك ↫ '..NUMPGAME..']\n')
else
send(msg.chat_id_, msg.id_, '\n ◐ الصوره ↫ ليس لديك صور في حسابك'..'[\n ◐ ايديك ↫ '..msg.sender_user_id_..'\n ◐ معرفك ↫ '..username..'\n ◐ رتبتك ↫ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n ◐ موقعك ↫ '..rtpa..'\n ◐ تفاعلك ↫ '..Total_Msg(Msguser)..'\n ◐ رسائلك ↫ '..Msguser..'\n ◐ نسبه تفاعلك ↫ '..string.sub(nspatfa, 1,5)..' %\n ◐ السحكات ↫ '..edit..'\n ◐ نقاطك ↫ '..NUMPGAME..']\n')
end 
end
end
else
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_,'[\n ◐ ايديك ↫ '..msg.sender_user_id_..'\n ◐ معرفك ↫ '..username..'\n ◐ رتبتك ↫ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n ◐ موقعك ↫ '..rtpa..'\n ◐ تفاعلك ↫ '..Total_Msg(Msguser)..'\n ◐ رسائلك ↫ '..Msguser..'\n ◐ نسبه تفاعلك ↫ '..string.sub(nspatfa, 1,5)..' %\n ◐ السحكات ↫ '..edit..'\n ◐ نقاطك ↫ '..NUMPGAME..']\n')
end
end

end,nil)
end,nil)
end,nil)
end,nil)
end
end

if text == 'سحكاتي' or text == 'تعديلاتي' then 
local Num = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
if Num == 0 then 
Text = ' ◐  ليس لديك سحكات'
else
Text = ' ◐ عدد سحكاتك *> { '..Num..' } *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "مسح سحكاتي" or text == "حذف سحكاتي" then  
send(msg.chat_id_, msg.id_,' ◐ تم مسح سحكاتك'  )  
database:del(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_)
end
if text == "مسح جهاتي" or text == "حذف جهاتي" then  
send(msg.chat_id_, msg.id_,' ◐ تم مسح جهاتك'  )  
database:del(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_)
end
if text == 'جهاتي' or text == 'شكد ضفت' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ◐ لا تستطيع استخدام البوت \n  ◐ يرجى الاشتراك بالقناه اولا \n  ◐ < جط ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Num = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
if Num == 0 then 
Text = ' ◐ لم تقم بأضافه احد'
else
Text = ' ◐ عدد جهاتك > ['..Num..'](https://t.me/IIIIlI8) ◐'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == "تنظيف المشتركين" and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'* ◐  لا يوجد مشتركين وهميين في البوت \n*')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'* ◐ عدد المشتركين الان » ( '..#pv..' )\n- تم ازالة » ( '..sendok..' ) من المشتركين\n- الان عدد المشتركين الحقيقي » ( '..ok..' ) مشترك \n*')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "تنظيف الكروبات" and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']*')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'* ◐  لا يوجد كروبات وهميه في البوت\n*')   
else
local FoX = (w + q)
local sendok = #group - FoX
if q == 0 then
FoX = ''
else
FoX = '*\n- تم ازالة » { '..q..' } كروبات من البوت*'
end
if w == 0 then
FoXk = ''
else
FoXk = '*\n- تم ازالة » {'..w..'} كروب لان البوت عضو*'
end
send(msg.chat_id_, msg.id_,'* ◐ عدد الكروبات الان » { '..#group..' }'..FoXk..''..FoX..'\n*- الان عدد الكروبات الحقيقي » { '..sendok..' } كروبات\n*')   
end
end
end,nil)
end
return false
end
if text =='تغيير المطور الاساسي' and SudoBot(msg) then
send(msg.chat_id_, msg.id_,'◐ ارسل ايدي المطور الاساسي الجديد')
database:set(bot_id..'DEV:Sudo:T',true) 
end
if text =='تغيير المطور الاساسي' and not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'الامر لا يخصك')
end
if database:get(bot_id.."DEV:Sudo:T") then
if text and text:match("^(%d+)$") then
local IdDe = text:match("^(%d+)$")
send(msg.chat_id_,msg.id_, "تم حفض الايدي ارسل كلمه تحديث لتغير المطور ")
local A = io.open("./Info.lua", 'w')
A:write([[
do local Info = {
SUDO = "]]..IdDe..[[",
UserName = "HH6HHH",
token = "]]..token..[["
}
return Info
end
]])
A:close()
database:del(bot_id.."DEV:Sudo:T")
end
end
if text and text:match("^(gpinfo)$") or text and text:match("^معلومات الكروب$") then
function gpinfo(arg,data)
-- vardump(data) 
FoXdx(msg.chat_id_, msg.id_, ' ◐ ايدي المجموعة » ( '..msg.chat_id_..' )\n ◐ عدد الادمنيه » ( *'..data.administrator_count_..' )*\n ◐ عدد المحظورين » ( *'..data.kicked_count_..' )*\n ◐ عدد الاعضاء » ( *'..data.member_count_..' )*\n', 'md') 
end 
getChannelFull(msg.chat_id_, gpinfo, nil) 
end


if text and text:match("^(gpinfo)$") or text and text:match("^معلومات الكروب$") then
function gpinfo(arg,data)
-- vardump(data) 
FoXdx(msg.chat_id_, msg.id_, '◐ ايدي المجموعة » ( '..msg.chat_id_..' )\n ◐ عدد الادمنيه » ( '..data.administrator_count_..' )\n ◐ عدد المحظورين » ( '..data.kicked_count_..' )\n ◐ عدد الاعضاء » ( '..data.member_count_..' )\n', 'md') 
end 
getChannelFull(msg.chat_id_, gpinfo, nil) 
end
-----------
if text ==("مسح") and Mod(msg) and tonumber(msg.reply_to_message_id_) > 0 then
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
end   
if database:get(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'id:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, " ◐ تم الغاء الامر ") 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'id:user'..msg.chat_id_)  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..iduserr,numadded)  
send(msg.chat_id_, msg.id_," ◐ تم اضافة له {"..numadded..'} من الرسائل')  
end
------------------------------------------------------------------------
if database:get(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'idgem:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, " ◐ تم الغاء الامر ") 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'idgem:user'..msg.chat_id_)  
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_, msg.id_,  1, "??| تم اضافة له {"..numadded..'} من النقود', 1 , 'md')  
end
------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then    
amir = text:match("^اضف رسائل (%d+)$")
database:set(bot_id..'id:user'..msg.chat_id_,amir)  
database:setex(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, ' ◐ ارسل لي عدد الرسائل الان') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
amir = text:match("^اضف نقاط (%d+)$")
database:set(bot_id..'idgem:user'..msg.chat_id_,amir)  
database:setex(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, ' ◐ ارسل لي عدد النقاط التي تريد اضافتها') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف نقاط (%d+)$")
function reply(extra, result, success)
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_," ◐ تم اضافة له {"..Num..'} من النقاط')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف رسائل (%d+)$")
function reply(extra, result, success)
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_, "\n ◐ تم اضافة له {"..Num..'} من الرسائل')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
if text == 'نقاط' or text == 'نقاطي' then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*◐  𝒘𝒊𝒍𝒄𝒐𝒎𝒆 𝒇𝒐𝒙 ◐\n◐ لايمكنك استخدام البوت ◐\n◐ عليك الاشتراك في القناة ◐\n◐ اشترك اولا ['..database:get(bot_id..'add:ch:username')..'◐]*')
end
return false
end
local Num = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = ' ◐ لم تلعب اي لعبه للحصول على نقاط'
else
Text = ' ◐ عدد نقاطك التي ربحتها هيه *» { '..Num..' } نقاط *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match("^بيع نقاطي (%d+)$") or text and text:match("^بيع نقاط (%d+)$") then
local NUMPY = text:match("^بيع نقاطي (%d+)$") or text and text:match("^بيع نقاط (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ◐ لا تستطيع استخدام البوت \n  ◐ يرجى الاشتراك بالقناه اولا \n  ◐ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n* ◐ لا استطيع البيع اقل من 1 *") 
return false 
end
if tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,' ◐ ليس لديك نقاط في الالعاب\n ◐ اذا كنت تريد ربح نقاط \n ◐ ارسل الالعاب وابدأ اللعب ! ') 
else
local NUM_GAMES = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,'\n ◐ ليس لديك نقاط في هذه لعبه \n ◐ لزيادة نقاطك في اللعبه \n ◐ ارسل الالعاب وابدأ اللعب !') 
return false 
end
local NUMNKO = (NUMPY * 50)
database:decrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,NUMPY)  
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,' ◐ تم خصم *» { '..NUMPY..' }* من نقاطك \n ◐ وتم اضافة* » { '..(NUMPY * 50)..' } رساله الى رسالك *')
end 
return false 
end
if text == 'فحص البوت' and Manager(msg) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. bot_id..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = 'ꪜ' else info = '✘' end
if Json_Info.result.can_delete_messages == true then
delete = 'ꪜ' else delete = '✘' end
if Json_Info.result.can_invite_users == true then
invite = 'ꪜ' else invite = '✘' end
if Json_Info.result.can_pin_messages == true then
pin = 'ꪜ' else pin = '✘' end
if Json_Info.result.can_restrict_members == true then
restrict = 'ꪜ' else restrict = '✘' end
if Json_Info.result.can_promote_members == true then
promote = 'ꪜ' else promote = '✘' end 
send(msg.chat_id_,msg.id_,'\n ◐ اهلا عزيزي البوت هنا ادمن'..'\n ◐ وصلاحياته هي ↓ \nٴ━━━━━━━━━━'..'\n ◐ تغير معلومات الكروب ↞ ❴ '..info..' ❵'..'\n ◐ حذف الرسائل ↞ ❴ '..delete..' ❵'..'\n ◐ حظر المستخدمين ↞ ❴ '..restrict..' ❵'..'\n ◐ دعوة مستخدمين ↞ ❴ '..invite..' ❵'..'\n ◐ تثبيت الرسائل ↞ ❴ '..pin..' ❵'..'\n ◐ اضافة مشرفين جدد ↞ ❴ '..promote..' ❵')   
end
end
end


if text and text:match("^تغير رد المطور (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المطور (.*)$") 
database:set(bot_id.."Sudo:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ◐ تم تغير رد المطور الى » "..Teext)
end
if text and text:match("^تغير رد منشئ الاساسي (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد منشئ الاساسي (.*)$") 
database:set(bot_id.."BasicConstructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ◐ تم تغير رد المنشئ الاساسي الى » "..Teext)
end
if text and text:match("^تغير رد المنشئ (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المنشئ (.*)$") 
database:set(bot_id.."Constructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ◐ تم تغير رد المنشئ الى » "..Teext)
end
if text and text:match("^تغير رد المدير (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المدير (.*)$") 
database:set(bot_id.."Manager:Rd"..msg.chat_id_,Teext) 
send(msg.chat_id_, msg.id_," ◐ تم تغير رد المدير الى » "..Teext)
end
if text and text:match("^تغير رد الادمن (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد الادمن (.*)$") 
database:set(bot_id.."Mod:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ◐ تم تغير رد الادمن الى » "..Teext)
end
if text and text:match("^تغير رد المميز (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المميز (.*)$") 
database:set(bot_id.."Special:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ◐ تم تغير رد المميز الى » "..Teext)
end
if text and text:match("^تغير رد العضو (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد العضو (.*)$") 
database:set(bot_id.."Memp:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ◐ تم تغير رد العضو الى » "..Teext)
end

if text and text:match("^(.*)$") then
if database:get(bot_id..'help'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◐ تم حفظ الكليشه')
database:del(bot_id..'help'..msg.sender_user_id_)
database:set(bot_id..'help_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help1'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◐ تم حفظ الكليشه')
database:del(bot_id..'help1'..msg.sender_user_id_)
database:set(bot_id..'help1_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help2'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◐ تم حفظ الكليشه')
database:del(bot_id..'help2'..msg.sender_user_id_)
database:set(bot_id..'help2_text',text)
return false
end
end

if text and text:match("^(.*)$") then
if database:get(bot_id..'help3'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◐ تم حفظ الكليشه')
database:del(bot_id..'help3'..msg.sender_user_id_)
database:set(bot_id..'help3_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help4'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◐ تم حفظ الكليشه')
database:del(bot_id..'help4'..msg.sender_user_id_)
database:set(bot_id..'help4_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help5'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◐ تم حفظ الكليشه')
database:del(bot_id..'help5'..msg.sender_user_id_)
database:set(bot_id..'help5_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help6'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◐ تم حفظ الكليشه')
database:del(bot_id..'help6'..msg.sender_user_id_)
database:set(bot_id..'help6_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help7'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◐ تم حفظ الكليشه')
database:del(bot_id..'help7'..msg.sender_user_id_)
database:set(bot_id..'help7_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help8'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◐ تم حفظ الكليشه')
database:del(bot_id..'help8'..msg.sender_user_id_)
database:set(bot_id..'help8_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help9'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◐ تم حفظ الكليشه')
database:del(bot_id..'help9'..msg.sender_user_id_)
database:set(bot_id..'help9_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help10'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◐ تم حفظ الكليشه')
database:del(bot_id..'help10'..msg.sender_user_id_)
database:set(bot_id..'help10_text',text)
return false
end
end

if text == 'استعاده الاوامر' and SudoBot(msg) then
database:del(bot_id..'help_text')
database:del(bot_id..'help1_text')
database:del(bot_id..'help2_text')
database:del(bot_id..'help3_text')
database:del(bot_id..'help4_text')
database:del(bot_id..'help5_text')
database:del(bot_id..'help6_text')
database:del(bot_id..'help7_text')
database:del(bot_id..'help8_text')
database:del(bot_id..'help9_text')
database:del(bot_id..'help10_text')
send(msg.chat_id_, msg.id_, ' ◐ تم استعادة الاوامر القديمه')
end
if text == 'تغير امر الاوامر' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, ' ◐ الان يمكنك ارسال الكليشه الاوامر')
database:set(bot_id..'help'..msg.sender_user_id_,'true')
return false 
end
if text == 'تغير امر م1' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, ' ◐ الان يمكنك ارسال الكليشه م1')
database:set(bot_id..'help1'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م2' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, ' ◐ الان يمكنك ارسال الكليشه م2')
database:set(bot_id..'help2'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م3' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, ' ◐ الان يمكنك ارسال الكليشه م3')
database:set(bot_id..'help3'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م4' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, ' ◐ الان يمكنك ارسال الكليشه م4')
database:set(bot_id..'help4'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م5' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, ' ◐ الان يمكنك ارسال الكليشه م5')
database:set(bot_id..'help5'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م6' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, ' ◐ الان يمكنك ارسال الكليشه م6')
database:set(bot_id..'help6'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م7' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, ' ◐ الان يمكنك ارسال الكليشه م7')
database:set(bot_id..'help7'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م8' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, ' ◐  الان يمكنك ارسال الكليشه م8')
database:set(bot_id..'help8'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م9' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, ' ◐ الان يمكنك ارسال الكليشه م9')
database:set(bot_id..'help9'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م10' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, ' ◐ الان يمكنك ارسال الكليشه م10')
database:set(bot_id..'help10'..msg.sender_user_id_,'true')
return false 
end

if text == 'الاوامر' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,' ◐ هاذا الامر خاص بالادمنيه\n ◐ ارسل {م10} لعرض اوامر الاعضاء')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help_text')
Text = [[
*ʜɪ ғᴏx*
*◐اۿلا ؏ـزيزي الاوامࢪ ڪلتالي◐*
*  ٴ◐○◐○◐○◐○◐*
*◐م𝟭 ➭- اوامࢪ الحمايهہ*
*◐م𝟮 ➭- اوامࢪ اࢦتعطيࢦ ~ اࢦتفعيࢦ*
*◐م𝟯 ➭- اوامࢪ ضع ~ اضفہ*
*◐م𝟰 ➭- اوامࢪ مسح ~ حذفہ*
*◐م𝟱 ➭- اوامࢪ تنزيࢦ ~ ࢪفع ~ اࢦتغيࢪ*
*◐م𝟲 ➭- اوامࢪ اࢦڪروبہ*
*◐م𝟳 ➭- اوامࢪ اࢦتسلية*
*◐م𝟴 ➭- اوامࢪ مطوࢪ اࢦبوتہ*
*  ٴ◐○◐○◐○◐○◐*
𝘊𝘩 - [𝖋𝖔𝖝  𓅛](t.me/IIIIlI8)◐
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⁦❶', callback_data="/help1"},{text = '❷', callback_data="/help2"},{text = '⁦❸', callback_data="/help3"},
},
{
{text = '❹', callback_data="/help4"},{text = '❺', callback_data="/help5"},{text = '❻', callback_data="/help6"},
},
{
{text = '❼', callback_data="/help7"},{text = '⁦❽', callback_data="/help8"},
},
{
{text = '•اغلاق', callback_data="/sad"},
},
{
{text = '𝑭𝑶𝑿 𝑺𝑶𝑼𝑹𝑪𝑬', url="t.me/IIIIlI8"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
if text == 'م1' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'◐ هاذا الامر خاص بالادمنيه\n◐ ارسل {م10} لعرض اوامر الاعضاء')
return false
end
print(AddChannel(msg.sender_user_id_))
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help1_text')
Text = [[
*اﯡامࢪ الحمايهہ ڪلتالي *
*◐○◐○◐○◐○◐ٴ*
*◐ قفࢦ + فتح › اࢦامࢪ*
*◐ › { باࢦتقيد › باࢦطࢪد › باࢦڪتم }*
*◐○◐○◐○◐○◐ٴ*
*◐ اࢦࢪﯡابط*
*◐ اࢦمعࢪف*
*◐ اࢦتاڪ*
*◐ اࢦشارحهہ *
*◐ اࢦتعديࢦ*
*◐ اࢦتثبيت*
*◐ اࢦمتحࢪڪهہ *
*◐ اࢦمࢦفات*
*◐ اࢦصـﯡࢪ*
*◐ اࢦتفࢦيش*
*◐ قفࢦ الاباحي*
*◐○◐○◐○◐○◐ٴ*
*◐ اࢦمارڪداﯡטּ*
*◐ اࢦبوتات*
*◐ التڪࢪاࢪ*
*◐ الڪࢦلايش*
*◐ اࢦسيࢦفي *
*◐ اࢦمࢦصقات *
*◐ اࢦفيديـﯡ *
*◐ اࢦانلايـטּ*
*◐ اࢦدردشهہ *
*◐○◐○◐○◐○◐ٴ*
*◐ اࢦتوجيهہ *
*◐ اࢦاغاني *
*◐ اࢦصوت *
*◐ اࢦجهات *
*◐ اࢦاشعاࢪات *
*◐○◐○◐○◐○◐ٴ*
𝘊𝘩 - [𝖋𝖔𝖝  𓅛](t.me/IIIIlI8)◐
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م2' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'◐ هاذا الامر خاص بالادمنيه\n◐ ارسل {م10} لعرض اوامر الاعضاء')
return false
end
print(AddChannel(msg.sender_user_id_))
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help2_text')
Text = [[
*◐ اهلا بڪ ؏ـزيزي*
*◐○◐○◐○◐○◐ٴ*
*◐ تفعيࢦ ~ تعطيࢦ + امࢪ*
*◐○◐○◐○◐○◐ٴ*
*◐ اطࢪدني*
*◐ صيح*
*◐ ضافني*
*◐ اࢦࢪابط*
*◐ اࢦحظࢪ*
*◐ اࢦافࢦلام*
*◐ اࢦاضافات*
*◐ اࢦࢪفع*
*◐ اࢦايدي*
*◐ اࢦاࢦعاب*
*◐ ࢪدود اࢦمطوࢪ*
*◐ اࢦتࢪحيب*
*◐ ࢪدود اࢦمديࢪ*
*◐ اࢦࢪدود*
*◐ ࢪدود اࢦبوت*
*◐ اﯡامࢪ اࢦتحشيش*
*◐ صوࢪتي*
*◐ زخࢪفهہ *
*◐ اࢦابࢪاج*
* ◐ اࢦحمايۿ*
*◐○◐○◐○◐○◐ٴ*
𝘊𝘩 - [𝖋𝖔𝖝  𓅛](t.me/IIIIlI8)◐
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م3' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'◐ هاذا الامر خاص بالادمنيه\n◐ ارسل {م10} لعرض اوامر الاعضاء')
return false
end
print(AddChannel(msg.sender_user_id_))
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help3_text')
Text = [[
*◐ اهلا بڪ ؏ـزيزي*
*◐○◐○◐○◐○◐ٴ*
*◐ اﯡامࢪ اࢦوضع ~ اضف*
*◐○◐○◐○◐○◐ٴ*
*◐ اضف › حذف › ࢪد*
*◐ اضف › حذف › صࢦلاحيهہ *
*◐○◐○◐○◐○◐ٴ*
*◐ ضع + امࢪ*
*◐○◐○◐○◐○◐ٴ*
*◐ آسم*
*◐ ࢪابط*
*◐ تࢪحيب*
*◐ قـﯡانيـטּ*
*◐ صـﯡࢪۿ*
*◐ ﯡصف*
*◐ تڪࢪاࢪ + ؏ـدد*
*◐○◐○◐○◐○◐ٴ*
𝘊𝘩 - [𝖋𝖔𝖝  𓅛](t.me/IIIIlI8)◐
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
 if text == 'م4' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'◐ هاذا الامر خاص بالادمنيه\n◐ ارسل {م10} لعرض اوامر الاعضاء')
return false
end
print(AddChannel(msg.sender_user_id_))
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help4_text')
Text = [[
*◐ اهلا بڪ ؏ـزيزي*
*◐ اوامر مسح › الحذف › امر*
*◐○◐○◐○◐○◐ٴ*
*◐ مسح + امࢪ*
*◐○◐○◐○◐○◐ٴ*
*◐ اࢦايدي*
*◐ اࢦادمنيهہ *
*◐ اࢦمميزيـטּ*
*◐ ࢪدود اࢦمديࢪ*
*◐ اࢦمدࢪاء*
*◐ اࢦمنشئيـטּ *
*◐ اࢦاساسيـטּ*
*◐ قائمهہ اࢦماࢦڪ*
*◐ اࢦبـﯡتات*
*◐ امسح*
*◐ صࢦلاحيهہ *
*◐ قائمهہ منع اࢦمتحࢪڪات*
*◐ قائمهہ منع اࢦصـﯡࢪ*
*◐ قائمهہ منع اࢦمࢦصقات*
*◐ مسح قائمهہ المنع*
*◐ اࢦمحذﯡفيـטּ*
*◐ اࢦاﯡامࢪ اࢦمضافهہ *
*◐○◐○◐○◐○◐ٴ*
𝘊𝘩 - [𝖋𝖔𝖝  𓅛](t.me/IIIIlI8)◐
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
 if text == 'م5' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'◐ هاذا الامر خاص بالادمنيه\n◐ ارسل {م10} لعرض اوامر الاعضاء')
return false
end
print(AddChannel(msg.sender_user_id_))
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help5_text')
Text = [[
*◐ اهلا بڪ ؏ـزيزي*
*◐○◐○◐○◐○◐ٴ*
*◐ اوامࢪ التنزيࢦ والࢪفع*
*◐○◐○◐○◐○◐ٴ*
*◐ مميز*
*◐ ادمن*
*◐ مديࢪ*
*◐ منشئ*
*◐ منشئ اساسي*
*◐ ماࢦڪ*
*◐ اࢦادمنيهہ *
*◐ ادمن باࢦڪروب*
*◐ ادمن بڪࢦ اࢦصࢦلاحيات*
*◐ اࢦقيود*
*◐ تنزيࢦ جميع الࢪتب*
*◐○◐○◐○◐○◐ٴ*
*◐ اوامࢪ اࢦتغيࢪ*
*◐○◐○◐○◐○◐ٴ*
*◐ تغيࢪ ࢪد اࢦمطوࢪ + اسم*
*◐ تغيࢪ ࢪد منشئ اࢦاساسي + اسم*
*◐ تغيࢪ ࢪد اࢦمنشئ + اسم*
*◐ تغيࢪ ࢪد اࢦمديࢪ + اسم*
*◐ تغيࢪ ࢪد اࢦادمن + اسم*
*◐ تغيࢪ ࢪد اࢦمميز + اسم*
*◐ تغيࢪ ࢪد اࢦعضـﯡ + اسم*
*◐ تغيࢪ امࢪ اࢦاوامࢪ*
*◐ تغيࢪ امࢪ م1 ~ الئ م10*
*◐○◐○◐○◐○◐ٴ*
𝘊𝘩 - [𝖋𝖔𝖝  𓅛](t.me/IIIIlI8)◐
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م6' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'◐ هاذا الامر خاص بالادمنيه\n◐ ارسل {م10} لعرض اوامر الاعضاء')
return false
end
print(AddChannel(msg.sender_user_id_))
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help6_text')
Text = [[
*◐ اهلا بڪ ؏ـزيزي*
*◐ اوامࢪ اࢦمجموعه*
*◐○◐○◐○◐○◐ٴ*
*◐ اࢦاوامࢪ ڪالتالي*
*◐○◐○◐○◐○◐ٴ*
*◐ استعاده اࢦاوامࢪ*
*◐ صيح › تاڪ › اࢦمميزين : اࢦادمنيه : اࢦمدࢪاء : اࢦمنشئين : اࢦمنشئين اࢦاساسين : لࢦماࢦڪ*
*◐ ڪشف اࢦقيـﯡد *
*◐ تعين اࢦايدي*
*◐ تغيࢪ اࢦايدي*
*◐ اࢦحساب + ايدي اࢦحساب*
*◐ تنظيف + اࢦعدد*
*◐ تنزيࢦ اࢦڪࢦ*
*◐ تنزيࢦ جميع اࢦࢪتب*
*◐ منع + بࢪد*
*◐ الصوࢪ + متحࢪڪه + مࢦصق *
*◐ حظࢪ › ڪتم › تقيد › طࢪد*
*◐ اࢦمحظـﯡࢪيـטּ › اࢦمڪتـﯡميـטּ › المقيدين*
*◐ اࢦغاء ڪتم + حظࢪ + تقيد › باࢦࢪد و معࢪف و ايدي*
*◐ تقيد ~ ڪتم + اࢦࢪقم + ساعه*
*◐ تقيد ~ ڪتم + اࢦࢪقم + يوم*
*◐ تقيد ~ ڪتم + اࢦࢪقم + دقيقهہ *
*◐ تثبيت ~ الغاء تثبيت*
*◐ اࢦتࢪحيب*
*◐ اࢦغاء تثبيت اࢦكل *
*◐ ڪشف اࢦبـﯡتات*
*◐ اࢦصࢦلاحيات*
*◐ ڪشف › برد › بمعرف › ايدي*
*◐ تاڪ ࢦࢦكࢦ*
*◐ تاڪ ࢦࢦمشرفيـטּ*
*◐ اعدادات اࢦمجمـﯡعهہ *
*◐ عدد اࢦڪࢪوب*
*◐ ࢪدود اࢦمديࢪ*
*◐ اسم بوت + اࢦࢪتبهہ *
*◐ اࢦاﯡامࢪ اࢦمضافهہ *
*◐ قائمهہ اࢦمنع*
*◐ نسبهہ الحب *
*◐ نسبهہ ࢪجوࢦه*
*◐○◐○◐○◐○◐ٴ*
𝘊𝘩 - [𝖋𝖔𝖝  𓅛](t.me/IIIIlI8)◐
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م7' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'◐ هاذا الامر خاص بالادمنيه\n◐ ارسل {م10} لعرض اوامر الاعضاء')
return false
end
print(AddChannel(msg.sender_user_id_))
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help7_text')
Text = [[
*◐ اوامࢪ اࢦتسࢦيه*
*◐○◐○◐○◐○◐ٴ*
*◐ ࢪفع + تنزيࢦ › اࢦامࢪ*
*◐○◐○◐○◐○◐ٴ*
*◐ ࢪفع + تنزيࢦ › مطي *
*◐ تاڪ ࢦࢦمطايه*
*◐ ࢪفع + تنزيࢦ › صخࢦ*
*◐ تاڪ ࢦصخوࢦه*
*◐ ࢪفع + تنزيࢦ › جࢦب*
*◐ تاڪ ࢦجࢦلاب*
*◐ ࢪفع + تنزيࢦ › اثوࢦ*
*◐ تاڪ ࢦثولان*
*◐ ࢪفع + تنزيࢦ › بڪلبي*
*◐ تاڪ ࢦلي بڪلبي*
*◐ ࢪفع + تنزيࢦ › زاحف *
*◐ تاڪ ࢦزﯡاحف*
*◐ ࢪفع + تنزيࢦ › اࢦحات*
*◐ تاڪ ࢦࢦحات*
*◐ ࢪفع تنزيࢦ › عࢪوسه*
* ◐ تاڪ ࢦࢦعࢪوسات*
*◐ ࢪفع تنزيࢦ › شيخ*
*◐ تاڪ ࢦࢦشيوخ*
*◐ ࢪفع تنزيࢦ › تاج*
*◐ تاڪ ࢦࢦتوج*
*◐ ࢪفع + تنزيࢦ › اࢦحاته*
*◐ تاڪ ࢦࢦحاتات*
*◐ زﯡاج › طࢦلاق*
*◐ ۿينه › ࢪزࢦه*
*◐○◐○◐○◐○◐ٴ*
𝘊𝘩 - [𝖋??𝖝  𓅛](t.me/IIIIlI8)◐
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م8' then
if not Sudo(msg) then
send(msg.chat_id_, msg.id_,'◐ هاذا الامر خاص بمطور\n◐ ارسل {م10} لعرض اوامر الاعضاء')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help8_text')
Text = [[
*◐ اهلا بڪ ؏ـزيزي*
*◐○○○○○○○ٴ◐*
*◐اوامࢪ المطوࢪين*
*◐○◐○◐○◐○◐ٴ*
*◐ تفعيࢦ › تعطيࢦ *
*◐ اࢦمجموعات › اࢦمشترڪين › اࢦاحصائيات*
*◐ ࢪفع › تنزيࢦ منشئ اساسي*
*◐ مسح اࢦاساسين › اࢦمنشئين اࢦاساسين*
*◐ مسح اࢦمنشئين › اࢦمنشئين*
*◐ ࢪفع › تنزيࢦ مالڪ*
*◐ مسح قائمه اࢦماࢦڪ *
*◐ اسم › ايدي + بوت غادࢪ*
*◐ اذاعه *
*◐ ࢪدود اࢦمطوࢪ *
◐○◐○◐○◐○◐ٴ
𝘊𝘩 - [𝖋𝖔𝖝  𓅛](t.me/IIIIlI8)◐
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م9' then
if not Sudo(msg) then
send(msg.chat_id_, msg.id_,'◐ هاذا الامر خاص بالمطور الاساسي\n◐ ارسل {م10} لعرض اوامر الاعضاء')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help9_text')
Text = [[
*◐ اهلا بڪ ؏ـزيزي*
*◐○◐○◐○◐○◐ٴ*
*◐ اوامࢪ اࢦمطوࢪ الاساسي↓*
*◐○◐○◐○◐○◐ٴ*
*◐ تفعيࢦ*
*◐ تعطيࢦ*
*◐ مسح اࢦاساسين*
*◐ اࢦمنشئين اࢦاساسين*
*◐ ࢪفع › تنزيࢦ منشئ اساسي*
*◐ ࢪفع › تنزيࢦ مطور ثانوي*
*◐ مسح اࢦمطوࢪين*
*◐ ࢪفع › تنزيࢦ مالڪ *
*◐ اࢦمطوࢪين*
*◐ رفع › تنزيل مطور*
*◐○◐○◐○◐○◐ٴ*
*◐ اسم اࢦبوت + غادࢪ*
*◐ غادࢪ*
*◐ اسم بوت + اࢦࢪتبه*
*◐ تحديث السوࢪس*
*◐ حظࢪ عام*
*◐ ڪتم عام*
*◐ اࢦغاء اࢦعام*
*◐ قائمه اࢦعام*
*◐ مسح قائمه اࢦعام*
*◐ جࢦب نسخه اࢦاحتياطيه*
*◐ ࢪفع نسخه اࢦاحتياطيه*
*◐○◐○◐○◐○◐ٴ*
*◐ اذاعه خاص*
*◐ اذاعه*
*◐ اذاعه باࢦتوجيه*
*◐ اذاعه باࢦتوجيه خاص*
*◐ اذاعه باࢦتثبيت*
*◐○◐○◐○◐○◐ٴ*
*◐ جࢦب نسخه اࢦبوت*
*◐ ࢪفع نسخه اࢦبوت*
*◐ ضع عدد اࢦاعضاء + اࢦعدد*
*◐ ضع كࢦيشه اࢦمطوࢪ*
*◐ تفعيࢦ › تعطيࢦ اࢦاذاعه*
*◐ تفعيࢦ › تعطيࢦ اࢦبوت اࢦخدمي*
*◐ تفعيࢦ › تعطيࢦ اࢦتواصࢦ*
*◐ تغيࢪ اسم اࢦبوت*
*◐ اضف › حذف ࢪد ࢦࢦڪࢦ*
*◐ ࢪدود اࢦمطوࢪ*
*◐ مسح ࢪدود اࢦمطوࢪ*
*◐○◐○◐○◐○◐ٴ*
*◐ اࢦاشتراڪ اࢦاجباࢪي*
*◐ تعطيࢦ الاشتࢪاڪ اࢦاجباࢪي*
*◐ تفعيࢦ اࢦاشتࢪاڪ اࢦاجباࢪي*
*◐ حذف ࢪساࢦه اࢦاشتࢪاڪ*
*◐ تغيࢪ ࢪساࢦه اࢦاشتࢪاڪ*
*◐ تغيࢪ اࢦاشتࢪاڪ*
*◐○◐○◐○◐○◐ٴ*
*◐ اࢦاحصائيات*
*◐ اࢦمشترڪين*
*◐ اࢦمجموعات *
*◐ تفعيࢦ › تعطيࢦ اࢦمغادره*
*◐ تنظيف اࢦمشتࢪڪين*
*◐ تنظيف اࢦڪࢪﯡبات*
 ◐○◐○◐○◐○◐ٴ
𝘊𝘩 - [𝖋𝖔𝖝  𓅛](t.me/IIIIlI8)◐
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م10' then
local help_text = database:get(bot_id..'help10_text')
Text = [[
*◐ اهلا بڪ ؏ـزيزي*
*◐ اوامࢪ اࢦاعضاء كتاࢦي↓*
*◐○◐○◐○◐○◐ٴ*
*◐ عࢪض معࢦوماتڪ ↑↓*
*◐○◐○◐○◐○◐ٴ*
*◐ ايديي › اسمي* 
*◐ رسايلي › مسح رسايلي* 
*◐ رتبتي › سحكاتي* 
*◐ مسح سحڪاتي › المنشئ* 
*◐○◐○◐○◐○◐ٴ*
*◐ اوآمࢪ اࢦمجموعه ↑↓*
*◐○◐○◐○◐○◐ٴ*
*◐ اࢦࢪابط › اࢦقوانين › اࢦترحيب*
*◐ ايدي › اطࢪدني* 
*◐ اسمي › اࢦمطوࢪ*
*◐ ڪشف › باࢦࢪد باࢦمعࢪف*
*◐○◐○◐○◐○◐ٴ*
*◐ اسم اࢦبوت + اࢦامر ↑↓*
*◐○◐○◐○◐○◐ٴ*
*◐ بوسه بالرد* 
*◐ مصه بالرد*
*◐ رزله بالرد* 
*◐○◐○◐○◐○◐ٴ*
𝘊𝘩 - [𝖋𝖔𝖝  𓅛](t.me/IIIIlI8)◐
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == "راسلني" then
rpl = {"ها هلاو","انطق","كول","تحب الحلفي @X_GGX"};
sender = rpl[math.random(#rpl)]
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendmessage?chat_id=' .. msg.sender_user_id_ .. '&text=' .. URL.escape(sender))
end
if text and text:match("^كول (.*)$") and not database:get(bot_id.."Speak:after:me"..msg.chat_id_) then
local Textxt = text:match("^كول (.*)$")
send(msg.chat_id_, msg.id_, '['..Textxt..']')
end
if text == "غنيلي" and not database:get(bot_id.."sing:for:me"..msg.chat_id_) then
data,res = https.request('https://black-source.tk/BlackTeAM/audios.php')
if res == 200 then
audios = json:decode(data)
if audios.Info == true then
local Text ='◐تم اختيار المقطع الصوتي لك'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '𝑭𝑶𝑿 𝑺𝑶𝑼𝑹𝑪𝑬 ♔︎',url="t.me/IIIIlI8"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice='..URL.escape(audios.info)..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
if text == "الساعه" then
local ramsesj20 = "\n الساعه الان : "..os.date("%I:%M%p")
send(msg.chat_id_, msg.id_,ramsesj20)
end

if text == "التاريخ" then
local ramsesj20 =  "\n التاريخ : "..os.date("%Y/%m/%d")
send(msg.chat_id_, msg.id_,ramsesj20)
end
if text == 'السمايلات' or text == 'السمايل' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
database:del(bot_id..'Set:Sma'..msg.chat_id_)
Random = {'🍏','🍎','🍐','🍊','??','🍉','🍇','🍓','🍈','🍒','🍑','🍍','??','🥝','🍅','🍆','🥑','??','🥒','🌶','🌽','🥕','🥔','🥖','🥐','🍞','🥨','🍟','🧀','🥚','🍳','🥓','🥩','🍗','🍖','🌭','🍔','🍠','🍕','🥪','🥙','☕️','🍵','🥤','🍶','🍺','🍻','🏀','⚽️','🏈','⚾️','🎾','🏐','🏉','🎱','🏓','🏸','🥅','🎰','🎮','🎳','🎯','🎲','??','🎸','🎺','🥁','🎹','🎼','🎧','🎤','🎬','🎨','🎭','🎪','🎟','🎫','🎗','🏵','🎖','🏆','🥌','🛷','🚗','🚌','🏎','🚓','🚑','🚚','🚛','🚜','🇮🇶','⚔','🛡','🔮','🌡','💣','📌','📍','📓','📗','📂','📅','📪','📫','📬','📭','⏰','📺','🎚','☎️','📡'}
SM = Random[math.random(#Random)]
database:set(bot_id..'Random:Sm'..msg.chat_id_,SM)
send(msg.chat_id_, msg.id_,' ◐اسرع واحد يدز هاذا السمايل ? » {`'..SM..'`}')
return false
end
end
if text == ''..(database:get(bot_id..'Random:Sm'..msg.chat_id_) or '')..'' and not database:get(bot_id..'Set:Sma'..msg.chat_id_) then
if not database:get(bot_id..'Set:Sma'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,' ◐الف مبروك لقد فزت \n ◐للعب مره اخره ارسل »{ سمايل , سمايلات }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Sma'..msg.chat_id_,true)
return false
end 
if text == 'اسرع' or text == 'الاسرع' or text == 'ترتيب' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
database:del(bot_id..'Speed:Tr'..msg.chat_id_)
KlamSpeed = {'سحور','سياره','استقبال','قنفه','ايفون','بزونه','مطبخ','كرستيانو','دجاجه','مدرسه','الوان','غرفه','ثلاجه','كهوه','سفينه','العراق','محطه','طياره','رادار','منزل','مستشفى','كهرباء','تفاحه','اخطبوط','سلمون','فرنسا','برتقاله','تفاح','مطرقه','بتيته','لهانه','شباك','باص','سمكه','ذباب','تلفاز','حاسوب','انترنيت','ساحه','جسر'};
name = KlamSpeed[math.random(#KlamSpeed)]
database:set(bot_id..'Klam:Speed'..msg.chat_id_,name)
name = string.gsub(name,'سحور','س ر و ح')
name = string.gsub(name,'سياره','ه ر س ي ا')
name = string.gsub(name,'استقبال','ل ب ا ت ق س ا')
name = string.gsub(name,'قنفه','ه ق ن ف')
name = string.gsub(name,'ايفون','و ن ف ا')
name = string.gsub(name,'بزونه','ز و ه ن')
name = string.gsub(name,'مطبخ','خ ب ط م')
name = string.gsub(name,'كرستيانو','س ت ا ن و ك ر ي')
name = string.gsub(name,'دجاجه','ج ج ا د ه')
name = string.gsub(name,'مدرسه','ه م د ر س')
name = string.gsub(name,'الوان','ن ا و ا ل')
name = string.gsub(name,'غرفه','غ ه ر ف')
name = string.gsub(name,'ثلاجه','ج ه ت ل ا')
name = string.gsub(name,'كهوه','ه ك ه و')
name = string.gsub(name,'سفينه','ه ن ف ي س')
name = string.gsub(name,'العراق','ق ع ا ل ر ا')
name = string.gsub(name,'محطه','ه ط م ح')
name = string.gsub(name,'طياره','ر ا ط ي ه')
name = string.gsub(name,'رادار','ر ا ر ا د')
name = string.gsub(name,'منزل','ن ز م ل')
name = string.gsub(name,'مستشفى','ى ش س ف ت م')
name = string.gsub(name,'كهرباء','ر ب ك ه ا ء')
name = string.gsub(name,'تفاحه','ح ه ا ت ف')
name = string.gsub(name,'اخطبوط','ط ب و ا خ ط')
name = string.gsub(name,'سلمون','ن م و ل س')
name = string.gsub(name,'فرنسا','ن ف ر س ا')
name = string.gsub(name,'برتقاله','ر ت ق ب ا ه ل')
name = string.gsub(name,'تفاح','ح ف ا ت')
name = string.gsub(name,'مطرقه','ه ط م ر ق')
name = string.gsub(name,'بتيته','ب ت ت ي ه')
name = string.gsub(name,'لهانه','ه ن ل ه ل')
name = string.gsub(name,'شباك','ب ش ا ك')
name = string.gsub(name,'باص','ص ا ب')
name = string.gsub(name,'سمكه','ك س م ه')
name = string.gsub(name,'ذباب','ب ا ب ذ')
name = string.gsub(name,'تلفاز','ت ف ل ز ا')
name = string.gsub(name,'حاسوب','س ا ح و ب')
name = string.gsub(name,'انترنيت','ا ت ن ر ن ي ت')
name = string.gsub(name,'ساحه','ح ا ه س')
name = string.gsub(name,'جسر','ر ج س')
send(msg.chat_id_, msg.id_,' ◐اسرع واحد يرتبها » {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..'Klam:Speed'..msg.chat_id_) or '')..'' and not database:get(bot_id..'Speed:Tr'..msg.chat_id_) then
if not database:get(bot_id..'Speed:Tr'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,' ◐الف مبروك لقد فزت \n ◐للعب مره اخره ارسل »{ الاسرع , ترتيب }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Speed:Tr'..msg.chat_id_,true)
end 

if text == 'الحزوره' or text == 'حزوره' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
database:del(bot_id..'Set:Hzora'..msg.chat_id_)
Hzora = {'الجرس','عقرب الساعه','السمك','المطر','5','الكتاب','البسمار','7','الكعبه','بيت الشعر','لهانه','انا','امي','الابره','الساعه','22','غلط','كم الساعه','البيتنجان','البيض','المرايه','الضوء','الهواء','الضل','العمر','القلم','المشط','الحفره','البحر','الثلج','الاسفنج','الصوت','بلم'};
name = Hzora[math.random(#Hzora)]
database:set(bot_id..'Klam:Hzor'..msg.chat_id_,name)
name = string.gsub(name,'الجرس','شيئ اذا لمسته صرخ ما هوه ؟')
name = string.gsub(name,'عقرب الساعه','اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟')
name = string.gsub(name,'السمك','ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟')
name = string.gsub(name,'المطر','شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟')
name = string.gsub(name,'5','ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ')
name = string.gsub(name,'الكتاب','ما الشيئ الذي له اوراق وليس له جذور ؟')
name = string.gsub(name,'البسمار','ما هو الشيئ الذي لا يمشي الا بالضرب ؟')
name = string.gsub(name,'7','عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ')
name = string.gsub(name,'الكعبه','ما هو الشيئ الموجود وسط مكة ؟')
name = string.gsub(name,'بيت الشعر','ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ')
name = string.gsub(name,'لهانه','وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ')
name = string.gsub(name,'انا','ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟')
name = string.gsub(name,'امي','اخت خالك وليست خالتك من تكون ؟ ')
name = string.gsub(name,'الابره','ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ')
name = string.gsub(name,'الساعه','ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟')
name = string.gsub(name,'22','كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ')
name = string.gsub(name,'غلط','ما هي الكلمه الوحيده التي تلفض غلط دائما ؟ ')
name = string.gsub(name,'كم الساعه','ما هو السؤال الذي تختلف اجابته دائما ؟')
name = string.gsub(name,'البيتنجان','جسم اسود وقلب ابيض وراس اخظر فما هو ؟')
name = string.gsub(name,'البيض','ماهو الشيئ الذي اسمه على لونه ؟')
name = string.gsub(name,'المرايه','ارى كل شيئ من دون عيون من اكون ؟ ')
name = string.gsub(name,'الضوء','ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟')
name = string.gsub(name,'الهواء','ما هو الشيئ الذي يسير امامك ولا تراه ؟')
name = string.gsub(name,'الضل','ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ')
name = string.gsub(name,'العمر','ما هو الشيء الذي كلما طال قصر ؟ ')
name = string.gsub(name,'القلم','ما هو الشيئ الذي يكتب ولا يقرأ ؟')
name = string.gsub(name,'المشط','له أسنان ولا يعض ما هو ؟ ')
name = string.gsub(name,'الحفره','ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟')
name = string.gsub(name,'البحر','ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟')
name = string.gsub(name,'الثلج','انا ابن الماء فان تركوني في الماء مت فمن انا ؟')
name = string.gsub(name,'الاسفنج','كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟')
name = string.gsub(name,'الصوت','اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟')
name = string.gsub(name,'بلم','حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ')
send(msg.chat_id_, msg.id_,' ◐اسرع واحد يحل الحزوره ↓\n {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..'Klam:Hzor'..msg.chat_id_) or '')..'' and not database:get(bot_id..'Set:Hzora'..msg.chat_id_) then
if not database:get(bot_id..'Set:Hzora'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,' ◐الف مبروك لقد فزت \n ◐للعب مره اخره ارسل »{ حزوره }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Hzora'..msg.chat_id_,true)
end 

if text == 'المعاني' or text == 'معاني' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
database:del(bot_id..'Set:Maany'..msg.chat_id_)
Maany_Rand = {'قرد','دجاجه','بطريق','ضفدع','بومه','نحله','ديك','جمل','بقره','دولفين','تمساح','قرش','نمر','اخطبوط','سمكه','خفاش','اسد','فأر','ذئب','فراشه','عقرب','زرافه','قنفذ','تفاحه','باذنجان'}
name = Maany_Rand[math.random(#Maany_Rand)]
database:set(bot_id..'Maany'..msg.chat_id_,name)
name = string.gsub(name,'قرد','🐒')
name = string.gsub(name,'دجاجه','🐔')
name = string.gsub(name,'بطريق','🐧')
name = string.gsub(name,'ضفدع','🐸')
name = string.gsub(name,'بومه','🦉')
name = string.gsub(name,'نحله','🐝')
name = string.gsub(name,'ديك','🐓')
name = string.gsub(name,'جمل','🐫')
name = string.gsub(name,'بقره','🐄')
name = string.gsub(name,'دولفين','??')
name = string.gsub(name,'تمساح','🐊')
name = string.gsub(name,'قرش','🦈')
name = string.gsub(name,'نمر','🐅')
name = string.gsub(name,'اخطبوط','🐙')
name = string.gsub(name,'سمكه','🐟')
name = string.gsub(name,'خفاش','🦇')
name = string.gsub(name,'اسد','🦁')
name = string.gsub(name,'فأر','🐭')
name = string.gsub(name,'ذئب','🐺')
name = string.gsub(name,'فراشه','🦋')
name = string.gsub(name,'عقرب','🦂')
name = string.gsub(name,'زرافه','🦒')
name = string.gsub(name,'قنفذ','🦔')
name = string.gsub(name,'تفاحه','🍎')
name = string.gsub(name,'باذنجان','🍆')
send(msg.chat_id_, msg.id_,' ◐اسرع واحد يدز معنى السمايل » {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..'Maany'..msg.chat_id_) or '')..'' and not database:get(bot_id..'Set:Maany'..msg.chat_id_) then
if not database:get(bot_id..'Set:Maany'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'◐الف مبروك لقد فزت \n ◐للعب مره اخره ارسل »{ معاني }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Maany'..msg.chat_id_,true)
end 
if text == 'العكس' or text == 'عكس' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
database:del(bot_id..'Set:Aks'..msg.chat_id_)
katu = {'باي','فهمت','موزين','اسمعك','احبك','موحلو','نضيف','حاره','ناصي','جوه','سريع','ونسه','طويل','سمين','ضعيف','شريف','شجاع','رحت','عدل','نشيط','شبعان','موعطشان','خوش ولد','اني','هادئ'}
name = katu[math.random(#katu)]
database:set(bot_id..'Set:Aks:Game'..msg.chat_id_,name)
name = string.gsub(name,'باي','هلو')
name = string.gsub(name,'فهمت','مافهمت')
name = string.gsub(name,'موزين','زين')
name = string.gsub(name,'اسمعك','ماسمعك')
name = string.gsub(name,'احبك','ماحبك')
name = string.gsub(name,'موحلو','حلو')
name = string.gsub(name,'نضيف','وصخ')
name = string.gsub(name,'حاره','بارده')
name = string.gsub(name,'ناصي','عالي')
name = string.gsub(name,'جوه','فوك')
name = string.gsub(name,'سريع','بطيء')
name = string.gsub(name,'ونسه','ضوجه')
name = string.gsub(name,'طويل','قزم')
name = string.gsub(name,'سمين','ضعيف')
name = string.gsub(name,'ضعيف','قوي')
name = string.gsub(name,'شريف','كواد')
name = string.gsub(name,'شجاع','جبان')
name = string.gsub(name,'رحت','اجيت')
name = string.gsub(name,'عدل','ميت')
name = string.gsub(name,'نشيط','كسول')
name = string.gsub(name,'شبعان','جوعان')
name = string.gsub(name,'موعطشان','عطشان')
name = string.gsub(name,'خوش ولد','موخوش ولد')
name = string.gsub(name,'اني','مطي')
name = string.gsub(name,'هادئ','عصبي')
send(msg.chat_id_, msg.id_,' ◐اسرع واحد يدز العكس » {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..'Set:Aks:Game'..msg.chat_id_) or '')..'' and not database:get(bot_id..'Set:Aks'..msg.chat_id_) then
if not database:get(bot_id..'Set:Aks'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,' ◐الف مبروك لقد فزت \n ◐للعب مره اخره ارسل »{ العكس }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Aks'..msg.chat_id_,true)
end 

if database:get(bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
send(msg.chat_id_, msg.id_," ◐عذرآ لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }\n")
return false  end 
local GETNUM = database:get(bot_id.."GAMES:NUM"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
database:del(bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)
database:del(bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,5)  
send(msg.chat_id_, msg.id_,' ◐مبروك فزت ويانه وخمنت الرقم الصحيح\n ◐تم اضافة { 5 } من النقاط \n')
elseif tonumber(NUM) ~= tonumber(GETNUM) then
database:incrby(bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_,1)
if tonumber(database:get(bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)) >= 3 then
database:del(bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)
database:del(bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,' ◐اوبس لقد خسرت في اللعبه \n ◐حظآ اوفر في المره القادمه \n ◐كان الرقم الذي تم تخمينه { '..GETNUM..' }')
else
send(msg.chat_id_, msg.id_,' ◐اوبس تخمينك غلط \n ◐ارسل رقم تخمنه مره اخرى ')
end
end
end
end
if text == 'خمن' or text == 'التخمين' then   
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
Num = math.random(1,20)
database:set(bot_id.."GAMES:NUM"..msg.chat_id_,Num) 
send(msg.chat_id_, msg.id_,'\n ◐اهلا بك عزيزي في لعبة التخمين :\nٴ━━━━━━━━━━\n'..' ◐ملاحظه لديك { 3 } محاولات فقط فكر قبل ارسال تخمينك \n\n'..' ◐سيتم تخمين عدد ما بين ال {1 و 20} اذا تعتقد انك تستطيع الفوز جرب واللعب الان ؟ ')
database:setex(bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
end

if database:get(bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 6 then
send(msg.chat_id_, msg.id_," ◐عذرا لا يوجد سواء { 6 } اختيارات فقط ارسل اختيارك مره اخرى\n")
return false  end 
local GETNUM = database:get(bot_id.."Games:Bat"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
database:del(bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,' ◐مبروك فزت وطلعت المحيبس بل ايد رقم { '..NUM..' }\n ◐لقد حصلت على { 3 }من نقاط يمكنك استبدالهن برسائل ')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,3)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
database:del(bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,' ◐للاسف لقد خسرت \n ◐المحيبس بل ايد رقم { '..GETNUM..' }\n ◐حاول مره اخرى للعثور على المحيبس')
end
end
end

if text == 'محيبس' or text == 'البات' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then   
Num = math.random(1,6)
database:set(bot_id.."Games:Bat"..msg.chat_id_,Num) 
TEST = [[
*➀       ➁     ➂      ➃      ➄     ➅
↓      ↓     ↓      ↓     ↓     ↓   
👊 ‹◐› 👊 ‹◐› 👊 ‹◐› 👊 ‹◐› 👊 ‹◐› 👊
 ◐اختر لأستخراج المحيبس الايد التي تحمل المحيبس 
 ◐الفائز يحصل على { 3 } من النقاط *
]]
send(msg.chat_id_, msg.id_,TEST)
database:setex(bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
end

------------------------------------------------------------------------
if text == 'المختلف' or text == 'مختلف' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
mktlf = {'😸','☠','🐼','🐇','??','🌚','⭐️','✨','⛈','🌥','⛄️','👨‍🔬','👨‍💻','👨‍🔧','👩‍🍳','🧚‍♀','??‍♂','??‍♂','🙍‍♂','🧖‍♂','👬','👨‍👨‍👧','🕒','🕤','⌛️','📅',};
name = mktlf[math.random(#mktlf)]
database:del(bot_id..'Set:Moktlf:Bot'..msg.chat_id_)
database:set(bot_id..':Set:Moktlf'..msg.chat_id_,name)
name = string.gsub(name,'😸','😹😹😹😹😹😹😹😹😸😹😹😹😹')
name = string.gsub(name,'☠','💀💀💀💀💀💀💀☠💀💀💀💀💀')
name = string.gsub(name,'🐼','👻👻👻🐼👻👻👻👻👻👻👻')
name = string.gsub(name,'🐇','🕊🕊🕊🕊🕊🐇🕊🕊🕊🕊')
name = string.gsub(name,'🌑','🌚🌚🌚🌚🌚🌑🌚🌚🌚')
name = string.gsub(name,'🌚','🌑🌑🌑🌑🌑🌚🌑🌑🌑')
name = string.gsub(name,'⭐️','🌟🌟🌟🌟🌟🌟🌟🌟⭐️🌟🌟🌟')
name = string.gsub(name,'✨','💫💫💫💫💫✨💫💫💫💫')
name = string.gsub(name,'⛈','🌨🌨🌨🌨🌨⛈🌨🌨🌨🌨')
name = string.gsub(name,'🌥','⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️')
name = string.gsub(name,'⛄️','☃☃☃☃☃☃⛄️☃☃☃☃')
name = string.gsub(name,'👨‍🔬','👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬👩‍🔬')
name = string.gsub(name,'👨‍💻','👩‍💻👩‍💻👩‍‍💻👩‍‍??👩‍💻👨‍💻👩‍💻👩‍💻👩‍💻')
name = string.gsub(name,'👨‍🔧','👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍🔧')
name = string.gsub(name,'👩‍🍳','👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳??‍🍳')
name = string.gsub(name,'🧚‍♀','🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂')
name = string.gsub(name,'🧜‍♂','🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧚‍♂🧜‍♀🧜‍♀🧜‍♀')
name = string.gsub(name,'🧝‍♂','🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀')
name = string.gsub(name,'🙍‍♂️','🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙍‍♂️🙎‍♂️🙎‍♂️🙎‍♂️')
name = string.gsub(name,'🧖‍♂️','🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️')
name = string.gsub(name,'👬','👭👭👭👭👭👬👭👭👭')
name = string.gsub(name,'👨‍👨‍👧','👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦')
name = string.gsub(name,'🕒','🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒')
name = string.gsub(name,'🕤','🕥🕥🕥🕥??🕤🕥🕥🕥')
name = string.gsub(name,'⌛️','⏳⏳⏳⏳⏳⏳⌛️⏳⏳')
name = string.gsub(name,'📅','📆📆📆📆📆📆📅📆📆')
send(msg.chat_id_, msg.id_,' ◐اسرع واحد يدز الاختلاف » {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..':Set:Moktlf'..msg.chat_id_) or '')..'' then 
if not database:get(bot_id..'Set:Moktlf:Bot'..msg.chat_id_) then 
database:del(bot_id..':Set:Moktlf'..msg.chat_id_)
send(msg.chat_id_, msg.id_,' ◐الف مبروك لقد فزت \n ◐للعب مره اخره ارسل »{ المختلف }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Moktlf:Bot'..msg.chat_id_,true)
end
------------------------------------------------------------------------
if text == 'الرياضيات' or text == 'رياضيات' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
Amer = {'22','30','33','60','90','2','5','36','16','88','50','10','19',};
name = Amer[math.random(#Amer)]
database:del(bot_id..'Set:Ryadeat:Bot'..msg.chat_id_)
database:set(bot_id..':Set:Ryadeat'..msg.chat_id_,name)
name = string.gsub(name,'22','2+20=')
name = string.gsub(name,'30','10×3=')
name = string.gsub(name,'33','30+3=')
name = string.gsub(name,'60','33+27=')
name = string.gsub(name,'90','9×9+9=')
name = string.gsub(name,'2','2×1=')
name = string.gsub(name,'5','5×1=')
name = string.gsub(name,'36','6×6=')
name = string.gsub(name,'16','2×8=')
name = string.gsub(name,'88','8+80=')
name = string.gsub(name,'50','30+20=')
name = string.gsub(name,'10','2+8=')
name = string.gsub(name,'19','6+13=')
send(msg.chat_id_, msg.id_,' ◐حل المسأله الرياضيه  » {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..':Set:Ryadeat'..msg.chat_id_) or '')..'' then 
if not database:get(bot_id..'Set:Ryadeat:Bot'..msg.chat_id_) then 
database:del(bot_id..':Set:Ryadeat'..msg.chat_id_)
send(msg.chat_id_, msg.id_,' ◐الف مبروك لقد فزت \n ◐للعب مره اخره ارسل »{ رياضيات }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Ryadeat:Bot'..msg.chat_id_,true)
end
------------------------------------------------------------------------
if text == 'انكليزي' or text == 'الانكليزي' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
Amer = {'معلومات','قنوات','مجموعات','كتاب','تفاحه','مختلف','سدني','فلوس','اعلم','ذئب','تمساح','ذكي',};
name = Amer[math.random(#Amer)]
database:del(bot_id..'Set:English:Bot'..msg.chat_id_)
database:set(bot_id..':Set:English'..msg.chat_id_,name)
name = string.gsub(name,'ذئب','Wolf')
name = string.gsub(name,'معلومات','Information')
name = string.gsub(name,'قنوات','Channels')
name = string.gsub(name,'مجموعات','Groups')
name = string.gsub(name,'كتاب','Book')
name = string.gsub(name,'تفاحه','Apple')
name = string.gsub(name,'سدني','Sydney')
name = string.gsub(name,'فلوس','money')
name = string.gsub(name,'اعلم','I know')
name = string.gsub(name,'تمساح','crocodile')
name = string.gsub(name,'مختلف','Different')
name = string.gsub(name,'ذكي','Intelligent')
send(msg.chat_id_, msg.id_,' ◐ترجم الكلمات الاتيه  » {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..':Set:English'..msg.chat_id_) or '')..'' then 
if not database:get(bot_id..'Set:English:Bot'..msg.chat_id_) then 
database:del(bot_id..':Set:English'..msg.chat_id_)
send(msg.chat_id_, msg.id_,' ◐الف مبروك لقد فزت \n ◐للعب مره اخره ارسل »{ `انكليزي` }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:English:Bot'..msg.chat_id_,true)
end
------------------------------------------------------------------------
if text == 'امثله' or text == 'الامثله' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
mthal = {'جوز','ضراطه','الحبل','الحافي','شقره','بيدك','سلايه','النخله','الخيل','حداد','المبلل','يركص','قرد','العنب','العمه','الخبز','بالحصاد','شهر','شكه','يكحله',};
name = mthal[math.random(#mthal)]
database:set(bot_id..'Set:Amth'..msg.chat_id_,name)
database:del(bot_id..'Set:Amth:Bot'..msg.chat_id_)
name = string.gsub(name,'جوز','ينطي____للماعده سنون')
name = string.gsub(name,'ضراطه','الي يسوق المطي يتحمل___')
name = string.gsub(name,'بيدك','اكل___محد يفيدك')
name = string.gsub(name,'الحافي','تجدي من___نعال')
name = string.gsub(name,'شقره','مع الخيل يا___')
name = string.gsub(name,'النخله','الطول طول___والعقل عقل الصخلة')
name = string.gsub(name,'سلايه','بالوجه امراية وبالظهر___')
name = string.gsub(name,'الخيل','من قلة___شدو على الچلاب سروج')
name = string.gsub(name,'حداد','موكل من صخم وجهه كال آني___')
name = string.gsub(name,'المبلل','___ما يخاف من المطر')
name = string.gsub(name,'الحبل','اللي تلدغة الحية يخاف من جرة___')
name = string.gsub(name,'يركص','المايعرف___يكول الكاع عوجه')
name = string.gsub(name,'العنب','المايلوح___يكول حامض')
name = string.gsub(name,'العمه','___إذا حبت الچنة ابليس يدخل الجنة')
name = string.gsub(name,'الخبز','انطي___للخباز حتى لو ياكل نصه')
name = string.gsub(name,'باحصاد','اسمة___ومنجله مكسور')
name = string.gsub(name,'شهر','امشي__ولا تعبر نهر')
name = string.gsub(name,'شكه','يامن تعب يامن__يا من على الحاضر لكة')
name = string.gsub(name,'القرد','__بعين امه غزال')
name = string.gsub(name,'يكحله','اجه___عماها')
send(msg.chat_id_, msg.id_,' ◐اسرع واحد يكمل المثل » {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..'Set:Amth'..msg.chat_id_) or '')..'' then 
if not database:get(bot_id..'Set:Amth:Bot'..msg.chat_id_) then 
database:del(bot_id..'Set:Amth'..msg.chat_id_)
send(msg.chat_id_, msg.id_,' ◐الف مبروك لقد فزت \n ◐للعب مره اخره ارسل »{ امثله }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Amth:Bot'..msg.chat_id_,true)
end
if text == 'تعطيل الالعاب' and Manager(msg) then   
if database:get(bot_id..'Lock:Games'..msg.chat_id_)  then
database:del(bot_id..'Lock:Games'..msg.chat_id_) 
Text = '\n◐تم تعطيل الالعاب' 
else
Text = '\n◐بالتاكيد تم تعطيل الالعاب'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الالعاب' and Manager(msg) then  
if not database:get(bot_id..'Lock:Games'..msg.chat_id_)  then
database:set(bot_id..'Lock:Games'..msg.chat_id_,true) 
Text = '\n◐تم تفعيل الالعاب' 
else
Text = '\n◐بالتاكيد تم تفعيل الالعاب'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'الالعاب' and database:get(bot_id..'Lock:Games'..msg.chat_id_) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'◐ عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n◐قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
Text_Games = [[
*◐اوامر الالعاب كتالي*
   **◐○◐○◐○◐○◐ٴ*ٴ* 
*◐تفعيل الالعاب ◐ لتفعيل العبه °*
*◐تعطيل الالعاب ◐ لتعطيل العبه*
   **◐○◐○◐○◐○◐ٴ*ٴ* 
*◐الالعاب الخاصه بسورس*
   **◐○◐○◐○◐○◐ٴ*ٴ* 
*◐لعبه البات ↫ لعبة المحيبس*
*◐لعبه التخمين ↫ لعبة البحث*
*◐لعبه الاسرع ↫ لعبة اسرع شخص*
*◐لعبه السمايلات ↫ لعبة المطابقه *
*◐لعبه المختلف ↫ لعبة الذكاء*
*◐لعبه الرياضيات ↫ لعبة الارقام*
*◐لعبه الانكليزي ↫ لعبة ترجمه*
*◐لعبه الامثله ↫ لعبة تصحيح *
*◐لعبه العكس ↫ لعبة عكس الكلمات*
*◐لعبه الحزوره ↫لعبة التفكير *
*◐لعبه المعاني ↫ العبه الشهيره *
   **◐○◐○◐○◐○◐ٴ*ٴ* 
𝘊𝘩 - [𝖋𝖔𝖝  𓅛](t.me/IIIIlI8)◐
]]
send(msg.chat_id_, msg.id_,Text_Games) 
end
if text == 'تفعيل الردود' and Manager(msg) then  
send(msg.chat_id_, msg.id_, '◐ تم تفعيل الردود')
database:del(bot_id..'lock:add'..msg.chat_id_)
end
if text == 'تعطيل الردود' and Manager(msg) then  
send(msg.chat_id_, msg.id_, '◐ تم تعطيل الردود')
database:set(bot_id..'lock:add'..msg.chat_id_, true)
end
if text == "السلام عليكم" or text == "سلام عليكم" or text == "سلامن عليكم" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"و؏ـليڪم الـسلامہ💓 ","و؏ـليڪم اغاتيہ💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "شلونك" or text == "شونك" or text == "شلونج" or text == "شونج" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"تمام وانتہ. 💗🥳","بخيࢪ وانتہ. يࢪﯡפــيہ 😭💗"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "بوسيني" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"افسهہ مࢪبوطهہ بطليہ🥳😹","؏ـيبہ🥳😂","ماما متقبࢦ💗🥳😭" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "هلو" or text == "هلاو" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"💗🥳ۿلاﯡات يحلـﯡ "}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "صباح الخير" or text == "صباحو" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"صبـﺎُحح ﺎُݪعسل 🥳💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "شنو هذا بوت" or text == "هذا بوت" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"خوشہ مـ؏ـلومهہ 🥵✌🏻","آييہ උـبي بوتہ✌🏻🥳" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "باي" or text == "رايح" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"باياتہ උـبيہ💞 ","حنشتاقلڪ ؏ـمࢪي 💓🥺","ويـטּ ࢪايـح خلينهہ متونسيـטּ💘☹️","بـ؏ـد وڪتہ ويـטּ 😕♥️","ࢦطوࢦ نشتاقلڪ 💞🍫","باياتہ උـبيبيہ 🖤","ويـטּ ࢪايـح تزحفہ 😹✌🏻" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end


if text == "جاو" or text == "ججاو" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"جــاواتہ උـياتيہ 🖤","حنشتاقلڪ ؏ـمࢪي 🥺💓"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "نورت" or text == "منور" or text == "منوره" or text == "نورتي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"بنوࢪڪ يࢪﯡפــيہ 😭💗🥳","نوࢪ ؏ـيونڪ 🥳😹💗" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "بوسني" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"مابوس استحي 😹🥳💗","🥺😭😹💗محح"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "رفع مرتي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"◐اهــلا عزيزي\n◐تم رفع العضو مرتك بنجاح★\nالآن يمكنكم أخذ راحتكم★"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "تنزيل مرتي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"◐اهــلا عزيزي\n◐تم تنزيل الجكمه مرتك بنجاح★\nالآن انتم مفترقان★"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "رفع زوجي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"◐اهــلا عزيزي\n◐تم رفع العضو زوجج بنجاح★\nالآن يمكنكم أخذ راحتكم★"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "تنزيل زوجي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"◐اهــلا عزيزي\n◐تم تنزيل الاجڪم زوجج بنجاح★\nالآن انتم مفترقان★"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "😌" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ده واثق منـہ. حالو 😕😹💞" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "خالتك" or text == "خالتج" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"شبيهہ الشڪࢪهہ ازوجها 😹🥳","شࢪايد مِہטּ خالتهہ غيࢪ للبوسہ 😹💔","خالتهہ تفلشہ بغمزهہ تسويہ بيڪ جلطهہ 🥵😹🥺" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "تف" or text == "تفف" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"؏ـليڪ 🙂🤙🏻","وصخہ شتࢪجهہ منڪ 🥵✌🏻  ","تفہ بنصہ وجهڪ 🥵😹" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "😂" or text == "😹😹😹" or text == "😹" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"شهضحڪهہ الحلوهہ بࢪبڪ امڪ ؏ـشنو متوحمه 💗😩"," ڪياَتۿ الضحكه 😫😹💞","دومہ උـياتيہ ♥️" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "😒" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"اشبيڪ ڪالبہ خلقتڪ 🤞🏻😕","شبيڪ ؏ـمو🤞🏻😕"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "🌝" or text == "🌝🌝" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"طالـ؏ صاڪ شنيہ💓🌝 ","منوࢪ උـياتيہ♥️🌝"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "تحبني" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"احبڪ حب ؏ـبادهہ مِہטּ البصࢪا للڪࢪادهہ 🤤💓"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "جوعان" or text == "جوعانه" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"تࢪيد اسويلڪ اڪل مثلا🙂😹","آييہ ࢪوح اڪل انيشـ؏ـليهہ 🥵😹","تـ؏ـاࢦ اڪلنيہ 😭😹" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "ههه" or text == "هههه" or text == "ههههههه" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ڪياَتۿ الضحكه 😫😹💞" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "اكلك" or text == "اكلج" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ڪوࢦ උـياتيہ 🌚","ڪوليہ ماڪول لحد🌝" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "شبيك" or text == "شبيج" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ڪـلـشييہ ما بيـهہ💘","ما بـيهہ شـٰيہ🤷💘‌‎","بــيهہ اَنــتهہ🤤💘" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "فديتك" or text == "فديتج" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"احح آييہ  فديتني 😫😹💞" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "ميتين" or text == "وينكم" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"طﺎُمسين تـ؏ فدشوي 🙂😹💞" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "احبك" or text == "حبك" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"اموتبيڪ شنيہ 🥳🖤" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "انجب" or text == "نجب" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"صـاࢪ උـبيہ🙂🤞🏻","انجبہ انتہ لاتندفࢪ😏🤙🏻","انجـبہ انـتهہ🔪" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "كفو" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ڪفو منـہ. شاربك 🥳😹💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "هاي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"هاياتہ يبـ؏ـد حيليہ💗"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "حاره" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ايـي وﺎﻟلهۂَ ݪمنشئ ميشغل مبرده 👍💔"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "مسا الخير" or text== "مساء الخير" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"م ـساء ﺎُݪوࢪد 🥳💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "شسمج" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"اسمها سعديه 🥳😹💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "شسمك" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"اسمهہ جبار 😭😹💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "احبج" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"جذاب زاحف ؏ـلى نص الڪـࢪۅبہ ??😹💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "شوف" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"يلاا مو نحولت 😒😹💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "نايمين" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"شتࢪيد منهم خليهم نايمين 🙂😹💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "كافي لغوه" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"سد حلكهم واحد واحد 🙂😹💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "غلس" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"اهمسݪيہ 🥺😹💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "اوف" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"؏َـيب وليدي 🙁😹💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "انت منو" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"انيـہ حاميكم 😒😹💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "منو يمسح رسايلي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"شوف ﺎُݪاحداث ☹️😹💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "وين" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ﺎُࢪﯡٰح اطمس ☺️😹💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "المدرسه" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"خࢪب ام ﺎُݪمدرسه 🙂👍💔💔💔"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "شنو رئيك بهذا" or text == "شنو رئيك بهاي" then
local texting = {"܁◐كلش حباب وهاي 🦄💞","܁◐الكياته تبعه تقرا 1000 🥺💞","܁◐اطلق شخص شحبه 🥺💞","زغبا 😹💞.","܁◐يوتيوبر رب المعيدي 😹💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
return false
end
if text == "هينه" or text == "رزله" then
local texting = {"مااهين حيوانات اني 😹😭💘."," ماا وخر ماسوي شي 😭💘 ."}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
return false
end
if text == "مصه" or text == "بوسه" then
local texting = {"ما ما ما اخجل شني 😭??💞","ماا وخر مابوسك 😭💞💞"," ما ما ما اخجل شني 😭😭💞"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
return false
end

if text == 'رابط الحذف' or text == 'رابط حذف' then
t =[[
رابط الحذف في جميع مواقع التواصل ◐
فكر قبل لا تتسرع وتروح
ٴ◐○◐○Fox◐○◐○◐ٴ
 ◐ رابط حذف  [Telegram](https://my.telegram.org/auth?to=delete) ܁
 ◐ رابط حذف [instagram](https://www.instagram.com/accounts/login/?next=/accounts/remove/request/permanent/) ܁
 ◐ رابط حذف [Facebook](https://www.facebook.com/help/deleteaccount) ܁
 ◐ رابط حذف [Snspchat](https://accounts.snapchat.com/accounts/login?continue=https%3A%2F%2Faccounts.snapchat.com%2Faccounts%2Fdeleteaccount) ܁
]]
send(msg.chat_id_, msg.id_,t) 
return false
end
if text and text:match('^الحساب (%d+)$') then
local id = text:match('^الحساب (%d+)$')
local text = 'اضغط لمشاهده الحساب'
tdcli_function ({ID="SendMessage", chat_id_=msg.chat_id_, reply_to_message_id_=msg.id_, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=19, user_id_=id}}}}, dl_cb, nil)
end
local function oChat(chat_id,cb)
tdcli_function ({
ID = "OpenChat",
chat_id_ = chat_id
}, cb, nil)
end
if text == "صلاحياته" and tonumber(msg.reply_to_message_id_) > 0 then    
if tonumber(msg.reply_to_message_id_) ~= 0 then 
function prom_reply(extra, result, success) 
Get_Info(msg,msg.chat_id_,result.sender_user_id_)
end  
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},prom_reply, nil)
end
end
------------------------------------------------------------------------
if text == "صلاحياتي" then 
if tonumber(msg.reply_to_message_id_) == 0 then 
Get_Info(msg,msg.chat_id_,msg.sender_user_id_)
end  
end
------------------------------------------------------------------------
if text and text:match('^صلاحياته @(.*)') then   
local username = text:match('صلاحياته @(.*)')   
if tonumber(msg.reply_to_message_id_) == 0 then 
function prom_username(extra, result, success) 
if (result and result.code_ == 400 or result and result.message_ == "USERNAME_NOT_OCCUPIED") then
SendText(msg.chat_id_,msg.id_,"- المعرف غير صحيح \n*")   
return false  end   

Get_Info(msg,msg.chat_id_,result.id_)
end  
tdcli_function ({ID = "SearchPublicChat",username_ = username},prom_username,nil) 
end 
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end -- Chat_Type = 'GroupBot' 
end -- end msg 
--------------------------------------------------------------------------------------------------------------
function tdcli_update_callback(data)  -- clback
if data.ID == "UpdateChannel" then 
if data.channel_.status_.ID == "ChatMemberStatusKicked" then 
database:srem(bot_id..'Chek:Groups','-100'..data.channel_.id_)  
end
end
if data.ID == "UpdateNewCallbackQuery" then
local Chat_id = data.chat_id_
local Msg_id = data.message_id_
local msg_idd = Msg_id/2097152/0.5
local Text = data.payload_.data_
if Text == '/help1' then
if not Mod(data) then
local notText = 'الامر لا يخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
اﯡامࢪ الحمايهہ ڪلتالي 
◐○◐○◐○◐○◐ٴ
◐ قفࢦ + فتح › اࢦامࢪ
◐ › { باࢦتقيد › باࢦطࢪد › باࢦڪتم }
◐○◐○◐○◐○◐ٴ
◐ اࢦࢪﯡابط
◐ اࢦمعࢪف
◐ اࢦتاڪ
◐ اࢦشارحهہ 
◐ اࢦتعديࢦ
◐ اࢦتثبيت
◐ اࢦمتحࢪڪهہ 
◐ اࢦمࢦفات
◐ اࢦصـﯡࢪ
◐ اࢦتفࢦيش
◐ قفࢦ الاباحي
◐○◐○◐○◐○◐ٴ
◐ اࢦمارڪداﯡטּ
◐ اࢦبوتات
◐ التڪࢪاࢪ
◐ الڪࢦلايش
◐ اࢦسيࢦفي 
◐ اࢦمࢦصقات 
◐ اࢦفيديـﯡ 
◐ اࢦانلايـטּ
◐ اࢦدردشهہ 
◐○◐○◐○◐○◐ٴ
◐ اࢦتوجيهہ 
◐ اࢦاغاني 
◐ اࢦصوت 
◐ اࢦجهات 
◐ اࢦاشعاࢪات 
◐○◐○◐○◐○◐ٴ
𝘊𝘩 - ➫ .[- 𝖋𝖔𝖝  𓅛◐.](t.me/IIIIlI8)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⁦❶', callback_data="/help1"},{text = ' ❷', callback_data="/help2"},{text = '⁦❸', callback_data="/help3"},
},
{
{text = '❹', callback_data="/help4"},{text = '❺', callback_data="/help5"},{text = ' ❻', callback_data="/help6"},
},
{
{text = '❼', callback_data="/help7"},{text = '⁦❽', callback_data="/help8"},
},
{
{text = 'رجوع 🧸', callback_data="/help"},
},
{
{text = ' 『 𝗠𝗢𝗥𝗣𝗛𝗜𝗡𝗘 𓏶』', url="t.me/ii_t3"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help2' then
if not Mod(data) then
local notText = 'الامر لا يخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◐ اهلا بڪ ؏ـزيزي
◐○◐○◐○◐○◐ٴ
◐ تفعيࢦ ~ تعطيࢦ + امࢪ
◐○◐○◐○◐○◐ٴ
◐ اطࢪدني
◐ صيح
◐ ضافني
◐ اࢦࢪابط
◐ اࢦحظࢪ
◐ اࢦافࢦلام
◐ اࢦيوتيوب
◐ اࢦاضافات
◐ اࢦࢪفع
◐ اࢦايدي
◐ اࢦاࢦعاب
◐ ࢪدود اࢦمطوࢪ
◐ اࢦتࢪحيب
◐ ࢪدود اࢦمديࢪ
◐ اࢦࢪدود
◐ ࢪدود اࢦبوت
◐ اﯡامࢪ اࢦتحشيش
◐ صوࢪتي
◐ زخࢪفهہ 
◐ حساب اࢦعمࢪ
◐ اࢦابࢪاج
 ◐ اࢦحمايۿ
◐○◐○◐○◐○◐ٴ
𝘊𝘩 - ➫ .[- 𝖋𝖔𝖝  𓅛◐.](t.me/IIIIlI8)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⁦❶', callback_data="/help1"},{text = ' ❷', callback_data="/help2"},{text = '⁦❸', callback_data="/help3"},
},
{
{text = '❹', callback_data="/help4"},{text = '❺', callback_data="/help5"},{text = ' ❻', callback_data="/help6"},
},
{
{text = '❼', callback_data="/help7"},{text = '⁦❽', callback_data="/help8"},
},
{
{text = 'رجوع 🧸', callback_data="/help"},
},
{
{text = ' 『 𝗠𝗢𝗥𝗣𝗛𝗜𝗡𝗘 𓏶』', url="t.me/ii_t3"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help3' then
if not Mod(data) then
local notText = 'الامر لا يخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◐ اهلا بڪ ؏ـزيزي
◐○◐○◐○◐○◐ٴ
◐ اﯡامࢪ اࢦوضع ~ اضف
◐○◐○◐○◐○◐ٴ
◐ اضف › حذف › ࢪد
◐ اضف › حذف › صࢦلاحيهہ 
◐○◐○◐○◐○◐ٴ
◐ ضع + امࢪ
◐○◐○◐○◐○◐ٴ
◐ آسم
◐ ࢪابط
◐ تࢪحيب
◐ قـﯡانيـטּ
◐ صـﯡࢪۿ
◐ ﯡصف
◐ تڪࢪاࢪ + ؏ـدد
◐○◐○◐○◐○◐ٴ
𝘊𝘩 - ➫ .[- 𝖋𝖔𝖝  𓅛◐.](t.me/IIIIlI8)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⁦❶', callback_data="/help1"},{text = ' ❷', callback_data="/help2"},{text = '⁦❸', callback_data="/help3"},
},
{
{text = '❹', callback_data="/help4"},{text = '❺', callback_data="/help5"},{text = ' ❻', callback_data="/help6"},
},
{
{text = '❼', callback_data="/help7"},{text = '⁦❽', callback_data="/help8"},
},
{
{text = 'رجوع 🧸', callback_data="/help"},
},
{
{text = ' 『 𝗠𝗢𝗥𝗣𝗛𝗜𝗡𝗘 𓏶』', url="t.me/ii_t3"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help4' then
if not Mod(data) then
local notText = 'الامر لا يخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◐ اهلا بڪ ؏ـزيزي
◐ اوامر مسح › الحذف › امر
◐○◐○◐○◐○◐ٴ
◐ مسح + امࢪ
◐○◐○◐○◐○◐ٴ
◐ اࢦايدي
◐ اࢦادمنيهہ 
◐ اࢦمميزيـטּ
◐ ࢪدود اࢦمديࢪ
◐ اࢦمدࢪاء
◐ اࢦمنشئيـטּ 
◐ اࢦاساسيـטּ
◐ قائمهہ اࢦماࢦڪ
◐ اࢦمنظفيـטּ
◐ اࢦبـﯡتات
◐ امسح
◐ صࢦلاحيهہ 
◐ قائمهہ منع اࢦمتحࢪڪات
◐ قائمهہ منع اࢦصـﯡࢪ
◐ قائمهہ منع اࢦمࢦصقات
◐ مسح قائمهہ المنع
◐ اࢦمحذﯡفيـטּ
◐ اࢦاﯡامࢪ اࢦمضافهہ 
◐○◐○◐○◐○◐ٴ
𝘊𝘩 - ➫ .[- 𝖋𝖔𝖝  𓅛◐.](t.me/IIIIlI8)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⁦❶', callback_data="/help1"},{text = ' ❷', callback_data="/help2"},{text = '⁦❸', callback_data="/help3"},
},
{
{text = '❹', callback_data="/help4"},{text = '❺', callback_data="/help5"},{text = ' ❻', callback_data="/help6"},
},
{
{text = '❼', callback_data="/help7"},{text = '⁦❽', callback_data="/help8"},
},
{
{text = 'رجوع 🧸', callback_data="/help"},
},
{
{text = ' 『 𝗠𝗢𝗥𝗣𝗛𝗜𝗡𝗘 𓏶』', url="t.me/ii_t3"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help5' then
if not Mod(data) then
local notText = 'الامر لا يخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◐ اهلا بڪ ؏ـزيزي
◐○◐○◐○◐○◐ٴ
◐ اوامࢪ التنزيࢦ والࢪفع
◐○◐○◐○◐○◐ٴ
◐ مميز
◐ ادمن
◐ مديࢪ
◐ منشئ
◐ منشئ اساسي
◐ ماࢦڪ
◐ منظف
◐ اࢦادمنيهہ 
◐ ادمن باࢦڪروب
◐ ادمن بڪࢦ اࢦصࢦلاحيات
◐ اࢦقيود
◐ تنزيࢦ جميع الࢪتب
◐○◐○◐○◐○◐ٴ
◐ اوامࢪ اࢦتغيࢪ
◐○◐○◐○◐○◐ٴ
◐ تغيࢪ ࢪد اࢦمطوࢪ + اسم
◐ تغيࢪ ࢪد منشئ اࢦاساسي + اسم
◐ تغيࢪ ࢪد اࢦمنشئ + اسم
◐ تغيࢪ ࢪد اࢦمديࢪ + اسم
◐ تغيࢪ ࢪد اࢦادمن + اسم
◐ تغيࢪ ࢪد اࢦمميز + اسم
◐ تغيࢪ ࢪد اࢦعضـﯡ + اسم
◐ تغيࢪ امࢪ اࢦاوامࢪ
◐ تغيࢪ امࢪ م1 ~ الئ م10
◐○◐○◐○◐○◐ٴ
𝘊𝘩 - ➫ .[- 𝖋𝖔𝖝  𓅛◐.](t.me/IIIIlI8)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⁦❶', callback_data="/help1"},{text = ' ❷', callback_data="/help2"},{text = '⁦❸', callback_data="/help3"},
},
{
{text = '❹', callback_data="/help4"},{text = '❺', callback_data="/help5"},{text = ' ❻', callback_data="/help6"},
},
{
{text = '❼', callback_data="/help7"},{text = '⁦❽', callback_data="/help8"},
},
{
{text = 'رجوع 🧸', callback_data="/help"},
},
{
{text = ' 『 𝗠𝗢𝗥𝗣𝗛𝗜𝗡𝗘 𓏶』', url="t.me/ii_t3"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help6' then
if not Mod(data) then
local notText = 'الامر لا يخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◐ اهلا بڪ ؏ـزيزي
◐ اوامࢪ اࢦمجموعه
◐○◐○◐○◐○◐ٴ
◐ اࢦاوامࢪ ڪالتالي
◐○◐○◐○◐○◐ٴ
◐ استعاده اࢦاوامࢪ
◐ صيح › تاڪ › اࢦمميزين : اࢦادمنيه : اࢦمدࢪاء : اࢦمنشئين : اࢦمنشئين اࢦاساسين : منظفين : لࢦماࢦڪ
◐ ڪشف اࢦقيـﯡد 
◐ تعين اࢦايدي
◐ تغيࢪ اࢦايدي
◐ اࢦحساب + ايدي اࢦحساب
◐ تنظيف + اࢦعدد
◐ امسح
◐ تنزيࢦ اࢦڪࢦ
◐ تنزيࢦ جميع اࢦࢪتب
◐ منع + بࢪد
◐ الصوࢪ + متحࢪڪه + مࢦصق 
◐ حظࢪ › ڪتم › تقيد › طࢪد
◐ اࢦمحظـﯡࢪيـטּ › اࢦمڪتـﯡميـטּ › المقيدين
◐ اࢦغاء ڪتم + حظࢪ + تقيد › باࢦࢪد و معࢪف و ايدي
◐ تقيد ~ ڪتم + اࢦࢪقم + ساعه
◐ تقيد ~ ڪتم + اࢦࢪقم + يوم
◐ تقيد ~ ڪتم + اࢦࢪقم + دقيقهہ 
◐ تثبيت ~ الغاء تثبيت
◐ اࢦتࢪحيب
◐ اࢦغاء تثبيت اࢦكل 
◐ ڪشف اࢦبـﯡتات
◐ اࢦصࢦلاحيات
◐ ڪشف › برد › بمعرف › ايدي
◐ تاڪ ࢦࢦكࢦ
◐ تاڪ ࢦࢦمشرفيـטּ
◐ عدد اࢦمنظفيـטּ
◐ اعدادات اࢦمجمـﯡعهہ 
◐ عدد اࢦڪࢪوب
◐ ࢪدود اࢦمديࢪ
◐ اسم بوت + اࢦࢪتبهہ 
◐ اࢦاﯡامࢪ اࢦمضافهہ 
◐ قائمهہ اࢦمنع
◐ نسبهہ الحب 
◐ نسبهہ ࢪجوࢦه
◐○◐○◐○◐○◐ٴ
𝘊𝘩 - ➫ .[- 𝖋𝖔𝖝  𓅛◐.](t.me/IIIIlI8)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⁦❶', callback_data="/help1"},{text = ' ❷', callback_data="/help2"},{text = '⁦❸', callback_data="/help3"},
},
{
{text = '❹', callback_data="/help4"},{text = '❺', callback_data="/help5"},{text = ' ❻', callback_data="/help6"},
},
{
{text = '❼', callback_data="/help7"},{text = '⁦❽', callback_data="/help8"},
},
{
{text = 'رجوع 🧸', callback_data="/help"},
},
{
{text = ' 『 𝗠𝗢𝗥𝗣𝗛𝗜𝗡𝗘 𓏶』', url="t.me/ii_t3"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help7' then
if not Mod(data) then
local notText = 'الامر لا يخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◐ اوامࢪ اࢦتسࢦيه
◐○◐○◐○◐○◐ٴ
◐ ࢪفع + تنزيࢦ › اࢦامࢪ
◐○◐○◐○◐○◐ٴ
◐ ࢪفع + تنزيࢦ › مطي 
◐ تاڪ ࢦࢦمطايه
◐ ࢪفع + تنزيࢦ › صخࢦ
◐ تاڪ ࢦصخوࢦه
◐ ࢪفع + تنزيࢦ › جࢦب
◐ تاڪ ࢦجࢦلاب
◐ ࢪفع + تنزيࢦ › اثوࢦ
◐ تاڪ ࢦثولان
◐ ࢪفع + تنزيࢦ › بڪلبي
◐ تاڪ ࢦلي بڪلبي
◐ ࢪفع + تنزيࢦ › زاحف 
◐ تاڪ ࢦزﯡاحف
◐ ࢪفع + تنزيࢦ › اࢦحات
◐ تاڪ ࢦࢦحات
◐ ࢪفع تنزيࢦ › عࢪوسه
 ◐ تاڪ ࢦࢦعࢪوسات
◐ ࢪفع تنزيࢦ › شيخ
◐ تاڪ ࢦࢦشيوخ
◐ ࢪفع تنزيࢦ › تاج
◐ تاڪ ࢦࢦتوج
◐ ࢪفع + تنزيࢦ › اࢦحاته
◐ تاڪ ࢦࢦحاتات
◐ زﯡاج › طࢦلاق
◐ ۿينه › ࢪزࢦه
◐○◐○◐○◐○◐ٴ
𝘊𝘩 - ➫ .[- 𝖋𝖔𝖝  𓅛◐.](t.me/IIIIlI8)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⁦❶', callback_data="/help1"},{text = ' ❷', callback_data="/help2"},{text = '⁦❸', callback_data="/help3"},
},
{
{text = '❹', callback_data="/help4"},{text = '❺', callback_data="/help5"},{text = ' ❻', callback_data="/help6"},
},
{
{text = '❼', callback_data="/help7"},{text = '⁦❽', callback_data="/help8"},
},
{
{text = 'رجوع 🧸', callback_data="/help"},
},
{
{text = ' 『 𝗠𝗢𝗥𝗣𝗛𝗜𝗡𝗘 𓏶』', url="t.me/ii_t3"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help8' then
if not Sudo(data) then
local notText = 'الامر لا يخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◐ اهلا بڪ ؏ـزيزي
◐○○○○○○○ٴ◐
◐اوامࢪ المطوࢪين
◐○◐○◐○◐○◐ٴ
◐ تفعيࢦ › تعطيࢦ 
◐ اࢦمجموعات › اࢦمشترڪين › اࢦاحصائيات
◐ ࢪفع › تنزيࢦ منشئ اساسي
◐ مسح اࢦاساسين › اࢦمنشئين اࢦاساسين
◐ مسح اࢦمنشئين › اࢦمنشئين
◐ ࢪفع › تنزيࢦ مالڪ
◐ مسح قائمه اࢦماࢦڪ 
◐ ࢪفع › تنزيࢦ منظف
◐ مسح المنظفين 
◐ اسم › ايدي + بوت غادࢪ
◐ اذاعه 
◐ ࢪدود اࢦمطوࢪ 
◐○◐○◐○◐○◐ٴ
𝘊𝘩 - ➫ .[- 𝖋𝖔𝖝  𓅛◐.](t.me/IIIIlI8)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⁦❶', callback_data="/help1"},{text = ' ❷', callback_data="/help2"},{text = '⁦❸', callback_data="/help3"},
},
{
{text = '❹', callback_data="/help4"},{text = '❺', callback_data="/help5"},{text = ' ❻', callback_data="/help6"},
},
{
{text = '❼', callback_data="/help7"},{text = '⁦❽', callback_data="/help8"},
},
{
{text = 'رجوع 🧸', callback_data="/help"},
},
{
{text = ' 『 𝗠𝗢𝗥𝗣𝗛𝗜𝗡𝗘 𓏶』', url="t.me/ii_t3"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help9' then
if not Sudo(data) then
local notText = 'الامر لا يخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◐ اهلا بڪ ؏ـزيزي
◐○◐○◐○◐○◐ٴ
◐ اوامࢪ اࢦمطوࢪ الاساسي↓
◐○◐○◐○◐○◐ٴ
◐ تفعيࢦ
◐ تعطيࢦ
◐ مسح اࢦاساسين
◐ اࢦمنشئين اࢦاساسين
◐ ࢪفع › تنزيࢦ منشئ اساسي
◐ مسح اࢦمطوࢪين
◐ ࢪفع › تنزيࢦ مالڪ 
◐ اࢦمطوࢪين
◐ رفع › تنزيل مطور
◐○◐○◐○◐○◐ٴ
◐ اسم اࢦبوت + غادࢪ
◐ غادࢪ
◐ اسم بوت + اࢦࢪتبه
◐ تحديث السوࢪس
◐ حظࢪ عام
◐ ڪتم عام
◐ اࢦغاء اࢦعام
◐ قائمه اࢦعام
◐ مسح قائمه اࢦعام
◐ جࢦب نسخه اࢦاحتياطيه
◐ ࢪفع نسخه اࢦاحتياطيه
◐○◐○◐○◐○◐ٴ
◐ اذاعه خاص
◐ اذاعه
◐ اذاعه باࢦتوجيه
◐ اذاعه باࢦتوجيه خاص
◐ اذاعه باࢦتثبيت
◐○◐○◐○◐○◐ٴ
◐ جࢦب نسخه اࢦبوت
◐ ࢪفع نسخه اࢦبوت
◐ ضع عدد اࢦاعضاء + اࢦعدد
◐ ضع كࢦيشه اࢦمطوࢪ
◐ تفعيࢦ › تعطيࢦ اࢦاذاعه
◐ تفعيࢦ › تعطيࢦ اࢦبوت اࢦخدمي
◐ تفعيࢦ › تعطيࢦ اࢦتواصࢦ
◐ تغيࢪ اسم اࢦبوت
◐ اضف › حذف ࢪد ࢦࢦڪࢦ
◐ ࢪدود اࢦمطوࢪ
◐ مسح ࢪدود اࢦمطوࢪ
◐○◐○◐○◐○◐ٴ
◐ اࢦاشتراڪ اࢦاجباࢪي
◐ تعطيࢦ الاشتࢪاڪ اࢦاجباࢪي
◐ تفعيࢦ اࢦاشتࢪاڪ اࢦاجباࢪي
◐ حذف ࢪساࢦه اࢦاشتࢪاڪ
◐ تغيࢪ ࢪساࢦه اࢦاشتࢪاڪ
◐ تغيࢪ اࢦاشتࢪاڪ
◐○◐○◐○◐○◐ٴ
◐ اࢦاحصائيات
◐ اࢦمشترڪين
◐ اࢦمجموعات 
◐ تفعيࢦ › تعطيࢦ اࢦمغادره
◐ تنظيف اࢦمشتࢪڪين
◐ تنظيف اࢦڪࢪﯡبات
 ◐○◐○◐○◐○◐ٴ
𝘊𝘩 - ➫ .[- 𝖋𝖔𝖝  𓅛◐.](t.me/IIIIlI8)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⁦❶', callback_data="/help1"},{text = ' ❷', callback_data="/help2"},{text = '⁦❸', callback_data="/help3"},
},
{
{text = '❹', callback_data="/help4"},{text = '❺', callback_data="/help5"},{text = ' ❻', callback_data="/help6"},
},
{
{text = '❼', callback_data="/help7"},{text = '⁦❽', callback_data="/help8"},
},
{
{text = 'رجوع 🧸', callback_data="/help"},
},
{
{text = ' 『 𝗠𝗢𝗥𝗣𝗛𝗜𝗡𝗘 𓏶』', url="t.me/ii_t3"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help10' then
local help_text = database:get(bot_id..'help10_text')
local Teext =[[
◐ اهلا بڪ ؏ـزيزي
◐ اوامࢪ اࢦاعضاء كتاࢦي↓
◐○◐○◐○◐○◐ٴ
◐ عࢪض معࢦوماتڪ ↑↓
◐○◐○◐○◐○◐ٴ
◐ ايديي › اسمي 
◐ رسايلي › مسح رسايلي 
◐ رتبتي › سحكاتي 
◐ مسح سحڪاتي › المنشئ 
◐○◐○◐○◐○◐ٴ
◐ اوآمࢪ اࢦمجموعه ↑↓
◐○◐○◐○◐○◐ٴ
◐ اࢦࢪابط › اࢦقوانين › اࢦترحيب
◐ ايدي › اطࢪدني 
◐ اسمي › اࢦمطوࢪ
◐ ڪشف › باࢦࢪد باࢦمعࢪف
◐○◐○◐○◐○◐ٴ
◐ اسم اࢦبوت + اࢦامر ↑↓
◐○◐○◐○◐○◐ٴ
◐ بوسه بالرد 
◐ مصه بالرد
◐ رزله بالرد 
◐○◐○◐○◐○◐ٴ
𝘊𝘩 - ➫ .[- 𝖋𝖔𝖝  𓅛◐.](t.me/IIIIlI8)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⁦❶', callback_data="/help1"},{text = ' ❷', callback_data="/help2"},{text = '⁦❸', callback_data="/help3"},
},
{
{text = '❹', callback_data="/help4"},{text = '❺', callback_data="/help5"},{text = ' ❻', callback_data="/help6"},
},
{
{text = '❼', callback_data="/help7"},{text = '⁦❽', callback_data="/help8"},
},
{
{text = 'رجوع 🧸', callback_data="/help"},
},
{
{text = ' 『 𝗠𝗢𝗥𝗣𝗛𝗜𝗡𝗘 𓏶』', url="t.me/ii_t3"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help' then
if not Mod(data) then
local notText = 'الامر لا يخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
ʜɪ ғᴏx
◐اۿلا ؏ـزيزي الاوامࢪ ڪلتالي◐
  ٴ◐○◐○◐○◐○◐
◐م𝟭 ➭- اوامࢪ الحمايهہ
◐م𝟮 ➭- اوامࢪ اࢦتعطيࢦ ~ اࢦتفعيࢦ
◐م𝟯 ➭- اوامࢪ ضع ~ اضفہ
◐م𝟰 ➭- اوامࢪ مسح ~ حذفہ
◐م𝟱 ➭- اوامࢪ تنزيࢦ ~ ࢪفع ~ اࢦتغيࢪ
◐م𝟲 ➭- اوامࢪ اࢦڪروبہ
◐م𝟳 ➭- اوامࢪ اࢦتسلية
◐م𝟴 ➭- اوامࢪ مطوࢪ اࢦبوتہ
  ٴ◐○◐○◐○◐○◐
𝘊𝘩 - ➫ .[- 𝖋𝖔𝖝  𓅛◐.](t.me/IIIIlI8)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⁦❶', callback_data="/help1"},{text = ' ❷', callback_data="/help2"},{text = '⁦❸', callback_data="/help3"},
},
{
{text = '❹', callback_data="/help4"},{text = '❺', callback_data="/help5"},{text = ' ❻', callback_data="/help6"},
},
{
{text = '❼', callback_data="/help7"},{text = '⁦❽', callback_data="/help8"},
},
{
{text = '•اغلاق', callback_data="/sad"},
},
{
{text = ' 『 𝗠𝗢𝗥𝗣𝗛𝗜𝗡𝗘 𓏶』', url="t.me/ii_t3"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/sad' then
if not Mod(data) then
local notText = 'الامر لا يخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
تم اغلاق الصفحه 
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = ' 『 𝗠𝗢𝗥𝗣𝗛𝗜𝗡𝗘 𓏶』', url="t.me/ii_t3"},
},
{
{text = 'قناه السورس', url="t.me/IIIIlI8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if data.ID == "UpdateNewMessage" then  -- new msg
msg = data.message_
text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if text and not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:del(bot_id..'Spam:Texting'..msg.sender_user_id_) 
end
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
if NewCmmd then
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
database:del(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:srem(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,' ◐ تم حذف الامر')  
else
send(msg.chat_id_, msg.id_,' ◐ لا يوجد امر بهاذا الاسم')  
end
database:del(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end 
-------------------------------------------------------------------------------------------------------------- 
if data.message_.content_.text_ then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if (text and text == "تعطيل اوامر التحشيش") then 
send(msg.chat_id_, msg.id_, ' ◐ تم تعطيل اوامر التحشيش')
database:set(bot_id.."Fun_Bots:"..msg.chat_id_,"true")
end
if (text and text == "تفعيل اوامر التحشيش") then 
send(msg.chat_id_, msg.id_, '  ◐ تم تفعيل اوامر التحشيش')
database:del(bot_id.."Fun_Bots:"..msg.chat_id_)
end
if text == "نسبه الحب" or text == "نسبه حب" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
database:set(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_,"sendlove")
Text = '*ارسل أسماء الاشخاص* 🤎🧸  \n '
send(msg.chat_id_, msg.id_,Text) 
end
if text and text ~="نسبه الحب" and database:get(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_) == "sendlove" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","3","8","3","6","0",};
sendnum = num[math.random(#num)]
sl = '*نسبه حب '..text..' هي '..sendnum..'%*'
send(msg.chat_id_, msg.id_,sl) 
database:del(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_)
end
if text == "نسبه رجوله" or text == "نسبه الرجوله" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
database:set(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_,"sendrjoe")
Text = '*ارسل اسم الشخص الذي تريد قياس نسبه رجولته* \n '
send(msg.chat_id_, msg.id_,Text) 
end
if text and text ~="نسبه رجوله" and database:get(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_) == "sendrjoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","3","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = '*نسبه رجوله '..text..' هي \n '..sendnuj..'%*'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_)
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Muted_User(msg.chat_id_,msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Ban_User(msg.chat_id_,msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and Ban_User(msg.chat_id_,msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and GBan_User(msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Gmute_User(msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and GBan_User(msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
database:set(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
FoX = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(FoX)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "del" then   
FoX = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(FoX)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
if msg.content_.ID == 'MessagePinMessage' then
if Constructor(msg) then 
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.content_.message_id_)
else
local Msg_Pin = database:get(bot_id..'Pin:Id:Msg'..msg.chat_id_)
if Msg_Pin and database:get(bot_id.."lockpin"..msg.chat_id_) then
PinMessage(msg.chat_id_,Msg_Pin)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == 'MessagePinMessage' or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == 'MessageChatChangeTitle' or msg.content_.ID == "MessageChatDeleteMember" then   
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false
end    
end   
--------------------------------------------------------------------------------------------------------------
SourceFoX(data.message_,data)
plugin_Foxx(data.message_)
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ then
database:set(bot_id..'user:Name'..msg.sender_user_id_,(data.username_))
end
--------------------------------------------------------------------------------------------------------------
if tonumber(data.id_) == tonumber(bot_id) then
return false
end
end,nil)   
end
elseif (data.ID == "UpdateMessageEdited") then
local msg = data
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.message_id_)},function(extra, result, success)
database:incr(bot_id..'edits'..result.chat_id_..result.sender_user_id_)
local Text = result.content_.text_
if database:get(bot_id.."lock_edit_med"..msg.chat_id_) and not Text and not BasicConstructor(result) then
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local username = data.username_
local name = data.first_name_
local iduser = data.id_
local users = ('[@'..data.username_..']' or iduser)
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n ◐ شخص ما يحاول تعديل الميديا \n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ◐ لا يوجد ادمن"
end
send(msg.chat_id_,0,''..t..'\n*◐◐◐◐◐◐◐◐◐ٴ*\n ◐ تم التعديل على الميديا\n ◐ الشخص الي قام بالتعديل\n ◐ ايدي الشخص ◂ '..result.sender_user_id_..'\n ◐ معرف الشخص»{ '..users..' }') 
end,nil)
DeleteMessage(msg.chat_id_,{[0] = msg.message_id_}) 
end
local text = result.content_.text_
if not Mod(result) then
------------------------------------------------------------------------
if text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("[hH][tT][tT][pP][sT]") or text and text:match("[tT][eE][lL][eE][gG][rR][aA].[Pp][Hh]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa].[Pp][Hh]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("(.*)(@)(.*)") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text and text:match("@") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("(.*)(#)(.*)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("#") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
local FoXAbot = database:get(bot_id.."FoX1:Add:Filter:Rp2"..text..result.chat_id_)   
if FoXAbot then    
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ◐ العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n ◐ ["..FoXAbot.."] \n") 
else
send(msg.chat_id_,0," ◐ العضو : {["..data.first_name_.."](T.ME/IIIIlI8)}\n ◐ ["..FoXAbot.."] \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end
------------------------------------------------------------------------
if text and text:match("/") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end 
if text and text:match("(.*)(/)(.*)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text then
local FoX1_Msg = database:get(bot_id.."FoX1:Add:Filter:Rp2"..text..result.chat_id_)   
if FoX1_Msg then    
send(msg.chat_id_, msg.id_," ◐ "..FoX1_Msg)
DeleteMessage(result.chat_id_, {[0] = data.message_id_})     
return false
end
end
end
end,nil)
------------------------------------------------------------------------

elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then 
local list = database:smembers(bot_id.."User_Bot") 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end         
local list = database:smembers(bot_id..'Chek:Groups') 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',v)  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id..'Chek:Groups',v)  
end 
end,nil)
end

elseif (data.ID == "UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local Get_Msg_Pin = database:get(bot_id..'Msg:Pin:Chat'..msg.chat_id_)
if Get_Msg_Pin ~= nil then
if text == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) if d.ID == 'Ok' then;database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if Get_Msg_Pin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
end


end -- end new msg
end -- end callback
















