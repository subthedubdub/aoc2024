### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 10df3b2a-b2c7-11ef-33c0-13b2e68252c7
data=read("05.txt", String)

# ╔═╡ c8e929b2-1c98-45a1-b973-bfeb130eecdf
md"
# Problem 1
"

# ╔═╡ 5e08f379-df25-4eff-ad53-25d00df4f1ec
function prob1()
	lines = split(data,'\n')
	rules = Dict{Int,Set{Int}}()
	manuals = Vector{Vector{Int}}()
	for line in lines
		m1 = match(r"(\d+)\|(\d+)", line)
		if m1 != nothing
			firstpage = parse(Int, m1.captures[1])
			secondpage = parse(Int, m1.captures[2])
			subsequents = get(rules, firstpage, Set{Int}())
			push!(subsequents, secondpage)
			rules[firstpage] = subsequents
		elseif contains(line, ',')
			manual=[parse(Int,x) for x ∈ split(line, ',')]
			push!(manuals,manual)
		end
	end
	total = 0
	for manual in manuals
		isgood = true
		for i in eachindex(manual)
			firstpage = manual[i]
			for j in i:length(manual)
				secondpage = manual[j]
				if (secondpage ∈ keys(rules)) && (firstpage ∈ rules[secondpage])
					isgood = false
				end
			end
			isgood || break
		end
		if isgood
			midpage = manual[(length(manual) + 1) ÷ 2]
			total += midpage
		end
	end
	total
end

# ╔═╡ 28f1f299-71ec-4b68-8345-a9a8b3fb5020
prob1()

# ╔═╡ 415440f7-0dac-407e-92d1-f6929182f748
md"
# Problem 2
"

# ╔═╡ 8672e664-c27d-48d6-8dd5-52340ce22f51
function prob2()
	lines = split(data,'\n')
	rules = Dict{Int,Set{Int}}()
	manuals = Vector{Vector{Int}}()
	for line in lines
		m1 = match(r"(\d+)\|(\d+)", line)
		if m1 != nothing
			firstpage = parse(Int, m1.captures[1])
			secondpage = parse(Int, m1.captures[2])
			subsequents = get(rules, firstpage, Set{Int}())
			push!(subsequents, secondpage)
			rules[firstpage] = subsequents
		elseif contains(line, ',')
			manual=[parse(Int,x) for x ∈ split(line, ',')]
			push!(manuals,manual)
		end
	end
	total = 0
	for manual in manuals
		corrected = false
		for i in eachindex(manual)
			firstpage = manual[i]
			for j in i:length(manual)
				secondpage = manual[j]
				if (secondpage ∈ keys(rules)) && (firstpage ∈ rules[secondpage])
					manual[i] = secondpage
					manual[j] = firstpage
					firstpage=secondpage
					corrected = true
				end
			end
		end
		if corrected
			midpage = manual[(length(manual) + 1) ÷ 2]
			total += midpage
		end
	end
	total,manuals
end

# ╔═╡ 8ce94b13-31b2-48ca-87c1-5175011bace9
prob2()[1]

# ╔═╡ Cell order:
# ╠═10df3b2a-b2c7-11ef-33c0-13b2e68252c7
# ╟─c8e929b2-1c98-45a1-b973-bfeb130eecdf
# ╠═5e08f379-df25-4eff-ad53-25d00df4f1ec
# ╠═28f1f299-71ec-4b68-8345-a9a8b3fb5020
# ╟─415440f7-0dac-407e-92d1-f6929182f748
# ╠═8672e664-c27d-48d6-8dd5-52340ce22f51
# ╠═8ce94b13-31b2-48ca-87c1-5175011bace9
