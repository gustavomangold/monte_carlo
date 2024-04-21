using Random

function flip_spin(array_spins, spin_direction)
	for index in eachindex(array_spins)
		if  (array_spins[index] == spin_direction)     
			array_spins[index] = -spin_direction 
		end
	end
	return array_spins

function run_mc_step(temperature, steps)
	magnetization_init = sum(array_spins)/total_spins
	energy        		 = magnetization_init^2
	
	total_spins_down_init = (total_spins - magnetization_init)/2
	total_spins_up_init   = total_spins - total_spins_down_init 
	
	probability_spin_up   = total_spins_up_init / total_spins
	probability_spin_down = 1 - probability_spin_up
	
	if rand() < probability_spin_up
		energy_variation = (energy - ((sum(array_spins) - 1) / total_spins)^2)
		if energy_variation <= 0  
			array_spins = flip_spin(array_spins, -1)
		end
		else
			if rand() < exp(-energy_variation/temperature)
				array_spins = flip_spin(array_spins, -1)
			end
		end
	end
	
	if rand() < probability_spin_down
		energy_variation = (energy - ((sum(array_spins) - 1) / total_spins)^2)
		if energy_variation <= 0  
			array_spins = flip_spin(array_spins, -1)
		end
		else
			if rand() < exp(-energy_variation/temperature)
				array_spins = flip_spin(array_spins, -1)
			end
		end
	end

total_spins = 10^5

array_spins = zeros(total_spins)
array_spins .+= rand.(((-1 , 1), ))