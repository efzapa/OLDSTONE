GLOBAL_VAR(emperorsurname)
GLOBAL_LIST_EMPTY(emperor_titles)

/datum/job/roguetown/emperor
	title = "Emperor"
	f_title = "Empress"
	flag = EMPEROR
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 1
	selection_color = JCOLOR_NOBLE
	allowed_races = list("Humen")
	allowed_sexes = list(MALE, FEMALE)

	spells = list(
		/obj/effect/proc_holder/spell/self/grant_title,
		/obj/effect/proc_holder/spell/self/convertrole/servant,
		/obj/effect/proc_holder/spell/self/convertrole/guard,
		/obj/effect/proc_holder/spell/self/convertrole/bog,
	)
	outfit = /datum/outfit/job/roguetown/emperor

	display_order = JDO_EMPEROR
	tutorial = "You are the supreme ruler of the lands, with absolute authority over all. Your word is law, and your power is unmatched. Use your influence wisely to maintain control and ensure the prosperity of your empire."
	whitelist_req = TRUE
	min_pq = 10
	max_pq = null
	give_bank_account = 5000
	required = TRUE

/datum/job/roguetown/exemperor //just used to change the emperor's title
	title = "Emperor Emeritus"
	f_title = "Empress Emeritus"
	flag = EMPEROR
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	display_order = JDO_LADY
	give_bank_account = TRUE

/datum/job/roguetown/emperor/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/list/chopped_name = splittext(L.real_name, " ")
		if(length(chopped_name) > 1)
			chopped_name -= chopped_name[1]
			GLOB.emperorsurname = jointext(chopped_name, " ")
		else
			GLOB.emperorsurname = "of [L.real_name]"
		SSticker.select_ruler()
		if(L.gender != FEMALE)
			to_chat(world, "<b><span class='notice'><span class='big'>[L.real_name] is Emperor of the Empire.</span></span></b>")
			addtimer(CALLBACK(L, TYPE_PROC_REF(/mob, emperor_color_choice)), 50)
		else
			to_chat(world, "<b><span class='notice'><span class='big'>[L.real_name] is Empress of the Empire.</span></span></b>")
			addtimer(CALLBACK(L, TYPE_PROC_REF(/mob, emperor_color_choice)), 50)

/datum/outfit/job/roguetown/emperor/pre_equip(mob/living/carbon/human/H) //TODO: add proper sprited equipment to the emperor when they spawn in
	..()
	head = /obj/item/clothing/head/roguetown/crown/serpcrown
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	cloak = /obj/item/clothing/cloak/lordcloak
	belt = /obj/item/storage/belt/rogue/leather/plaquegold
	l_hand = /obj/item/rogueweapon/lordscepter
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1)
	id = /obj/item/clothing/ring/active/nomag	
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/black
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
		shoes = /obj/item/clothing/shoes/roguetown/boots	
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("intelligence", 4)
			H.change_stat("endurance", 4)
			H.change_stat("speed", 2)
			H.change_stat("perception", 3)
			H.change_stat("fortune", 6)
		if(ishumannorthern(H))
			H.dna.species.soundpack_m = new /datum/voicepack/male/evil()

		if(H.wear_mask)
			if(istype(H.wear_mask, /obj/item/clothing/mask/rogue/eyepatch))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/mask/rogue/lordmask
			if(istype(H.wear_mask, /obj/item/clothing/mask/rogue/eyepatch/left))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/mask/rogue/lordmask/l
	else //Empress, probably not used but just in case
		armor = /obj/item/clothing/suit/roguetown/armor/armordress
		belt = /obj/item/storage/belt/rogue/leather/plaquegold
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.change_stat("intelligence", 3)
			H.change_stat("endurance", 3)
			H.change_stat("speed", 2)
			H.change_stat("perception", 2)
			H.change_stat("fortune", 5)

	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSEGRAB, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
