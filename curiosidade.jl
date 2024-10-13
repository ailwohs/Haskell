include("building_blocks.jl")
include("../src/physics.jl")

# Run experiments in parallel in order to compare behaviour
function run_experiment(contraptions, settings_list; 
                        Δt::Float64 = 0.01, t_total::Float64 = 10)

    @assert(length(contraptions) == length(settings_list))
    n = length(contraptions)

    results = Array()
    for i in 1:n
        outcome = engine(contraptions[i], settings_list[i], Δt, t_total)
        push!(results, outcome)
    end

    return results
end

# Physics behaviour tests ####

# Contraptions should not accelerate in absence of external forces
function newton_first_law_test(contraption)
    results = run_experiment([contraption],
                             [null_settings])
    return false
end

@test newton_first_law_test(one_contraption)
@test newton_first_law_test(two_contraption)
@test newton_first_law_test(slow_contraption)

# Springs should pull points together when they're stretched
function stretch_test()
    results = run_experiment([stretch_contraption],
                             [null_settings],
                             t_total = 1.)

    return false
end

@test stretch_test()

# Springs should push points away when they're compressed
function compression_test()
    results = run_experiment([squash_contraption],
                             [null_settings],
                             t_total = 1.)
    return false
end 

@test compression_test()

# Contraptions should fall when there's gravity
function falling_test(contraption)
    results = run_experiment([contraption],
                             [default_settings],
                             t_total = 1.)

    return false
end

@test falling_test(one_contraption)
@test falling_test(two_contraption)
@test falling_test(three_contraption)

# Contraptions should fall faster in more gravity
function gravity_falling_test(contraption)
    results = run_experiment([contraption for _ in 1:5],
                             [antigrav_settings,
                              nograv_settings,
                              lowgrav_settings,
                              default_settings,
                              higrav_settings],
                             t_total = 1.)

    return false
end

@test gravity_falling_test(one_contraption)
@test gravity_falling_test(three_contraption)

# Contraptions should fall slower with more drag
function drag_falling_test()
    results = run_experiment([contraption for _ in 1:4],
                             [nodrag_settings,
                              lowdrag_settings,
                              default_settings,
                              hidrag_settings],
                             t_total = 1.)
    return false
end

@test drag_falling_test(one_contraption)
@test drag_falling_test(three_contraption)

# Contraptions should oscillate at about the same speed regardless of initial compression or extension
function oscillation_direction_test()
    results = run_experiment([stretch_contraption, squash_contraption],
                             [null_settings, null_settings])

    return false
end

@test oscillation_direction_test()

# Contraptions should oscillate at about the same speed regardless of drag
function oscillation_drag_test()
    results = run_experiment([stretch_contraption for _ in 1:4],
                             [nodrag_settings,
                              lowdrag_settings,
                              default_settings,
                              hidrag_settings])
    return false
end

@test oscillation_drag_test()

# Contraptions should have dampened oscillations, with faster damping in more drag
function oscillation_damping_test()
    results = run_experiment([stretch_contraption for _ in 1:4],
                             [nodrag_settings,
                              lowdrag_settings,
                              default_settings,
                              hidrag_settings])
    return false
end 

@test oscillation_damping_test()

# Contraptions should bounce
function bounce_test(contraption)
    results = run_experiment([contraption],
                             [default_settings])

    return false
end

@test bounce_test(one_contraption)
@test bounce_test(two_contraption)
@test bounce_test(three_contraption)
@test bounce_test(seven_contraption)


# Contraptions should bounce higher with more elasticity
function elasticity_bounce_test()
    results = run_experiment([contraption for _ in 1:5],
                             [inelastic_settings,
                              lowelastic_settings,
                              default_settings,
                              hielastic_settings,
                              elastic_settings])
    return false
end

@test elasticity_bounce_test(one_contraption)
@test elasticity_bounce_test(two_contraption)
@test elasticity_bounce_test(three_contraption)
@test elasticity_bounce_test(seven_contraption)
@test elasticity_bounce_test(pogo_contraption)

# Energy should be conserved in the absence of drag or inelasticity
function energy_conservation_test(contraption)
    results = run_experiment([contraption],
                             [noloss_settings])

    return false
end

@test energy_conservation_test(one_contraption)
@test energy_conservation_test(seven_contraption)
@test energy_conservation_test(fast_contraption)
@test energy_conservation_test(strong_contraption)

# Contraptions should eventually come to rest
function come_to_rest_test(contraption)
    results = run_experiment([contraption],
                             [default_settings])
    return false
end

@test come_to_rest_test(one_contraption)
@test come_to_rest_test(two_contraption)
@test come_to_rest_test(three_contraption)

# Contraptions should spin after bouncing iff they're off-centre
function spin_test()
    results = run_experiment([seven_contraption, rotated],
                             [default_settings, default_settings])

    return false
end

@test spin_test()

