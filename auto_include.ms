#########################################
# Copyright 2016 ITSTAKE GPL v2.0
# Script by itstake (bexco2010@gmail.com)
# Version 1.3 (2018/02/04)
#########################################

#############
# USES VIRTUALCHEST EXTENSION

/*
proc(_itemmenu_create_vc, @array,
if(import('MenuOpen'.player()) != true) {
    export('MenuOpen'.player(), true)
    export('CurMenu'.player(), @array)
    
    @title = @array['title']
    @id = @array['id']
	if(array_index_exists(@array, size)) {
		@size = @array['size']
	} else {
	    @size = ceil((array_size(@array['menu'])) / 9) * 9 # Dynamically set the size
	}

    @chest = array(id: @id, size: @size, title: @title)
    @items = @array['menu']
    
    foreach(@key:@value in @items) {
        
        array_set(@chest, @key, @value['item'])
    }
    
    create_virtualchest(@chest)
    popen_virtualchest(@id)
	}
)
proc(_itemmenu_update_vc, @array,
    export('MenuOpen'.player(), true)
    export('CurMenu'.player(), @array)
    
    @title = @array['title']
    @id = @array['id']
	if(array_index_exists(@array, size)) {
		@size = @array['size']
	} else {
	    @size = ceil((array_size(@array['menu'])) / 9) * 9 # Dynamically set the size
	}

    @chest = array(id: @id, size: @size, title: @title)
    @items = @array['menu']
        for(@i = 0, @i < @size, @i++,
        if(!array_index_exists(@items, @i)) { 
        array_set(@chest, @i, array(type: 0,data: 0,qty: 0))
		}
    )
    foreach(@key:@value in @items) {
        array_set(@chest, @key, @value['item'])
    }
    update_virtualchest(@chest)
)
*/


############
# USES CORE FUNCTIONS

proc(_itemmenu_create, @array,
    export('CurMenu'.player(), @array)
    @title = @array['title']
    @id = @array['id']
	@type = 'CHEST'
	if(array_index_exists(@array, 'size')) {
		@size = @array['size']
	} else if(array_index_exists(@array, 'type')) { # If GUI Array have a type
		@type = @array['type']
	} else {
	    @size = ceil((array_size(@array['menu'])) / 9) * 9 # Dynamically set the size
	}
    @menu = @array['menu']
    @items = array()
    foreach(@key:@value in @menu) {
        
        array_set(@items, @key, @value['item'])
    }
    if(@type == 'CHEST') {
		create_virtual_inventory(@id, @size, colorize(@title), @items)
	} else {
		create_virtual_inventory(@id, @type, colorize(@title), @items)
	}
    popen_inventory(player(), @id)
)
proc(_itemmenu_update, @array,
    export('CurMenu'.player(), @array)
    @title = @array['title']
    @id = @array['id']
	if(array_index_exists(@array, size)) {
		@size = @array['size']
	} else {
	    @size = ceil((array_size(@array['menu'])) / 9) * 9 # Dynamically set the size
	}
    @menu = @array['menu']
        for(@i = 0, @i < @size, @i++,
        if(!array_index_exists(@menu, @i)) { 
        array_set(@chest, @i, array(type: 0,data: 0,qty: 0))
		}
    )
	@items = array()
    foreach(@key:@value in @menu) {
        array_set(@items, @key, @value['item'])
    }
    set_inventory(@id, @items)
)



