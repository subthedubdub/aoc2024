### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ eda9d068-b581-11ef-360a-f162f294c9ff
begin
	const data=read("08.txt", String)
	using IterTools # subsets
end

# ╔═╡ 24de9e8e-a8c2-4371-bff9-8896b2fbf93c
md"# Problem 1

- Loop through all pairs $x,y$ of antennas with matching frequencies.
- Calculate displacement vector $v=x-y$. Check if $y+2v$ is in bounds. If so, it is an antinode. Also check $y+\frac{1}{3}v$ if $v$ is divisible by 3.
"

# ╔═╡ 86d872c6-dedd-4988-b5fb-ecc69f764f65
begin
	function p1(data)
		width = first(findfirst("\n",data)) - 1
		height = length(data) ÷ (width + 1)
		# util functions
		charat(i,j) = data[i + (j - 1) * (width + 1)]
		inbounds(i,j)=(1<=i<=width) && (1<=j<=height)
		matches(char,i,j)= inbounds(i,j) && (charat(i,j)==char)
		# get antenna locations
		# represented as map of frequences to set of
		# coordinate pairs.
		antennas = Dict{Char,Set{Tuple{Int,Int}}}()
		for (i,j) in product(1:width,1:height)
			matches('.',i,j) && continue
			freq = charat(i,j)
			locs = get(antennas,freq, Set{Tuple{Int,Int}}())
			push!(locs, (i,j))
			antennas[freq] = locs
		end
		antinodes = Set{Tuple{Int,Int}}()
		for (freq, locs) in pairs(antennas)
			for (x,y) in subsets(collect(locs), Val{2}())
				v = (x[1]-y[1],x[2]-y[2])
				#y+2v
				yp2v = (y[1]+2v[1],y[2]+2v[2])
				inbounds(yp2v...) && push!(antinodes,yp2v)
				#x-2v
				xm2v= (x[1]-2v[1],x[2]-2v[2])
				inbounds(xm2v...) && push!(antinodes,xm2v)
			end
		end
		length(antinodes)
	end
	p1(data)
end

# ╔═╡ 36e2eadf-5175-41d4-9797-36cec3cd7522
md"# Problem 2"

# ╔═╡ 75a47f06-33f6-468a-8be0-c5339e659b9a
begin
	function p2(data)
		width = first(findfirst("\n",data)) - 1
		height = length(data) ÷ (width + 1)
		# util functions
		charat(i,j) = data[i + (j - 1) * (width + 1)]
		inbounds(i,j)=(1<=i<=width) && (1<=j<=height)
		matches(char,i,j)= inbounds(i,j) && (charat(i,j)==char)
		# get antenna locations
		# represented as map of frequences to set of
		# coordinate pairs.
		antennas = Dict{Char,Set{Tuple{Int,Int}}}()
		for (i,j) in product(1:width,1:height)
			matches('.',i,j) && continue
			freq = charat(i,j)
			locs = get(antennas,freq, Set{Tuple{Int,Int}}())
			push!(locs, (i,j))
			antennas[freq] = locs
		end
		antinodes = Set{Tuple{Int,Int}}()
		for (freq, locs) in pairs(antennas)
			for (x,y) in subsets(collect(locs), Val{2}())
				v = (x[1]-y[1],x[2]-y[2])
				# forwards
				n = 0
				while true
					antinode = (y[1]+n*v[1],y[2]+n*v[2])
					!inbounds(antinode...) && break
					push!(antinodes, antinode)
					n +=1
				end
				# backwards
				n = -1
				while true
					antinode = (y[1]+n*v[1],y[2]+n*v[2])
					!inbounds(antinode...) && break
					push!(antinodes, antinode)
					n -=1
				end
			end
		end
		length(antinodes)
	end
	p2(data)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
IterTools = "c8e1da08-722c-5040-9ed9-7db0dc04731e"

[compat]
IterTools = "~1.10.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.1"
manifest_format = "2.0"
project_hash = "89e50390f9f4506f588655c92ba43dbfd7ea204f"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"
"""

# ╔═╡ Cell order:
# ╠═eda9d068-b581-11ef-360a-f162f294c9ff
# ╟─24de9e8e-a8c2-4371-bff9-8896b2fbf93c
# ╠═86d872c6-dedd-4988-b5fb-ecc69f764f65
# ╟─36e2eadf-5175-41d4-9797-36cec3cd7522
# ╠═75a47f06-33f6-468a-8be0-c5339e659b9a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
