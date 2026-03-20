repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local KEYS = {
    ["Vortex_22ab49Bwks3819Bk9ak"] = nil,
    ["Vortex_51fownB39Al381Jsjc38"] = nil,
    ["Vortex_582a19ajcnw9Bk52wna"] = nil
}

local inputKey = getgenv().KeyInput or ""

if inputKey == "" then
    LocalPlayer:Kick("Bạn chưa nhập key!")
    return
end

if KEYS[inputKey] == nil and KEYS[inputKey] ~= nil then
    LocalPlayer:Kick("Key không hợp lệ!")
    return
end

local DATA_FILE = "vortex_key_data.json"
local HttpService = game:GetService("HttpService")

local SavedData = {}

if isfile and isfile(DATA_FILE) then
    local raw = readfile(DATA_FILE)
    SavedData = HttpService:JSONDecode(raw)
end

if SavedData[inputKey] then
    if SavedData[inputKey] ~= LocalPlayer.UserId then
        LocalPlayer:Kick("Key này đã được sử dụng bởi tài khoản khác!")
        return
    end
else
    SavedData[inputKey] = LocalPlayer.UserId

    if writefile then
        writefile(DATA_FILE, HttpService:JSONEncode(SavedData))
    end
end

print("Key hợp lệ! Đang vào Vortex Hub...")

loadstring(game:HttpGet("https://raw.githubusercontent.com/hungnguyen2k113-debug/SatThuThamLang/main/Vortex.lua"))()