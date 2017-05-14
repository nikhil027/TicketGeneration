require 'date'
class Booking

	@@bookings=[]

	# getter and setter 
	attr_accessor :booking_id, :booking_date, :cancellation_status

	
	def initialize(booking_date)
		@booking_id= nil
		@booking_date= booking_date
		@cancellation_status= false #default false
	end

	#Instance Method to generate booking id.
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
		puts generated_booking_id

		unless exceptions.include?(generated_booking_id)
			@@bookings.each do |booking|
				if booking.booking_id==generated_booking_id
					if (booking.cancellation_status==true and abs(booking.booking_date-Date.today)>90) or 
						(booking.cancellationstatus==false and abs(booking.booking_date-Date.today)>730)
						@booking_id= generated_booking_id
						@cancellation_status=false
						break
					else
						generate_booking_id			
					end
				end
			end
			@booking_id=generated_booking_id
		else
			generate_booking_id
		end		
			
	end

	#Class Method to add objects to the list
	def add_to_list
		@@bookings.push(self)
	end	

	#Class method to cancel the required ticket
	def self.cancel_ticket(bid)
		@@bookings.each do|booking|
			if booking.booking_id==bid
				booking.cancellation_status=true
			end	
		end		

	end	

	#Class Method to get the count of tickets generated
	def self.get_ticket_count
		return @@bookings.length
	end	

	#Class Method to display booking details
	def self.details
		puts "BookingId   BookingDate   cancellationstatus"
		@@bookings.each do|booking|
			puts "#{booking.booking_id} - #{booking.booking_date} - #{booking.cancellation_status}"
		end	
	end		


end	

#Main Program
flag='y'
while(flag=='y')
	puts("\n *** Ticket Booking System *** \n")
	puts '1.Book Ticket'
	puts '2.Cancel Ticket'
	puts '3.Check Number of tickets booked and no of tickets that can be generated'
	puts '4.Exit'
	input=gets.chomp.to_i
	if(input==1)
		puts "Enter the date of travel in 'YYYY-MM-DD' form."
		booking_date_input=Date.parse(gets.chomp)
		booking=Booking.new(booking_date_input)
		booking.generate_booking_id
		booking.add_to_list
		Booking.details
	elsif(input==2)
		puts 'Enter BookingID'
		bid=gets.chomp
		Booking.cancel_ticket(bid)
		Booking.details
	elsif(input==3)
		puts "The no of tickets booked are #{Booking.get_ticket_count}"	
		# Max no of tickets calculated using nCr formula 2600*7140=18564000
		puts "The no of tickets that can be generated are #{18564000-Booking.get_ticket_count}"
	elsif(input==4)
		flag='n'	
	end
end