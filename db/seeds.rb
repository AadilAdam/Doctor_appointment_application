# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Examples:

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

specialities = ["Allergy & Immunology", "Anesthesiology", "Dermatology", "Diagnostic Radiology", "Emergency Medicine", 
	"Family Medicine", "Internal Medicine", "Medical Genetics"]

sex = ["Male", "Female"]


30.times do
  doctor = Doctor.create(
    name: Faker::Name.name,
    sex: sex.sample,
    phone: Faker::PhoneNumber.cell_phone,
    speciality: specialities.sample
  )
  rand(2...50).times do 
    patient = Patient.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      age: nil,
      dob: Faker::Date.birthday(min_age: 18, max_age: 70),
      sex: sex.sample,
      phone: Faker::PhoneNumber.cell_phone,
      address: Faker::Address.full_address
    )
    rand(1...5).times do
      Appointment.create(
        time: Faker::Time.between_dates(from: Date.today - 15, to: Date.today + 120, period: :afternoon, format: :default),
        doctor_id: doctor.id,
        patient_id: patient.id
      )
    end
  end
end

@patients = Patient.all
@patients.each do |p|
    age = (Time.current.year - p.dob.year)
    p.update(age: age)
end

# @appointments = Appointment.all
# @appointments.each do |a|
# 	new_time = Faker::Time.between_dates(from: Date.today - 15, to: Date.today + 120, period: :afternoon, format: :default)
# 	a.update(appointment_date: new_time)
# 	a.save!
# end
