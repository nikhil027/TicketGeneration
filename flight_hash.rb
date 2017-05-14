require 'date'
def generate_booking_id

		arr1 = ('A'..'Z').to_a

		arr2 = ('0'..'9').to_a+('A'..'Z').to_a

		exceptions=['SELFIE','BARNEY','RACHEL','MONICA','ETHIAD','AMAZON']

		sample1=arr1.shuffle.first(3).join

		while(sample1=='EKA')
			sample1=arr1.shuffle.first(3).join
		end	

		sample2=arr2.shuffle.first(3).join

		generated_booking_id=sample1+sample2

		unless (exceptions.include?(generated_booking_id))
			return(generated_booking_id)
		else
			generate_booking_id	
		end	
			

end	
	

booking_hash={}

flag='y'
while(flag=='y')
	puts '1.Book Ticket'
	puts '2.Cancel Ticket'
	puts '3.Check Number of tickets booked'
	puts '4.Exit'
	input=gets.chomp.to_i
	if (input==1)
		puts "Enter travel date in 'YYYY-MM-DD' format"
		date_input=Date.parse(gets.chomp)	
		booking_id=generate_booking_id
		if booking_hash.keys.include?(booking_id)
			if (booking_hash[booking_id][1]==true and abs(booking_hash[booking_id][0]-Date.today)>90) or 
				(booking_hash[booking_id][1]==false and abs(booking_hash[booking_id][0]-Date.today)>730)
				booking_hash[booking_id][0]= date_input
				booking_hash[booking_id][1]= false
			else
				input=1			
			end
		else
			booking_hash[booking_id]=[]
			booking_hash[booking_id][0]=date_input
			booking_hash[booking_id][1]=false	
		end

		booking_hash.each do|booking_id,value|
			puts "BookingID is #{booking_id} bookingdate is #{value[0]} cancellationstatus - #{value[1]} "
		end

	elsif(input==2)
		booking_hash.each do|booking_id,value|
			puts "BookingID is #{booking_id} bookingdate is #{value[0]} "
		end
		puts 'Enter your bookingid to cancel'
		bid=gets.chomp	
		booking_hash[bid][1]=true	
		puts "#{bid}--#{booking_hash[bid][0]}--#{booking_hash[bid][1]}"

	elsif(input==3)
		puts "The number of tickets booked are: #{booking_hash.length}"	
		puts "The no of tickets that can be generated are #{18564000-booking_hash.length}"
		
	elsif(input==4)
		flag='n'
	end	
end

			