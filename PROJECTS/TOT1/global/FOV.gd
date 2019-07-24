#################################
#								#
#	FIELD OF VIEW GENERATOR		#
#								#
#################################

extends Node




# Calculates an array of cells within the FOV of the origin within radius range
#  dat= source datamap (2-dimensional array of int)
#  wall_index= datamap int which represents a sight-blocker
#  origin= origin cell to cast FOV from
#  radius= distance in cells to cast to (only cells within radius are considered)

func calculate_fov(dat, wall_index, origin, radius, blocked=[])->PoolVector2Array:
	var data = dat.duplicate(true) # Make a working copy of data
	for cell in blocked:
		data[cell.x][cell.y] = wall_index
	var rect:Rect2 = get_fov_rect(origin, radius)
	var cells:PoolVector2Array = PoolVector2Array()
	
	# scan top edge
	for x in range(rect.position.x, rect.end.x-1):
		var V:Vector2 = Vector2(x,rect.position.y)
		var line:PoolVector2Array = cast_fov_ray(data,wall_index,origin,V)
		for cell in line:
			if not cell in cells:
				if int(cell.distance_to(origin)) <= radius:
					cells.append(cell)
	# scan bottom edge
		V = Vector2(x,rect.end.y-1)
		var line2:PoolVector2Array = cast_fov_ray(data,wall_index,origin,V)
		for cell in line2:
			if not cell in cells:
				if int(cell.distance_to(origin)) <= radius:
					cells.append(cell)
	# scan left edge
	for y in range(rect.position.y, rect.end.y):
		var V:Vector2 = Vector2(rect.position.x, y)
		var line:PoolVector2Array = cast_fov_ray(data,wall_index,origin,V)
		for cell in line:
			if not cell in cells:
				if int(cell.distance_to(origin)) <= radius:
					cells.append(cell)
	#scan right edge
		V = Vector2(rect.end.x-1, y)
		var line2:PoolVector2Array = cast_fov_ray(data,wall_index,origin,V)
		for cell in line2:
			if not cell in cells:
				if int(cell.distance_to(origin)) <= radius:
					cells.append(cell)
	
	
	for cell in cells:

		if not is_wall(data, wall_index, cell):
			for x in range(-1,2):
				for y in range(-1,2):
					var ncell:Vector2 = cell+Vector2(x,y)
					if is_wall(data, wall_index, ncell) and int(ncell.distance_to(origin)) <= radius:
						cells.append(ncell)

	return cells


# Construct a rectangle around origin with radius distance to an edge
func get_fov_rect(origin, radius)->Rect2:
	var x:int = origin.x - radius
	var y:int = origin.y - radius
	var s:int = 1+(radius*2)
	return Rect2(Vector2(x,y),Vector2(s,s))

# Check for wall index in datamap cell
func is_wall(data, wall_index, cell)->bool:
	return data[cell.x][cell.y] == wall_index



# Cast a fov line, stopping at first blocking cell
func cast_fov_ray(data,wall_index,from,to)->PoolVector2Array:
	var cells:PoolVector2Array = PoolVector2Array()
	var line:PoolVector2Array = get_line(from,to)
	for cell in line:
		# Check for blocking cell
		if not is_wall(data, wall_index, cell):
			cells.append(cell)
		else:
			# include the blocking cell in the list
			cells.append(cell)
			return cells
	return cells

# Returns an array of datamap cells that lie
# under the from map cell to map cell
func get_line(from,to)->PoolVector2Array:
	# setup
	var x1:int = from.x
	var y1:int = from.y
	var x2:int = to.x
	var y2:int = to.y
	var dx:int = x2 - x1
	var dy:int = y2 - y1

	
	# determine steepness of line
	var is_steep:bool = abs(dy) > abs(dx)
	# rotate line if steep
	if is_steep:
		# swap x1/y1
		var ox:int = x1
		x1 = y1
		y1 = ox 
		# swap x2/y2
		ox = x2
		x2 = y2
		y2 = ox

	# swap start points if needed
	var swapped = false
	if x1 > x2:
		# swap x1/x2
		var ox:int = x1
		x1 = x2
		x2 = ox
		# swap y1/y2
		var oy:int = y1
		y1 = y2
		y2 = oy
		swapped = true
	
	# recalculate differentials
	dx = x2-x1
	dy = y2-y1
	
	# calculate error
	var error:int = int(dx / 2.0)
	var ystep:int = 1 if y1 < y2 else -1
	
	# iterate over bounding box generating points between
	var y:int = y1
	var points:PoolVector2Array = PoolVector2Array()
	for x in range(x1, x2+1):
		var coord:Vector2 = Vector2(y,x) if is_steep else Vector2(x,y)
		points.append(coord)
		error -= abs(dy)
		if error < 0:
			y += ystep
			error += dx
	
	# reverse list if coordinates were swapped
	if swapped:
		points.invert()

	return points