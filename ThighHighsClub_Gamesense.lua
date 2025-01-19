--------------------------------------------------------------------------------
-- Caching common functions
--------------------------------------------------------------------------------
local client_delay_call, client_exec, client_userid_to_entindex, entity_get_all, math_random, ui_new_combobox, ui_set_visible, ui_get, entity_get_local_player =
client.delay_call, client.exec, client.userid_to_entindex, entity.get_all, math.random, ui.new_combobox, ui.set_visible,
	ui.get, entity.get_local_player
local uix = require 'gamesense/uix'

--------------------------------------------------------------------------------
-- Constants and variables
--------------------------------------------------------------------------------
local enable_ref
local mode_ref

--------------------------------------------------------------------------------
-- KillSay Table
--------------------------------------------------------------------------------
local KillSays = {
	Hentai = {
		Kill = {
			{ "S-Sorry onii-chan p-please d-do me harder ;w;" },
			{ "Y-You got me all wet now Senpai!" },
			{ "D-Don't t-touch me there Senpai" },
			{ "P-Please l-love me harder oniichan ohh grrh aahhhh~!" },
			{ "Give me all your cum Senpai ahhhhh~" },
			{ "F-Fuck me harder chan!" },
			{ "Oh my god I hate you so much Senpai but please k-keep fucking me harder! ahhh~" },
			{ "D-Do you like my stripped panties getting soaked by you and your hard cock? ehhh master you're so lewd ^0^~" },
			{ "Kun your cute little dick between my pussy lips looks really cute, I'm blushing" },
			{ "M-Master does it feel good when I slide by tits up and down on your cute manly part?" },
			{ "O-Oniichan my t-toes are so warm with your cum all over them uwu~" },
			{ "Lets take this swimsuit off already <3 i'll drink your unknown melty juice" },
			{ "S-Stop Senpai if we keep making these lewd sounds im going to cum~~" },
			{ "You're such a pervert for filling me up with your baby batter Senpai~~" },
			{ "Fill up my baby chamber with your semen kun ^-^" },
			{ "M-Master d-dont spank my petite butt so hard ahhhH~~~ you're getting me so w-wet~" },
			{ "Senpai your cock is already throbbing from my huge tits~" },
			{ "Hey kun, Can I have some semen?" },
			{ "M-My baby chamber is overflowing with your semen M-Master" },
			{ "Fill my throat pussy with your semen kun" },
			{ "It-It's not gay if you're wearing thigh highs M-Master" },
			{ "I-I need somewhere to blow my load. Can i borrow your bussy?" },
			{ "A-ah shit... Y-your cock is big and in my ass -- already~?!" },
			{ "I'll swallow your sticky essence along with you~!" },
			{ "B-Baka please let me be your femboy sissy cum slut!" },
			{ "That's a penis UwU you towd me you wewe a giww!!" },
			{ "Ahhhh... It's like a dream come true... I get to stick my dick inside your ass...!" },
			{ "Hey, who wants a piece of this plump 19-year-old boy-pussy? Single file, boys, come get it while it's hot!" },
			{ "M-Master, if you keep thrusting that hard, my boobs will fall off!" },
			{ "When do you wanna meet up again? I've really taken a liking to your dick! (,,◠∇◠) I want you and only you to slam it into my pussy every day! (≧∇≦)" },
			{ "All I did was crossplay 'cause I felt like it might be fun... But now I'm just a little girl that cums from big dicks!" },
			{ "D-Don't get the wrong idea!!! I don't w-want you to fuck my b-bussy because I l-love you or anything! d-definitely not!" },
			{ "I-I know I said you could be as rough as you want... But surprise fisting wasn't what I had in mind!!" },
			{ "W-Why is it that lately... Y-You haven't been playing with my ass!!?" },
		},

		Death = {
			{ "Hehe don't touch me there Onii-chann UwU" },
			{ "Your cum is all over my wet clit M-Master" },
			{ "It Feels like you're pounding me with the force of a thousand suns Senpai" },
			{ "Y-Yes right there S-Sempai hooyah" },
			{ "P-Please keep filling my baby chamber S-Sempai" },
			{ "O-Onii-chan it felt so good when you punded my bussy" },
			{ "P-Please Onii-chan keep filling my baby chamber with your melty juice" },
			{ "O-Onii-chan you just one shot my baby chamber" },
			{ "I-Im nothing but a f-fucktoy slut for your m-monster fuckmeat!" },
			{ "Dominate my ovaries with your vicious swimmers!" },
			{ "Y-Your meat septer has penetrated my tight boy hole" },
			{ "Mnn FASTER... HARDER! Turn me into your femboy slut~!" },
			{ "Mmmm- soothe me, caress me, Fuck me, breed me!" },
			{ "Probe your thick, wet, throbbing cock deeper and deeper into my boipussy~!!" },
			{ "Hya! Not my ears! Ah... It tickles! Ah!" },
			{ "Kouta... I can't believe how BIG his... Wait! Forget about that!! Is Nyuu-chan really giving him a Tit-Fuck!?" },
			{ "Senpai shove deeper your penis in m-my pussy (>ω<) please" },
			{ "I'm coming fwom you fwuking my asshole mmyyy!" },
			{ "P-Please be gentle, S-Senpai!" },
			{ "D-Don't get the wrong idea!! I didn't give up my viginity to you because I like you or anything!!" },
			{ "Let me taste your futa cock with my pussy~" },
		}
	},

	Lewd = {
		Kill = {
			{ "Oh do you wanna eat? Do you wanna take a bath? Or do you want me!" },
			{ "It's not gay if you swallow the evidence!" },
			{ "That's a penis UwU you towd me you wewe a giww!!" },
			{ "You are cordially invited to fuck my ass!" },
			{ "Grab them, squeeze them, pinch them, pull them, lick them, bite them, suck them!" },
			{ "It feels like your dick is sliding into a slimy pile of macaroni!" },
			{ "This is the cock block police! Hold it right there!" },
			{ "Ohoo, getting creampied made you cum? What a lewd bitch you are!" },
			{ "I've jerked off every single day... Given birth to countless snails... All while fantasizing about the day I'd get to fuck you!" },
			{ "You're looking at porn when you could be using your little sister instead!" },
			{ "Umm... I don't wanna sound rude, but have you had a bath? Your panties look a bit yellow..." },
			{ "Papa you liar! How could you say that while having such a HUGE erection." },
			{ "I-I just wanna borrow y-your dick..." },
			{ "If a man inserts his hose into another man's black hole, can they make a baby?" },
			{ "I-I had a itch down there... and I-I just needed something to-to stick up in there!" },
			{ "You have some tasty-looking panties there..." },
			{ "You're my personal cum bucket!!" },
			{ "I-I'm cumming, I'm cumming, CUM with me too!" },
			{ "Your resistance only makes my penis harder!" },
			{ "Cum, you naughty cock! Do it! Do it! DO IT!!!" },
			{ "Boys just can't consider themselves an adult... Until they've had a chance to cum with a girl's ampit." },
			{ "We're both gonna fuck your pussy at the same time!" },
			{ "When everyone's gone home for the day and the classroom is empty you have no choice but to expose yourself and jerk off, right?" },
		},

		Death = {
			{ "Dominate my ovaries with your vicious swimmers!" },
			{ "Impregnate me with your viral stud genes!" },
			{ "M-My body yearns for your sweet dick milk" },
			{ "My nipples are being tantalized" },
			{ "Penetrate me until I bust!" },
			{ "Mmmm- soothe me, caress me, Fuck me, breed me!" },
			{ "I'm your personal cum bucket!!" },
			{ "Can you really blame me for getting a boner after seeing that?" },
			{ "The two of us will cover my sis with our cum!" },
			{ "This... This is almost like... like somehow I'm the one raping him!" },
			{ "You're impregnating my balls!?" },
			{ "If you weren't a pervert, you wouldn't be getting off on having a girl do you in the butt, would you?" },
			{ "Well, well... What a cutie you are! I will claim your virginity!" },
			{ "Oh, yeahh! You wanna fuck?" },
			{ "I'm getting pissed off and horny right now!" },
		}
	},


	Edgy = {
		Kill = {
			{ "Let my K/D do the talking" },
			{ "mad cuz bad" },
			{ "Config error, user banned, thread locked." },
			{ "IQ error" },
			{ "I'm the reason your dads gay faggot" },
			{ "How's your mom doin after last night?" },
			{ "Dead people can't talk nn" },
			{ "Warmth, love, and affection. These are the things I have taken away from you." },
			{ "I’ve made a contract with the devil, so I can’t be friends with a god." },
			{ "Corpses are good. They don’t babble." },
			{ "The weak are destined to lie beneath the boots of the strong." },
			{ "Options -> How to play" },
			{ "The world is better without you" },
			{ "Life is endless suffering..." },
			{ "I'm just killing the spiders to save the butterflies." },
			{ "Fear is what creates order." },
			{ "No matter how much you cry I won't stop." },
			{ "Deleted" },
			{ "*DEAD*" },
			{ "Re_solved" },
			{ "De_stroyed" },
			{ "If God wanted you to live he would not have created me." },
			{ "Earn your damnation" },
			{ "Vengeance is mine" },
			{ "If at first you do not succeed... try, try again." },
			{ "Watch your head" },
			{ "When you are ready call for me" },
			{ "Now I am become Death, the destroyer of worlds" },
			{ "Easy come, easy go" },
			{ "I stay, you go" },
			{ "End of the line for you" },
			{ "Maybe tomorrow." },
			{ "I'm fucking invincible." },
			{ "See you in a couple of minutes." },
			{ "You are strong child, but I am beyond strength" },
		},

		Death = {
			{ "You only killed me because I ran out of health.." },
			{ "I bet dead people are easier to get along with." },
			{ "The real hell is inside the person." },
			{ "The ones who kill should be prepared to be killed." },
			{ "I gave you that one" },
			{ "Congratulations! You're on the scoreboard now." },
			{ "Emotions are a mental disorder" },
			{ "Carpe Diem" },
			{ "Gone but not forgotten" },
			{ "I'll be back" },
			{ "Deploying the counter measure" },
			{ "There are no ends, only new beginnings" },
		}
	}
}

