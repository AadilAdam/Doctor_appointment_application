# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Examples:

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

specialities = ["Allergy & Immunology", "Anesthesiology", "Dermatology", "Diagnostic Radiology", "Emergency Medicine", 
	"Family Medicine", "Internal Medicine", "Medical Genetics"]

sex = ["Male", "Female"]


# 30.times do
#   doctor = Doctor.create(
#     name: Faker::Name.name,
#     sex: sex.sample,
#     phone: Faker::PhoneNumber.cell_phone,
#     speciality: specialities.sample
#   )
#   rand(2...50).times do 
#     patient = Patient.create(
#       first_name: Faker::Name.first_name,
#       last_name: Faker::Name.last_name,
#       age: nil,
#       dob: Faker::Date.birthday(min_age: 18, max_age: 70),
#       sex: sex.sample,
#       phone: Faker::PhoneNumber.cell_phone,
#       address: Faker::Address.full_address
#     )
#     rand(1...5).times do
#       Appointment.create(
#         date: Faker::Date.forward(60).to_date,
#         time: Faker::Time.forward(2, :morning),
#         doctor_id: doctor.id,
#         patient_id: patient.id
#       )
#     end
#   end
# end

# @patients = Patient.all
# @patients.each do |p|
#     age = (Time.current.year - p.dob.year)
#     p.update(age: age)
# end