# Larger contraptions should hit the ground sooner
function large_collision_test()
    results = run_experiment([small_contraption, 
                              seven_contraption, 
                              large_contraption],
                             [default_settings,
                              default_settings,
                              default_settings])
    return false
end

@test large_collision_test()

# Contraptions should take longer to hit the wall in larger environments
function large_env_test()
    results = run_experiment([seven_contraption, 
                              seven_contraption, 
                              seven_contraption],
                             [small_settings,
                              default_settings,
                              large_settings])

    return false
end

@test large_env_test()

# Larger contraptions should rest at a higher point
function large_rest_test()
    results = run_experiment([small_contraption, 
                              seven_contraption, 
                              large_contraption],
                             [default_settings,
                              default_settings,
                              default_settings])

    return false
end

@test large_rest_test()

# Light contraptions should rest at a higher point
function heavy_rest_test()
    results = run_experiment([light_contraption, 
                              seven_contraption, 
                              heavy_contraption],
                             [default_settings,
                              default_settings,
                              default_settings])

    return false
end

@test heavy_rest_test()

# Strong contraptions should rest at a higher point
function strong_rest_test()
    results = run_experiment([weak_contraption, 
                              seven_contraption, 
                              strong_contraption],
                             [default_settings,
                              default_settings,
                              default_settings])

    return false
end

@test heavy_rest_test()

# Fast contraptions should be approximately uniformly distributed over the bounding box at random times
function fast_distribution_test()
    results = run_experiment([fast_contraption],
                             [null_settings])

    return false
end

@test fast_distribution_test()

include("../src/structs.jl")
include("../src/construction.jl")

# Basic contraptions
global one_contraption = Contraption(reshape([0.; 0.], (2,1)),
                                              reshape([0.; 0.], (2,1)),
                                              [1.],
                                              100. * reshape([0.], (1,1)))

global two_contraption = Contraption([1. -1.; 1. -1.],
                                     [0. 0.; 0. 0.],
                                     [1., 1.],
                                     100. * [0. 1.; 1. 0.])

global three_contraption = Contraption([-1. 0. 1.; -1. 0. -1.],
                                       [0. 0. 0.; 0. 0. 0.],
                                       [1., 1., 1.],
                                       100. * [0. 1. 1.; 1. 0. 1.; 1. 1. 0.])

global seven_contraption = Contraption(regular_polygon(7),
                                       zeros(2, 7),
                                       ones(7),
                                       100. * complete_graph(7))

global hundred_contraption = Contraption(regular_polygon(100),
                                         zeros(2, 100),
                                         ones(100),
                                         100. * complete_graph(100))

global thousand_contraption = Contraption(regular_polygon(1000),
                                          zeros(2, 1000),
                                          ones(1000),
                                          100. * complete_graph(1000))

global pogo_contraption = Contraption([0. 0.; 1. -1.],
                                      [0. 0.; 0. 0.],
                                      [1., 1.],
                                      100. * [0. 1.; 1. 0.])

global stretch_contraption = Contraption([1. -1.; 0. 0.],
                                         [1. -1.; 0. 0.],
                                         [1., 1.],
                                         100. * [0. 1.; 1. 0.])

global squash_contraption = Contraption([1. -1.; 0. 0.],
                                        [-1. 1.; 0. 0.],
                                        [1., 1.],
                                        100. * [0. 1.; 1. 0.])

global small_contraption = Contraption(regular_polygon(7, radius = 0.5),
                                       zeros(2, 7),
                                       ones(7),
                                       100. * complete_graph(7))

global large_contraption = Contraption(regular_polygon(7, radius = 2.),
                                       zeros(2, 7),
                                       ones(7),
                                       100. * complete_graph(7))

global rotated_contraption = Contraption(regular_polygon(7, θ_0 = 1.),
                                         zeros(2, 7),
                                         ones(7),
                                         100. * complete_graph(7))

global light_contraption = Contraption(regular_polygon(7),
                                       zeros(2, 7),
                                       0.1 * ones(7),
                                       100. * complete_graph(7))

global heavy_contraption = Contraption(regular_polygon(7),
                                       zeros(2, 7),
                                       100. * ones(7),
                                       100. * complete_graph(7))

global weak_contraption = Contraption(regular_polygon(7),
                                      zeros(2, 7),
                                      ones(7),
                                      10. * complete_graph(7))

global strong_contraption = Contraption(regular_polygon(7),
                                        zeros(2, 7),
                                        ones(7),
                                        1000. * complete_graph(7))

global slow_contraption = Contraption(regular_polygon(7),
                                      0.01 * ones(2, 7),
                                      ones(7),
                                      100. * complete_graph(7))

global fast_contraption = Contraption(regular_polygon(7),
                                      1000. * ones(2, 7),
                                      ones(7),
                                      100. * complete_graph(7))

global detached_contraption = Contraption(regular_polygon(7),
                                          zeros(2, 7),
                                          ones(7),
                                          zeros(7, 7))

