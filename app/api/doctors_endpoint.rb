class DoctorsEndpoint < Api
  format :json
  default_format :json

  RECURRENCE  = {daily: 'beginning_of_day', weekly: 'beginning_of_week', monthly: 'beginning_of_month'}

  namespace :doctors do

    get '/all' do
      doc = Doctor.all
      if doc
        { 
          status: true,
          data: doc
        }
      else
        error!({ status: false, message: doc.errors.full_messages.join(',') }, 400)
      end
    end

    desc 'Fetch all the appointments of the respective doctors'
    get '/:id/appointments' do
      @start_date       = Date.strptime(@params[:start_date], "%m-%d-%Y") rescue (Date.today)
      @end_date         = Date.strptime(@params[:end_date], "%m-%d-%Y") rescue (Date.today+30.days)

      recurrence_type   = params[:recurrence_type] || "weekly"
      start_date        = @start_date.send(RECURRENCE[recurrence_type.to_sym])
      end_date          = @end_date.send(RECURRENCE[recurrence_type.to_sym].gsub('beginning', 'end'))

      doctor            = Doctor.find(params[:id])
      appointments      = doctor.appointments.where(appointment_date: start_date..end_date)
      return appointments
      
    end

  end
end
