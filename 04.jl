### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 4ad8ab8a-b2c1-11ef-3192-1b6cad8f99df
data = read("04.txt", String)

# ╔═╡ cefc401d-3eff-493c-9670-ff33fc951a0b
md"
# Problem 1
"

# ╔═╡ d37e2dd6-d2c8-4837-a9e9-6e972037a908
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
	# To find number of XMAS, count in each direction
	count = 0
	for i in 1:width
		for j in 1:height
			# forward
			count += (
				matches('X',i,j) && 
				matches('M',i+1,j) &&
				matches('A',i+2,j) &&
				matches('S',i+3,j)
			)
			# backward
			count += (
				matches('X',i,j) && 
				matches('M',i-1,j) &&
				matches('A',i-2,j) &&
				matches('S',i-3,j)
			)
			# down
			count += (
				matches('X',i,j) && 
				matches('M',i,j+1) &&
				matches('A',i,j+2) &&
				matches('S',i,j+3)
			)
			# up
			count += (
				matches('X',i,j) && 
				matches('M',i,j-1) &&
				matches('A',i,j-2) &&
				matches('S',i,j-3)
			)
			# diagonals
			count += (
				matches('X',i,j) && 
				matches('M',i+1,j+1) &&
				matches('A',i+2,j+2) &&
				matches('S',i+3,j+3)
			)
			count += (
				matches('X',i,j) && 
				matches('M',i-1,j+1) &&
				matches('A',i-2,j+2) &&
				matches('S',i-3,j+3)
			)
			count += (
				matches('X',i,j) && 
				matches('M',i+1,j-1) &&
				matches('A',i+2,j-2) &&
				matches('S',i+3,j-3)
			)
			count += (
				matches('X',i,j) && 
				matches('M',i-1,j-1) &&
				matches('A',i-2,j-2) &&
				matches('S',i-3,j-3)
			)
		end
	end
	count	
end

# ╔═╡ 3636f87b-46db-44e6-8ae8-1e9b3736ba2b
prob1()

# ╔═╡ 03d7c736-452c-447f-b766-ca8fe93c48b6
md"
# Problem 2

There are four cases:

```
1:
M S
 A
M S

2:
M M
 A
S S

3:
S S
 A
M M

4:
S M
 A
S M
```"

# ╔═╡ b3a0db1e-c711-45f4-8c7d-13ba8943b468
function prob2()
	width = first(findfirst("\n",data)) - 1
	height = length(data) ÷ (width + 1)
	# find character at column i row j
	charat(i,j) = data[i + (j - 1) * (width + 1)]
	matches(char,i,j)= (
		1<=i<=width && 
		1<=j<=height &&
		charat(i,j)==char
	)
	# To find number of XMAS, count in each direction
	count = 0
	for i in 1:width
		for j in 1:height
			matches('A',i,j) || continue
			# Case 1
			count += (
				matches('M',i-1,j-1) &&
				matches('S',i+1,j-1) &&
				matches('M',i-1,j+1) &&
				matches('S',i+1,j+1)
			)
			# Case 2
			count += (
				matches('M',i-1,j-1) &&
				matches('M',i+1,j-1) &&
				matches('S',i-1,j+1) &&
				matches('S',i+1,j+1)
			)
			# Case 3
			count += (
				matches('S',i-1,j-1) &&
				matches('S',i+1,j-1) &&
				matches('M',i-1,j+1) &&
				matches('M',i+1,j+1)
			)
			# Case 4
			count += (
				matches('S',i-1,j-1) &&
				matches('M',i+1,j-1) &&
				matches('S',i-1,j+1) &&
				matches('M',i+1,j+1)
			)
		end
	end
	count	
end

# ╔═╡ 0693a89f-96db-4ffc-98d3-daae1b7702a1
prob2()

# ╔═╡ Cell order:
# ╠═4ad8ab8a-b2c1-11ef-3192-1b6cad8f99df
# ╟─cefc401d-3eff-493c-9670-ff33fc951a0b
# ╠═d37e2dd6-d2c8-4837-a9e9-6e972037a908
# ╠═3636f87b-46db-44e6-8ae8-1e9b3736ba2b
# ╟─03d7c736-452c-447f-b766-ca8fe93c48b6
# ╠═b3a0db1e-c711-45f4-8c7d-13ba8943b468
# ╠═0693a89f-96db-4ffc-98d3-daae1b7702a1
