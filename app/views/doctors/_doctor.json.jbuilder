json.extract! doctor, :id, :name, :sex, :phone, :speciality, :created_at, :updated_at
json.url doctor_url(doctor, format: :json)
