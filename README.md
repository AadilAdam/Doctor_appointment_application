# README

# Doctor Appointment Application

This RAILS API end point application shows simple API endpoints with authenticated user

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

What things you need to install the software and how to install them

```
install homebrew
install rvm
install ruby
clone the repo
```

### Installing

A step by step series of examples that tell you how to get a development env running

Once you have cloned the repo, go to the folder and run

```
bundle
```
Also you need to setup the rails database
```
rails db:migrate
```
And then run

```
rails server
```

## How to setup user using users endpoints

You can run these API endpoints on postman step by step:

1. POST request - url : http://localhost:3000/api/users/registration with the following params in the body
   email - xyz@abcd.com
   password - yourpassword
   
   ### Response
   ```
   {
    "status":true,
    "data":{"id":2,"email":"xyz@abcd.com","first_name":null,"last_name":null},
    "message":"Registration successful",
    "confirmation_url":"https://localhost:3000/api/users/confirm?confirmation_token=-LWEPZOs9eKn2Y4QOC_KYA"
    }
   ```
2. Once the user is registered, please copy the above generated URL on the browser to confirm the registration
    ### Response
    ```
    email confirmed message
    ```
3. Once the user is registered and the email is confirmed, you can login to the application
    POST Request - URL: http://localhost:3000/api/users/login
    email - xyz@abcd.com
    password - yourpassword
    
    ### Response
    ```
    {"status":true,"message":"User signed and confirmed.","data":"R11LCCZNkzh6rHQVOTO8dQ"}
    ```
    
 Once done you can Access these API endpoints mentioned below.
 
### RAILS API ENDPOINTS
1. Fetch all the appointments of a specific doctor for the day and also the week.
    ```
    GET Request URL: http://localhost:3000/api/doctors/:id/appointments
    Replace the id in the URL with one of them to check for appointments [7, 9, 13, 17, .....]
    Also, in the body please pass the following params * recurrence_type = weekly * to see for weekly appointments. Daily is the default params.
    In the request headers, You will have to pass the token u received in the response after login api
      as 
      # Token = your_token
    
    Response:
    [
      {
      "id": 267,
      "appointment_date": "2020-09-09T07:53:09.000Z",
      "doctor_id": 7,
      "patient_id": 108,
      "created_at": "2020-09-07T05:30:53.387Z",
      "updated_at": "2020-09-07T14:51:22.214Z"
      },
      {
      "id": 347,
      "appointment_date": "2020-09-09T11:07:44.000Z",
      "doctor_id": 7,
      "patient_id": 137,
      "created_at": "2020-09-07T05:30:54.348Z",
      "updated_at": "2020-09-07T14:51:22.563Z"
      }
     ]
     ```
 2. To Fetch all the appointments for all the doctors for the day or the week, 
    
    ```
    GET Request URL: http://localhost:3000/api/appointments/all
    
    In the body, please pass the following params * recurrence_type = weekly * to see for weekly appointments. Daily is the default params.
    In the request headers, You will have to pass the token u received in the response after login api
      as 
      # Token = your_token
    
    Response: (this is the default response for the current day )
    [
      {
      "id": 267,
      "appointment_date": "2020-09-09T07:53:09.000Z",
      "doctor_id": 7,
      "patient_id": 108,
      "created_at": "2020-09-07T05:30:53.387Z",
      "updated_at": "2020-09-07T14:51:22.214Z"
      },
      {
      "id": 893,
      "appointment_date": "2020-09-09T09:36:19.000Z",
      "doctor_id": 13,
      "patient_id": 350,
      "created_at": "2020-09-07T05:31:02.504Z",
      "updated_at": "2020-09-07T14:51:25.263Z"
      },
      {
      "id": 1015,
      "appointment_date": "2020-09-09T09:37:01.000Z",
      "doctor_id": 17,
      "patient_id": 399,
      "created_at": "2020-09-07T05:31:04.797Z",
      "updated_at": "2020-09-07T14:51:25.816Z"
      }...
     ]
    
    ```
    
  3. Rails API endpoint to create an appointment, 
      Please follow the steps in postman and also pass the necessary params
      Since there is NO UI , You will have to pass the patient id and doctor id on your own.
      Ex: 
      ```
      POST Request URL: http://localhost:3000/api/appointments/create_appointment
      params in the body: 
              doctor_id: [1, 2, 3, 4,....]
              patient_id: [1,2,3,4,5,6,....]
              appointment_date: 10-02-2020 04:05:06 PM ( should be of this format)
             
             
       In the request headers, You will have to pass the token u received in the response after login api
            as 
            # Token = your_token
              
       Response:
       {"status":true,"appointment_id":1936}
       
       ```
  
## Built With

* Rails framework



