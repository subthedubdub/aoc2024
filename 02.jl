### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 7b2b6006-b0d8-11ef-26c0-dda1da1bf39f
const data = readlines("02.txt")

# ╔═╡ 7d80d3ae-f478-46ab-af9d-05093931a57f
first(data)

# ╔═╡ 0a13b0de-e97f-4bcf-a60b-c4b57d62b6ea


# ╔═╡ 43ef60c0-0a06-494c-9135-03d22cfc747a
md"
# Problem 1
"

# ╔═╡ 9333af1c-65e4-456c-9b13-f176bcc12c11
function prob1()
	num_safe = 0
	for line in data
		levels = [parse(Int, i) for i in split(line)]
		diffs = diff(levels)
		any(abs(d) < 1 || abs(d) > 3 for d in diffs) && continue
		!(all(d > 0 for d in diffs) || all(d < 0 for d in diffs)) && continue
		num_safe += 1
	end
	num_safe
end

# ╔═╡ 9b50354d-2a33-42c0-a001-79551d379013
prob1()

# ╔═╡ 3ad850db-8e4e-4f8d-be42-e3ba7b6dc418
md"
# Problem 2

Here the logic in `prob1()` was factored into an inner function `issafe(levels)`. And I brute-forced it.
"

# ╔═╡ d914f69d-406e-43f9-b5d0-7a7f2b59356b
function prob2()
	function issafe(levels)
		diffs = diff(levels)
		any(abs(d) < 1 || abs(d) > 3 for d in diffs) && return false
		!(all(d > 0 for d in diffs) || all(d < 0 for d in diffs)) && return false
		return true
	end
	num_safe = 0
	for line in data
		levels = [parse(Int, i) for i in split(line)]
		if issafe(levels)
			num_safe += 1
			continue
		end
		for i in eachindex(levels)
			if issafe(deleteat!(copy(levels), i))
				num_safe += 1
				break
			end
		end
	end
	num_safe 
end

# ╔═╡ 3b7126dc-264f-45a6-a5c8-098269068ca3
prob2()

# ╔═╡ Cell order:
# ╠═7b2b6006-b0d8-11ef-26c0-dda1da1bf39f
# ╠═7d80d3ae-f478-46ab-af9d-05093931a57f
# ╠═0a13b0de-e97f-4bcf-a60b-c4b57d62b6ea
# ╟─43ef60c0-0a06-494c-9135-03d22cfc747a
# ╠═9333af1c-65e4-456c-9b13-f176bcc12c11
# ╠═9b50354d-2a33-42c0-a001-79551d379013
# ╟─3ad850db-8e4e-4f8d-be42-e3ba7b6dc418
# ╠═d914f69d-406e-43f9-b5d0-7a7f2b59356b
# ╠═3b7126dc-264f-45a6-a5c8-098269068ca3