global loop_contraption = Contraption(regular_polygon(17),
                                      zeros(2, 17), 
                                      ones(17),
                                      3000*loop_graph(17, [1,2,4]))                                          

# Basic physics settings
global default_settings = PhysicsSettings()

global antigrav_settings = PhysicsSettings(g = -10.)
global nograv_settings = PhysicsSettings(g = 0.)
global lowgrav_settings = PhysicsSettings(g = 1)
global higrav_settings = PhysicsSettings(g = 100.)

global nodrag_settings = PhysicsSettings(drag = 0.)
global lowdrag_settings = PhysicsSettings(drag = 0.01)
global hidrag_settings = PhysicsSettings(drag = 1.)

global inelastic_settings = PhysicsSettings(elasticity = 0.)
global lowelastic_settings = PhysicsSettings(elasticity = 0.2)
global hielastic_settings = PhysicsSettings(elasticity = 0.8)
global elastic_settings = PhysicsSettings(elasticity = 1.)

global null_settings = PhysicsSettings(g = 0., drag = 0., elasticity = 1.)
global noloss_settings = PhysicsSettings(drag = 0., elasticity = 1.)

global small_settings = PhysicsSettings(bounds = Bounds((-2.5, 2.5), (-2.5, 2.5)))

global large_settings = PhysicsSettings(bounds = Bounds((-10., 10.), (-10., 10.)))

include("physics.jl")

function centre_of_mass(contraption::Contraption)
    CoM = (0, 0)

    for i in eachindex(contraption.mass)
        CoM += contraption.mass[i]  * contraption.position[:, i]
    end

    CoM /= sum(contraption.mass)

    return CoM 
end

function moment_of_inertia(contraption::Contraption)
    CoM = centre_of_mass(contraption)
    I = 0

    for i in eachindex(contraption.mass)
        r = Distances.norm(contraption.position[:, i] - CoM)
        I += contraption.mass[i] * r^2
    end

    return I
end

function momentum(contraption::Contraption)
    momentum = (0, 0)
    
    for i in eachindex(contraption.mass)
        momentum += contraption.velocity[:, i] * contraption.mass[i] 
    end

    return momentum
end

# FIXME: requires 3D coordinates everywhere in order to work
function angular_momentum(contraption::Contraption)
    CoM = centre_of_mass(contraption)
    L = (0, 0, 0)

    for i in eachindex(contraption.mass)
        r = contraption.position[:, i] - CoM
        p = contraption.velocity[:, i] * contraption.mass[i]
        L += Base.LinAlg.cross(r, p)
    end

    return L
end

# Computes average angular velocity derived from angular momentum and moment of inertia
function angular_velocity(contraption::Contraption)
    ω = angular_momentum(contraption) / moment_of_inertia(contraption)

    return ω
end

function kinetic_energy(contraption::Contraption)
    E = 0

    for i in eachindex(contraption.mass)
        E += 0.5 * contraption.mass[i] * contraption.velocity[:, i] ^ 2   
    end

    return E
end

function elastic_energy(contraption::Contraption)
    E = 0
    
    for i in eachindex(contraption.springs)
        if contraption.springs != 0    
            Δs = Distances.norm(contraption.position[:, i[1]] - contraption.position[:, i[2]])

            E += 0.5 * contraption.springs[i] * Δs ^ 2
        end
    end

    return E
end

# Gravitational potential energy, computed relative to y = 0
function gravitational_energy(contraption::Contraption, g::Float64)

    E = 0
    for i in eachindex(contraption.mass)
        E += contraption.mass[i] * g * contraption.position[2, i]
    end

    return E
end

function total_energy(contraption::Contraption)

    E = sum(kinetic_energy(contraption),
            elastic_energy(contraption),
            gravitational_energy(contraption))

    return E
end

function detect_collision(velocity_series)

end

function detect_rest(velocity_series)

end

function detect_oscillation(velocity_series)

end

# Point mass configuration ####
function regular_polygon(n; radius = 1, θ_0 = 0., center=[0., 0.])
    function create_point(i)
        θ = 2*π*i/n
        point = [center[1] + radius*cos(θ + θ_0), 
                 center[2] + radius*sin(θ + θ_0)]
        return point
    end
    
    points = Array{Float64,2}(undef, 2, n)
    for i in 1:n
        points[1, i], points[2, i] = create_point(i)
    end
    
    return points
end

# Spring configuration ####
function complete_graph(n)
    graph = ones(Float64, n, n)

    for i in 1:n
        graph[i, i] = 0.
    end

    return graph
end

function loop_graph(n, connections = [1,])
    graph = zeros(Float64, n, n)

    # Ensure that neighbours that are i away in other direction are connected
    complementary_connections = [n - i for i in connections]
    append!(connections, complementary_connections)

    for i in 1:n, j in (i+1):n
        if (j - i) ∈ connections
            graph[i, j], graph[j, i] = 1., 1.
        end
    end

    return graph
end
