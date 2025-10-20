-- llama_agent.lua
local session = freeswitch.Session("{ignore_early_media=true}1000")
if not session:ready() then return end
-- Play beep to prompt caller
session:execute("playback", "tone_stream://%(200,0,640)")
-- Record caller audio to file
local wav_file = "/tmp/caller.wav"
session:execute("record", wav_file .. " 5000") -- record 5 seconds max
-- Call external Python script to do STT, AI, TTS and return response wav 
file
local handle = io.popen("python llama_agent.py " .. wav_file)
local response_wav = handle:read("*a")
handle:close()
-- Play AI response audio
session:execute("playback", response_wav)
session:hangup()
