# Julia: DifferentialEquations, Plot functions

"""
Für das Lösen von Differentiagleichungen wird das Package
DifferentialEquations.jl empfohlen (viele Awards gewonnen, outperformed zum Teil 
C/Fortran Code). Deutlich mehr Features als in Matlab.  
‚
Zum Visualisieren gibt es verschiedene packages. Die Zukunft wird wohl Makie.jl
mit den Backends CairoMakie und GLMakie sein (unter anderem gefördert vom
deutschen Bildungs- bzw. Forschungsministerium). 
"""

using CairoMakie
CairoMakie.activate!(type="svg") #Vektorgraphiken als Output (publication quality)

x = range(0., 3π, length = 250)

fig = Figure(resolution = (800, 800), fontsize=24)
ax = Axis(fig[1, 1], title=L"\sigma = 3", ylabel=L"y", xlabel=L"x")
lines!(x, sin.(x))
fig

#Popup-Fenster (matlab like)

using GLMakie
GLMakie.activate!()

fig = Figure(resolution = (800, 800))
ax = Axis(fig[1, 1], title=L"\sigma = 3", ylabel=L"y", xlabel=L"x")
lines!(x, sin.(x))
fig

using CairoMakie
CairoMakie.activate!(type="svg") #Vektorgraphiken als Output (publication quality)

x = range(0., 3π, length = 250)
fig = Figure(resolution = (800, 800), fontsize=24)
ax = Axis(fig[1, 1], title=L"\varphi = 0", ylabel=L"y", xlabel=L"x")
lines!(ax, x, sin.(x), label=L"\sin{x}")
lines!(ax, x, cos.(x), linestyle=:dash, color=:red, linewidth=3, label=L"\cos{x}")
axislegend("Legende", position=:ct)
fig

# Schicke Copy-Paste Vorlagen auf: https://beautiful.makie.org/dev/
x = 0:0.05:4π
fig = Figure(resolution = (600, 400), fonts = (; regular= "CMU Serif")) ## probably you need to install this font in your system
ax = Axis(fig[1, 1], xlabel = L"x", ylabel = L"f (x)", ylabelsize = 22,
    xlabelsize = 22, xgridstyle = :dash, ygridstyle = :dash, xtickalign = 1,
    xticksize = 10, ytickalign = 1, yticksize = 10, xlabelpadding = -10)
lines!(x, x -> sin(3x) / (cos(x) + 2) / x; label = L"\frac{\sin(3x)}{x(\cos(x) + 2)}")
lines!(x, x -> cos(x) / x; label = L"\cos(x)/x")
lines!(x, x -> exp(-x); label = L"e^{-x}")
ylims!(-0.6, 1.05)
xlims!(-0.5, 12)
axislegend(L"f(x)"; position = :rt, bgcolor = (:grey90, 0.25));
fig


# Lasst uns ein wenig tiefer einblicken in den Aufbau einer Figur
x = 0:0.05:4π 
fig = Figure(resolution = (900, 900), )
ax1 = Axis(fig[1, 1])
ax2 = Axis(fig[1, 2])
ax3 = Axis(fig[2, 1:2])
ax4 = Axis3(fig[1:2, 3], aspect=:data)
lines!(ax1, x, sin.(x))
scatter!(ax2, x, cos.(x), markersize=1.5)
heatmap!(ax3, rand(50, 50), colormap = :Spectral_11)
lines!(ax4, sin.(x), cos.(x), x; color = x, linewidth = 4,
    colormap = :Spectral_11)
hidedecorations!(ax4)
fig


x = 0:0.05:4π
fig = Figure(resolution = (600, 800), fonts = (; regular= "CMU Serif")) ## probably you need to install this font in your system
axes = [Axis(fig[i, 1]) for i in 1:3]
functions = [x->sin(3x) / (cos(x) + 2) / x, x->cos(x) / x, x->exp(-x)]
for (idx, ax) in enumerate(axes)
    lines!(ax, x, functions[idx].(x))
    ylims!(ax, -0.6, 1.05)
    xlims!(ax, -0.5, 12)
end
fig