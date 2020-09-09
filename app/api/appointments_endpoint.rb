class AppointmentsEndpoint < Api
  format :json
  default_format :json

  RECURRENCE  = {daily: 'beginning_of_day', weekly: 'beginning_of_week', monthly: 'beginning_of_month'}

  helpers do
    def current_user
      auth_token = request.headers["Token"]
      user = User.find_by(auth_token: request.headers["Token"])
      if user
        user
      else
        error!({message:'Access Denied', error:'401' },nil,nil)
      end
    end
  end

  namespace :appointments do

    desc 'Create a appointment for a patient and doctor'
    post '/create_appointment' do
      # The date format should be given in the below format as there is no UI to select the date and time 
      # The patient and doctor ID is hard coded since there is no UI like a dropdown to select them
      # date time format: '10-02-2020 04:05:06 PM'
      current_user
      # binding.pry
      booking_time = DateTime.strptime(params[:appointment_date], '%m-%d-%Y %I:%M:%S %p') rescue DateTime.now
      patient_appointment = Appointment.new(
        appointment_date: booking_time,
        doctor_id: params[:doctor_id],
        patient_id: params[:patient_id]
      )
      if patient_appointment.save!
        { 
          status: true, 
          appointment_id: patient_appointment.id 
        }
      else
        render errors: patient_appointment.errors.full_messages.join(","), status: 400
      end
    end

    desc 'Get all appointments for all doctors based on the selected date/dates (daily / weekly)'
    get '/all' do
      # current_user
      if params[:recurrence_type] == "weekly"
        # Since there is no UI , i will be hard coding the dates for this week
        # If there is a UI , then we can select the date range and that would populate the start and end date
        start_date       = Date.strptime(@params[:start_date], "%m-%d-%Y") rescue (Date.today)
        end_date         = Date.strptime(@params[:end_date], "%m-%d-%Y") rescue (Date.today+7.days)
        appointments     = Appointment.where(appointment_date: start_date..end_date).sort_by(&:appointment_date)
      else
        # this would be for daily and the appointments for the day would be shown.
        start_time        = DateTime.strptime(@params[:start_date], "%m-%d-%Y") rescue (DateTime.now.beginning_of_day())
        end_time          = DateTime.strptime(@params[:start_date], "%m-%d-%Y") rescue (DateTime.now.end_of_day())
        appointments      = Appointment.where(appointment_date: start_time..end_time).sort_by(&:appointment_date)
      end
      return appointments
    end


  end
end
