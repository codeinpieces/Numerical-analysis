function iter_point_fixed( f::Function, x_0::Float32, e::Float32, max_iter::Int=100 )
    # This function realize an iteration to find fixed points of f(x) = 0
    # Params:
    # - f: Function
    # - x_0: Initial Value
    # - e: Error threshold
    error::Float32 = Inf
    x_n::Float32 = x_0
    iter::Int = 0

    while (error > e) && (iter < max_iter)
        x_next::Float32 = f(x_n)
        error = abs(x_next - x_n)
        x_n = x_next
        iter += 1
    end

    # Logs
    if iter == max_iter
        println("[Warning]: MAX iters reached: ", iter)
    else
        println("Iters: ", iter)
    end
    println("Error: ", error)
    println("Fixed Point:", x_n)

    return x_n
end

f(x) = sqrt(7x - 2)
x0::Float32 = 4.0f0
e::Float32 = 1e-5

x_sol = iter_point_fixed( f, x0, e )
