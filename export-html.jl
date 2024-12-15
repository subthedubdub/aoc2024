#!/usr/bin/env julia
import PlutoSliderServer
const file = ARGS[1];
PlutoSliderServer.export_notebook(file)
