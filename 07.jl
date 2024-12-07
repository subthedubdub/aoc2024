### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# ╔═╡ 68bf7cd5-62e2-44be-99f7-372deccc0345
const data = read("07.txt", String)

# ╔═╡ c155de84-b458-11ef-0329-a51dcacef6b0
md"# Problem 1
In this case, we use a recursive function `isreachable` to see if it is possible to produce a result from the given sequence of operands.
"

# ╔═╡ 012638aa-78ef-4e4e-adfa-0c01340cc951
begin
	function isreachable(result, operands)
		length(operands) == 1 && return operands[1] == result
    	last_operand = operands[end]
    	remaining_operands = operands[1:end-1]
	    return (
			# addition
			(
				result-last_operand >= 0 
				&& 
				isreachable(result - last_operand, remaining_operands)
			) ||
			# multiplication
			(
				result % last_operand == 0
				&&
				isreachable(result ÷ last_operand, remaining_operands)
			)
		)
	end
	function prob1(data)
	    lines = split(data, '\n')
	    total = 0
	
	    for line in lines
	        m = match(r"^(\d+): ([0-9 ]+)$", line)
	        if m === nothing
	            continue
	        end
	
	        result = parse(Int, m.captures[1])
	        operands = [parse(Int, x) for x in split(m.captures[2])]
	
	        if isreachable(result, operands)
	            total += result
	        end
	    end
	    return total
	end
end

# ╔═╡ f596e159-5fb8-43ec-8a0b-15f434cc24fe
prob1(data)

# ╔═╡ 7d9779da-f8d9-412f-9e3f-5f20adbe6283
md"# Problem 2"

# ╔═╡ bec64e93-2c95-45b6-9811-927fbd01b3d3
begin
	function isreachable2(result, operands)
		length(operands) == 1 && return operands[1] == result
    	last_operand = operands[end]
		string(result)
		string(last_operand)
		endswith(string(result), string(last_operand))
    	remaining_operands = operands[1:end-1]
	    return (
			# addition
			(
				result-last_operand >= 0 
				&& 
				isreachable2(result - last_operand, remaining_operands)
			) ||
			# multiplication
			(
				result % last_operand == 0
				&&
				isreachable2(result ÷ last_operand, remaining_operands)
			) ||
			# concatenation
			(
				endswith(string(result), string(last_operand))
				&&
				result != last_operand
				&&
				isreachable2(
					parse(Int,string(result)[1:end-length(string(last_operand))]), remaining_operands
				)
			)
		)
	end
	function prob2(data)
	    lines = split(data, '\n')
	    total = 0
	
	    for line in lines
	        m = match(r"^(\d+): ([0-9 ]+)$", line)
	        if m === nothing
	            continue
	        end
	
	        result = parse(Int, m.captures[1])
	        operands = [parse(Int, x) for x in split(m.captures[2])]
	
	        if isreachable2(result, operands)
	            total += result
	        end
	    end
	    return total
	end
end

# ╔═╡ a7a12154-f7a2-4f21-b1d0-26eeb2497fe1
prob2(data)

# ╔═╡ Cell order:
# ╠═68bf7cd5-62e2-44be-99f7-372deccc0345
# ╟─c155de84-b458-11ef-0329-a51dcacef6b0
# ╠═f596e159-5fb8-43ec-8a0b-15f434cc24fe
# ╠═012638aa-78ef-4e4e-adfa-0c01340cc951
# ╟─7d9779da-f8d9-412f-9e3f-5f20adbe6283
# ╠═a7a12154-f7a2-4f21-b1d0-26eeb2497fe1
# ╠═bec64e93-2c95-45b6-9811-927fbd01b3d3
