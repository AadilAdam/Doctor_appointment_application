class DoctorsEndpoint < Api
  format :json
  default_format :json

  RECURRENCE  = {daily: 'beginning_of_day', weekly: 'beginning_of_week', monthly: 'beginning_of_month'}

  helpers do
    def current_user
      warden = request.env["warden"]
      if warden.user
        warden.user
      else
        error!({message:'Access Denied', error:'401' },nil,nil)
      end
    end
  end

  namespace :doctors do

    get '/all' do
      current_user
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

    desc 'Fetch all the appointments of the respective doctors for the day or the week'
    get '/:id/appointments' do
      current_user
      doctor              = Doctor.find(params[:id])
      if params[:recurrence_type] == "weekly"
        # Since there is no UI , i will be hard coding the dates for this week
        # If there is a UI , then we can select the date range and that would populate the start and end date
        start_date        = Date.strptime(@params[:start_date], "%m-%d-%Y") rescue (Date.today)
        end_date          = Date.strptime(@params[:end_date], "%m-%d-%Y") rescue (Date.today+7.days)
        doc_appointments      = doctor.appointments.where(appointment_date: start_date..end_date).sort_by(&:appointment_date)
      else
        # this would be for daily and the appointments for the day would be shown.
        start_time        = DateTime.strptime(@params[:start_date], "%m-%d-%Y") rescue (DateTime.now.beginning_of_day())
        end_time          = DateTime.strptime(@params[:start_date], "%m-%d-%Y") rescue (DateTime.now.end_of_day())
        doc_appointments  = doctor.appointments.where(appointment_date: start_time..end_time).sort_by(&:appointment_date)
      end
      return doc_appointments
    end

  end
end