local function on_kill_message_toggle(ref)
	local script_state = ui_get(ref)
	ui_set_visible(mode_ref, script_state)
end


--------------------------------------------------------------------------------
-- Callback functions
--------------------------------------------------------------------------------
local function chat(e)
	delayed_msg = function(delay, msg)
		return client_delay_call(delay, function() client_exec('say ' .. msg) end)
	end

	local delay = 2.3
	local mode = ui_get(mode_ref)
	local me = entity_get_local_player()
	local victim = client_userid_to_entindex(e.userid)
	local attacker = client_userid_to_entindex(e.attacker)
	local say = KillSays[mode]

	local killsay_delay = 0
	local deathsay_delay = 0

	if entity_get_local_player() == nil then return end

	gamerulesproxy = entity_get_all("CCSGameRulesProxy")[1]
	warmup = entity.get_prop(gamerulesproxy, "m_bWarmupPeriod")
	if warmup == 1 then return end

	if (victim ~= attacker and attacker == me) then
		if mode == 'None' then return end
		local phase_block = say.Kill[math_random(1, #say.Kill)]


		for i = 1, #phase_block do
			local phase = phase_block[i]
			local interphrase_delay = #phase_block[i] / 24 * delay
			killsay_delay = killsay_delay + interphrase_delay

			delayed_msg(killsay_delay, phase)
		end
	end

	if (victim == me and attacker ~= me) then
		if mode == 'None' then return end
		local phase_block = say.Death[math_random(1, #say.Death)]

		for i = 1, #phase_block do
			local phase = phase_block[i]
			local interphrase_delay = #phase_block[i] / 20 * delay
			deathsay_delay = deathsay_delay + interphrase_delay

			delayed_msg(deathsay_delay, phase)
		end
	end
end


--------------------------------------------------------------------------------
-- Initilization code
--------------------------------------------------------------------------------
local function init()
	enable_ref = uix.new_checkbox("LUA", "B", "ThighHighsClub")
	mode_ref   = ui_new_combobox("LUA", "B", "Select Killsay Mode", "None", "Hentai", "Lewd", "Edgy")


	enable_ref:on("change", on_kill_message_toggle)
	enable_ref:on("player_death", chat)
end


init()
