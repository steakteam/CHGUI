#########################################
# Copyright 2016 ITSTAKE GPL v2.0
# Script by itstake (bexco2010@gmail.com)
# Version 1.3 (2018/02/04)
#########################################

/*
bind('virtualchest_closed', null, null, @event,
    @array = import('CurMenu'.player())
    export('MenuOpen'.player(), false) # Itemmenu is closed
)
*/

bind(inventory_close, null, null, @e,
	if(@e['virtual'] && is_array(import('CurMenu'.@e['player']))) {
		delete_virtual_inventory(@e['holder'])
		export('CurMenu'.@e['player'], null)
	}
)


bind(inventory_click, null, null, @e,
	@array = import('CurMenu'.player()) # Import Menu Array
    if(@array == null || !@e['virtual']) { 
        die() 
    }
    cancel() # Cancel Click
    @number = @e['rawslot']
	if(!(array_index_exists(@array['menu'], @number) && @number >= 0), die())
        if(array_index_exists(@array['menu'][@number], to_lower(@e[clicktype]))) {
        	execute(@array['menu'][@number][to_lower(@e[clicktype])])
        } else {
        	execute(@array['menu'][@number]['click'])
        }
	play_sound(ploc(@e[player]), array(sound: CLICK), @e[player])
    
)
