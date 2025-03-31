using Symbolics
using ForwardDiff 

function itConvergence(f, x; tol=1e-6)
    f_x = f(x)
    f_prime = ForwardDiff.derivative(f, x)
    f_double_prime = ForwardDiff.derivative(x -> ForwardDiff.derivative(f, x), x)
    
    # Check convergence condition
    return abs(f_x * f_double_prime) < abs(f_prime)^2
end


function newtonRaphson(f, x0, tol, max_iter, verbose=false)
    x = x0
    i = 0

    for i in 1:max_iter
        fx = f(x)
        fpx = ForwardDiff.derivative(f, x)
        x_next = x - fx / fpx

        if x_next == Inf || x_next == -Inf
            println("Warning: x_next is infinite, returning NaN")
            return NaN
        end

        if abs(x_next - x) < tol
            break
        end

        x = x_next

        if verbose
            println("Iteration $i: x = $x, f(x) = $fx")
        end
    end

    root = round(x,digits=5)
    return root
end

#@variables x
x0::Float32 = 0.4
# f(x) = (-x)^3 - 2 #
# f(x) = x^2 - 4
f(x) = cos(x^2)x

tol::Float32 = 1e-5
max_iter::Int = 20

root_sol = newtonRaphson( f, x0, tol, max_iter )
println("Root = ", root_sol)

# Check convergence
if itConvergence(f, root_sol)
    println("Converged") 
else
    println("Not Converged")
end

# Plot the function with roots
using Plots
x_vals = range(x0-5, x0+5, length=100)
y_vals = f.(x_vals)
plot(x_vals, y_vals, label="f(x)", xlabel="x", ylabel="f(x)", title="Newton-Raphson Method")
scatter!([root_sol], [f(root_sol)], label="Root", color=:red, markersize=5)
plot!(legend=:topright)
# Save the plot
savefig("images/newton_raphson_plot.png")
# Display the plot
display(plot)