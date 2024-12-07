### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 92feb8d4-b3d4-11ef-129e-65d81de78372
data=read("06.txt", String)

# ╔═╡ 2b864bf1-c195-4590-a418-434f69d0e749
md"
# Problem 1
"

# ╔═╡ f3935a24-975c-43a7-bc90-6255f5cc31e6
function prob1()
	width = first(findfirst("\n",data)) - 1
	height = length(data) ÷ (width + 1)
	# find character at column i row j
	charat(i,j) = data[i + (j - 1) * (width + 1)]
	matches(char,i,j)= (
		1<=i<=width && 
		1<=j<=height &&
		charat(i,j)==char
	)
	visited = Set{Tuple{Int,Int}}()
	# find starting position
	pos = (0,0)
	for i in 1:width
		for j in 1:height
			if matches('^',i,j)
				pos = (i,j)
				break
			end
		end
	end
	push!(visited, pos)
	dir = 'U'
	dirs = Dict(
		'U' => (0,-1),
		'D' => (0,1),
		'L' =>(-1,0),
		'R' =>(1,0)
	)
	rotations = Dict(
		'U'=> 'R',
		'R'=>'D',
		'D'=>'L',
		'L'=>'U'
	)
	nextpos() =  begin
		dx,dy = dirs[dir]
		first(pos)+dx,last(pos)+dy
	end
	# begin walking
	while true
		pos2 = nextpos()
		if (
			first(pos2) < 1 ||
			first(pos2) > width ||
			last(pos2) < 1 ||
			last(pos2) > height
		) break end
		if matches('#', first(pos2), last(pos2))
			dir = rotations[dir]
			continue
		end
		pos = pos2
		push!(visited, pos)
	end
	length(visited)
end

# ╔═╡ f1a84a3d-68a1-4990-b56d-bdcbacb24358
prob1()

# ╔═╡ 92bbb9a8-8d1e-419c-9e67-e9b3946393dd
md"# Problem 2
Here we brute force the HECK out of this.
A loop happens when we visited the same spot twice with the same direction. We do this by factoring problem 1 as as a `walk(data)` function
"

# ╔═╡ 5f37127b-f2e2-404e-837c-cc986537633b
function prob2()
	# Returns number of steps 
	function walk(data)
		width = first(findfirst("\n",data)) - 1
		height = length(data) ÷ (width + 1)
		# find character at column i row j
		charat(i,j) = data[i + (j - 1) * (width + 1)]
		matches(char,i,j)= (
			1<=i<=width && 
			1<=j<=height &&
			charat(i,j)==char
		)
		visited = Set{Tuple{Char,Tuple{Int,Int}}}()
		# find starting position
		pos = (0,0)
		for i in 1:width
			for j in 1:height
				if matches('^',i,j)
					pos = (i,j)
					break
				end
			end
		end
		dir = 'U'
		push!(visited, (dir, pos))
		dirs = Dict(
			'U' => (0,-1),
			'D' => (0,1),
			'L' =>(-1,0),
			'R' =>(1,0)
		)
		rotations = Dict(
			'U'=> 'R',
			'R'=>'D',
			'D'=>'L',
			'L'=>'U'
		)
		nextpos() =  begin
			dx,dy = dirs[dir]
			first(pos)+dx,last(pos)+dy
		end
		# begin walking
		num_steps = 0
		while true
			pos2 = nextpos()
			# infinite loop detection
			(dir, pos2) ∈ visited && return -1
			if (
				first(pos2) < 1 ||
				first(pos2) > width ||
				last(pos2) < 1 ||
				last(pos2) > height
			) break end
			if matches('#', first(pos2), last(pos2))
				dir = rotations[dir]
				continue
			end
			num_steps += 1
			pos = pos2
			push!(visited, (dir, pos))
		end
		num_steps
	end
	num_loops = 0
	for idx in eachindex(data)
		newdata = data[1:idx-1]*'#'*data[idx+1:end]
		num_loops += walk(newdata) == -1
	end
	return num_loops
end

# ╔═╡ 3dd6a0b7-405c-463d-8cc8-359d58e2da48
prob2()

# ╔═╡ ca86274b-dec5-4af0-8ced-1195608cc1d5
length(data)

# ╔═╡ Cell order:
# ╠═92feb8d4-b3d4-11ef-129e-65d81de78372
# ╟─2b864bf1-c195-4590-a418-434f69d0e749
# ╠═f3935a24-975c-43a7-bc90-6255f5cc31e6
# ╠═f1a84a3d-68a1-4990-b56d-bdcbacb24358
# ╟─92bbb9a8-8d1e-419c-9e67-e9b3946393dd
# ╠═5f37127b-f2e2-404e-837c-cc986537633b
# ╠═3dd6a0b7-405c-463d-8cc8-359d58e2da48
# ╠═ca86274b-dec5-4af0-8ced-1195608cc1d5
