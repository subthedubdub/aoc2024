### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ eb832f66-b135-11ef-18fd-addc2124c90b
data = read("03.txt", String)

# ╔═╡ 5555eec6-b01f-4569-a681-804c036e71e4
md"
# Problem 1
"

# ╔═╡ f0b21e17-8b16-4f90-955a-9951187251c2
function prob1()
	tot = 0
	for m  in eachmatch(r"mul\(([0-9]+),([0-9]+)\)", data)
		tot += parse(Int, m.captures[1]) * parse(Int, m.captures[2])
	end
	tot
end

# ╔═╡ 47325d59-7380-4244-ab6f-549844041ad4
prob1()

# ╔═╡ 81ec29c9-c369-455d-bfe2-c45b8f45b767
md"
# Problem2
"

# ╔═╡ 67a5ae0d-6075-4ff3-bb17-314b2f34e816
function prob2()
	tot = 0
	enabled = true
	for m  in eachmatch(r"(don't\(\)|do\(\)|mul\(([0-9]+),([0-9]+)\))", data)
		m.match == "don't()" && (enabled = false)
		m.match == "do()" && (enabled = true)
		if enabled && startswith(m.match, "mul")
			tot += parse(Int, m.captures[2]) * parse(Int, m.captures[3])
		end
	end
	tot
end

# ╔═╡ 908054c3-76b2-4340-b2dd-098034be6b2f
prob2()

# ╔═╡ Cell order:
# ╠═eb832f66-b135-11ef-18fd-addc2124c90b
# ╟─5555eec6-b01f-4569-a681-804c036e71e4
# ╠═f0b21e17-8b16-4f90-955a-9951187251c2
# ╠═47325d59-7380-4244-ab6f-549844041ad4
# ╟─81ec29c9-c369-455d-bfe2-c45b8f45b767
# ╠═67a5ae0d-6075-4ff3-bb17-314b2f34e816
# ╠═908054c3-76b2-4340-b2dd-098034be6b2f
