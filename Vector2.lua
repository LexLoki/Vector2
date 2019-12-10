local c = require'lib/class'
local Vector2 = c('Vector2')
local add,sub,mul,mull,div,lt,eq

function Vector2.new(x,y)
	local self = Vector2.newObject()
	self.x = x or 0
	self.y = y or 0
	local m = getmetatable(self)
	m.__add = add
	m.__sub = sub
	m.__mul = mul
	m.__div = div
	m.__lt = lt
	m.__eq = eq
	return self
end

function Vector2:set(x,y)
	self.x = x or self.x
	self.y = y or self.y
end

function Vector2:lerp(v1,v2,t)
	self:set(v1.x*(1-t)+t*v2.x,v1.y*(1-t)+t*v2.y)
end

function Vector2.vectorFrom(mag,angle)
	return Vector2.new(mag*math.cos(angle),mag*math.sin(angle))
end

function Vector2:magnitude()
	return math.sqrt(self.x*self.x+self.y*self.y)
end

function Vector2:normalize()
	local m = self:magnitude()
	if m==0 then
		self:set(0,0)
	else
		self:set(self.x/m,self.y/m)
	end
end

function Vector2:normalized()
	local v = self:copy()
	v:normalize()
	return v
end

function Vector2:add(vec)
	self:set(self.x+vec.x,self.y+vec.y)
end

function Vector2:scaled(vec)
	return Vector2.new(self.x*vec.x,self.y*vec.y)
end

function Vector2:distance(vec)
	return (self-vec):magnitude()
end

function Vector2:copy()
	return Vector2.new(self.x,self.y)
end

function Vector2:lerped(vec,t)
	return self+(vec-self)*t
end

function Vector2:angle()
	return math.atan2(self.y,self.x)
end

function Vector2:rotate(angle)
	return Vector2.vectorFrom(self:magnitude(),self:angle()+angle)
end

function Vector2:print()
	print('x = '..self.x..', y = '..self.y)
end

function Vector2:clamp(min,max)
	return Vector2.new(
		math.min(math.max(self.x,min.x),max.x),
		math.min(math.max(self.y,min.y),max.y)
	)
end

function add(t1,t2)
	if type(t1)=='number' then return Vector2.new(t1+t2.x,t1+t2.y) end
	if type(t2)=='number' then return Vector2.new(t1.x+t2,t1.y+t2) end
	return Vector2.new(t1.x+t2.x,t1.y+t2.y)
end
function sub(t1,t2)
	if type(t1)=='number' then return Vector2.new(t1-t2.x,t1-t2.y) end
	if type(t2)=='number' then return Vector2.new(t1.x-t2,t1.y-t2) end
	return Vector2.new(t1.x-t2.x,t1.y-t2.y)
end
function mull(n,t) return Vector2.new(n*t.x,n*t.y) end
function mul(t1,t2)
	if type(t1)=='number' then return mull(t1,t2) end
	if type(t2)=='number' then return mull(t2,t1) end
	return Vector2.new(t1.x*t2.x,t1.y*t2.y)
end
function div(t1,t2)
	return type(t1)=='number' and Vector2.new(t1/t2.x,t1/t2.y) or mull(1/t2,t1) end
function lt(t1,t2) return t1.x<t2.x and t1.y<t2.y end
function eq(t1,t2) return t1.x==t2.x and t1.y==t2.y end

return Vector2