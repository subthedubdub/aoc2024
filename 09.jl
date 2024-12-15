### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ c0a02348-b69f-11ef-1a14-21545787546c
const data = strip(read("09.txt", String))

# ╔═╡ c306002c-bc48-453d-8c52-a4a0b688cc22
const sample = "2333133121414131402"

# ╔═╡ ba3d6f18-5618-476c-abef-1daf124dada6
md"# Problem 1"

# ╔═╡ 1a93ee18-5ef2-49db-9bc6-cd0924434fb5
md"# Problem 2"

# ╔═╡ c9d5a90a-8570-4b51-b736-d0c6bd50123d
begin
	function parse(data)
		# returns a tuple containing
		# - vector of freespace (index,size)
		# - vector of file_id indices => size
		freespaces = Vector{Tuple{Int,Int}}()
		filepointers = Vector{Int}()
		freespace=false
		fileid=0
		count=0
		for idx in eachindex(data)
			val = parse(Int, data[idx])
			fill = freespace ? nothing : fileid
			for i in 1:val
				count += 1
			end
			freespace && (fileid += 1)
			freespace = !freespace
		end
		freespaces, filepointers
	end
	function p2(data)
		parse(data)
	end
	p2(sample)
end

# ╔═╡ ff624c66-7a78-4d9a-a79f-f2e4dcb927fd
begin
	function expand(data)
		# returns two things
		# an array of decompressed data
		# an index containing the freespace indexes
		freespace=false
		fileid=0
		out = Vector{Union{Int,Nothing}}()
		count=0
		indices = Vector{Int}();
		for idx in eachindex(data)
			val = parse(Int, data[idx])
			fill = freespace ? nothing : fileid
			for i in 1:val
				count += 1
				freespace && push!(indices, count)
				push!(out, fill)
			end
			freespace && (fileid += 1)
			freespace = !freespace
		end
		out, indices
	end
	function p1(data)
		expanded, indices = expand(data)
		idx = length(expanded)
		while true
			length(indices) == 0 && break
			isnumber = expanded[idx] != nothing
			if isnumber
				avail = popfirst!(indices)
				avail > idx && break
				expanded[avail] = expanded[idx]
				expanded[idx] = nothing
			end
			idx -= 1
		end
		checksum = 0
		for idx in eachindex(expanded)
			expanded[idx] == nothing && break
			checksum += (idx - 1) * expanded[idx]
		end
		checksum
	end
	p1(data)
end

# ╔═╡ Cell order:
# ╠═c0a02348-b69f-11ef-1a14-21545787546c
# ╠═c306002c-bc48-453d-8c52-a4a0b688cc22
# ╟─ba3d6f18-5618-476c-abef-1daf124dada6
# ╠═ff624c66-7a78-4d9a-a79f-f2e4dcb927fd
# ╟─1a93ee18-5ef2-49db-9bc6-cd0924434fb5
# ╠═c9d5a90a-8570-4b51-b736-d0c6bd50123d
