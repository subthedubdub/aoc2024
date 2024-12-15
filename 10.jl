### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 207b57d2-bb33-11ef-0e5b-8d2ff4f89af8
begin
	const data=read("10.txt", String)
end

# ╔═╡ af0c8dd7-266e-41d2-a348-309f96bb65fd
md"# Problem 1"

# ╔═╡ f57806d4-92ef-4428-82de-76d2fca0ba9a
begin
	function p1(data)
		width = first(findfirst("\n",data)) - 1
		height = length(data) ÷ (width + 1)
		# find character at column i row j
		charat(i,j) = data[i + (j - 1) * (width + 1)]
		matches(char,i,j)= (
			1<=i<=width && 
			1<=j<=height &&
			charat(i,j)==char
		)
		startingpositions =[
			(i,j) 
			for (i,j)∈Iterators.product(1:width, 1:height)
			if matches('0', i, j)
		]
		num_trailheads = 0
		walk(pos) = begin
			i,j=pos
			level = parse(Int, charat(first(pos), last(pos)))
			(level == 9) && return Set([pos])
			nextlevel = first(string(level + 1))
			gonorth = matches(nextlevel,i,j-1)
			gosouth = matches(nextlevel,i,j+1)
			gowest = matches(nextlevel,i-1,j)
			goeast = matches(nextlevel,i+1,j)
			res = Set{Tuple{Int,Int}}()
			gonorth && (res = res ∪ walk((i,j-1)))
			gosouth && (res = res ∪ walk((i,j+1)))
			gowest && (res = res ∪ walk((i-1,j)))
			goeast && (res = res ∪ walk((i+1,j)))
			return res
		end
		for startingpos in startingpositions
			for endingpos in walk(startingpos)
				num_trailheads += 1
			end
		end
		num_trailheads
	end
	p1(data)
end 

# ╔═╡ b47940a3-c5ea-45e4-ab89-92788086d37f
md"# Problem 2"

# ╔═╡ 86d6201d-3975-4b74-b4e7-6aa7c537f180
begin
	function p2(data)
		width = first(findfirst("\n",data)) - 1
		height = length(data) ÷ (width + 1)
		# find character at column i row j
		charat(i,j) = data[i + (j - 1) * (width + 1)]
		matches(char,i,j)= (
			1<=i<=width && 
			1<=j<=height &&
			charat(i,j)==char
		)
		startingpositions =[
			(i,j) 
			for (i,j)∈Iterators.product(1:width, 1:height)
			if matches('0', i, j)
		]
		total_rating = 0
		walk(pos) = begin
			i,j=pos
			level = parse(Int, charat(first(pos), last(pos)))
			(level == 9) && return 1
			nextlevel = first(string(level + 1))
			gonorth = matches(nextlevel,i,j-1)
			gosouth = matches(nextlevel,i,j+1)
			gowest = matches(nextlevel,i-1,j)
			goeast = matches(nextlevel,i+1,j)
			res = 0
			gonorth && (res = res + walk((i,j-1)))
			gosouth && (res = res + walk((i,j+1)))
			gowest && (res = res + walk((i-1,j)))
			goeast && (res = res + walk((i+1,j)))
			return res
		end
		for startingpos in startingpositions
			total_rating += walk(startingpos)
		end
		total_rating
	end
	p2(data)
end 

# ╔═╡ Cell order:
# ╠═207b57d2-bb33-11ef-0e5b-8d2ff4f89af8
# ╟─af0c8dd7-266e-41d2-a348-309f96bb65fd
# ╠═f57806d4-92ef-4428-82de-76d2fca0ba9a
# ╟─b47940a3-c5ea-45e4-ab89-92788086d37f
# ╠═86d6201d-3975-4b74-b4e7-6aa7c537f180
