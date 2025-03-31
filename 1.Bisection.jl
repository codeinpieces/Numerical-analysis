function bisection( f::Function, tol::Float32, a::Int16,b::Int16, max_iter::Int = 100 )
    # Calculates numerically the roots of a function in an interval I ∈ [a,b]

    if f(a)*f(b) > 0
        println("Error, this method requires [a,b] to had different sign")
        return NaN
    end

    # Initial values
    iter::Int16 = 0
    c::Float16 = (b + a) / 2
    fc::Float32 = f(c)
    determinant::Float32 = f(a)*fc

    while (iter < max_iter)

        if (fc == 0) || (abs(b - a) < tol)
            println("Root = ", c)
            return fc
        elseif determinant > 0
            a = c
        else
            b = c
        end

        c = (b + a) / 2
        fc = f(c)
        determinant = f(a)*f(c)

        iter += 1
    end
    println("Max iters reached: ", iter)
    println("Root = ", c)
    return c
end

f(x) = (-x)^3 - 2
tol::Float32 = 1e-5
a::Int16 = -2
b::Int16 = 1

x_sol = bisection( f, tol, a, b )
