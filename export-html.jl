#!/usr/bin/env julia
import PlutoSliderServer
const files = readdir()
const re = r"^[0-9]{2}\.jl$"
for file in files
    if match(re, file) !== nothing
        print("$file\n")
        PlutoSliderServer.export_notebook(file)
    end
end
