#
# test Dipole1D
#
push!(LOAD_PATH, "your_current_path")
using EM1DUtils
using Test

# transmitter, receiver, frequency
txLoc = zeros(1, 5)
rxLoc = zeros(50, 3)
freqArray = [1.0, 3.0, 10000.0]

txLoc[1, 3] = 900.0

rxLoc[:, 1]  = collect(100:100:5000)
rxLoc[:, 3] .= 1000.0

nTx = size(txLoc, 1)
nRx = size(rxLoc, 1)
nFreq = length(freqArray)

# model parameter
depth1D = collect(800.0:100.0:3000.0)
nLayer  = length(depth1D)
depth1D[1] = -100000
depth1D[2] = 0.0
sigma = ones(nLayer) * 1.0
sigma[1] = 1e-12
sigma[2] = 1/3.3

#
println("Computing 1D response E field...")
ex1d, ey1d, ez1d = comp1DCSEM(txLoc, rxLoc, freqArray, sigma, depth1D)
println("ex1d = ", ex1d[1:5], "ey1d = ", ey1d[1:5], "ez1d = ", ez1d[1:5])

#
println("Computing 1D response E specifically ...")
compFlag = 1
@time exx = comp1DCSEM(txLoc, rxLoc, freqArray, sigma, depth1D, compFlag)
println("exx = ", exx[1:5])
#
println(" Computing 1D response for finite-dipole ...")
dipLen = 100.0
npt = 10
ex = comp1DCSEM(txLoc, rxLoc,dipLen, npt, freqArray, sigma, depth1D, 1)
println("ex = ", ex[1:5])

println("=== All functions in dipole1D passed ===")
