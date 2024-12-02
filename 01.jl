### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 301c75c7-159d-41b6-a4d8-73ea6152d82c
const data = read("01.txt", String)

# ╔═╡ 498288f0-b01e-11ef-1f91-c9a871c3459f
md"
# Problem 1
In this problem, we have to sort two columns of numbers and find their pairwise distances.
"

# ╔═╡ 99b0d9de-dfce-4f3e-9836-bc72930e2b5e
function prob1()
	lines = split(data, '\n')
	pop!(lines) # last line is blank
	col1 = [parse(Int, first(split(l))) for l in lines]
	col2 = [parse(Int, last(split(l))) for l in lines]
	sort!(col1)
	sort!(col2)
	col1, col2
	absdiff(x,y)=abs(x-y)
	sum(absdiff.(col1,col2))
end

# ╔═╡ 0b61723f-7bf6-464f-a077-ac946d4bdb67
prob1()

# ╔═╡ 5ffd27cf-92d3-43a6-b5ee-eaa3b76f11e0
md"
# Problem 2
In the follow-up we can use a frequency table.
"

# ╔═╡ 9df9801e-e0ff-492b-a7aa-deb23025b206
function prob2()
	lines = split(data, '\n')
	pop!(lines) # last line is blank
	col1 = [parse(Int, first(split(l))) for l in lines]
	col2 = [parse(Int, last(split(l))) for l in lines]
	freq = Dict{Int,Int}()
	for num in col2
		freq[num] = 1 + get(freq, num, 0)
	end
	sum(c * get(freq, c, 0) for c in col1)
end

# ╔═╡ 4d80ae2c-6d7e-477d-8627-925ccc60c4f3
prob2()

# ╔═╡ Cell order:
# ╠═301c75c7-159d-41b6-a4d8-73ea6152d82c
# ╟─498288f0-b01e-11ef-1f91-c9a871c3459f
# ╠═99b0d9de-dfce-4f3e-9836-bc72930e2b5e
# ╠═0b61723f-7bf6-464f-a077-ac946d4bdb67
# ╟─5ffd27cf-92d3-43a6-b5ee-eaa3b76f11e0
# ╠═9df9801e-e0ff-492b-a7aa-deb23025b206
# ╠═4d80ae2c-6d7e-477d-8627-925ccc60c4f3
