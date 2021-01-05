# README

## Table of Contents

- [Get User Notifications](#get-user-notifications)
- [Update user notification](#update-user-notification)
- [Get Notifications](#get-notifications)
- [Create notification](#create-notification)
- [Get Users](#get-users)
- [Login](#login)


# Get User Notifications

All users can see their own notification, up to the present, in decreasing date order

## Request

### Method

`GET`

### Path

`/api/v1/user_notifications`

**Query Parameters**

| Param                  | Type     | Description                                                                                             |
|------------------------|----------|------------------------------------------------- |
| include                | String   | Optional parameter that can be "notification"    |

### Headers

| Name          | Value                    |
| ------------  | ------------------------ |
| Authorization | Bearer #{token}          |

## Response

### Statuses

| Status | Name   | Type  | Description                                              |
| ------ | ------ | ----- | -------------------------------------------------------- |
| 200    | data   | Array | A list containing all notifications for the current user |

## Examples

### Good Request

`https://{localhost}/api/v1/user_notifications`

#### ...with response

```json
{
  "data": [
      {
          "id": "2",
          "type": "user_notifications",
          "attributes": {
              "seen": false
          },
          "relationships": {
              "notification": {
                  "data": {
                      "id": "2",
                      "type": "notifications"
                  }
              }
          }
      }
  ]
}
```


# Get Notifications

Only admins can see the notifications that they created and details about whether the clients saw them

## Request

### Method

`GET`

### Path

`/api/v1/notifications`

**Query Parameters**

| Param                  | Type     | Description                                                                                             |
|------------------------|----------|----------------------------------------------------- |
| include                | String   | Optional parameter that can be "user_notifications"  |

### Headers

| Name          | Value                    |
| ------------  | ------------------------ |
| Authorization | Bearer #{token}          |

## Response

### Statuses

| Status | Name   | Type  | Description                                              |
| ------ | ------ | ----- | -------------------------------------------------------- |
| 200    | data   | Array | A list containing all notifications created by the admin |

## Examples

### Good Request

`https://{localhost}/api/v1/notifications`

#### ...with response

```json
{
    "data": [
        {
            "id": "9",
            "type": "notifications",
            "attributes": {
                "title": "Title",
                "description": "Description",
                "date": "01/05/2021",
                "created_by": 1
            },
            "relationships": {
                "user_notifications": {
                    "data": [
                        {
                            "id": "10",
                            "type": "user_notifications"
                        }
                    ]
                }
            }
        }
      ]
}
    
```

# Get Users

Admins can search for users by name to which they want to send a particular notification

## Request

### Method

`GET`

### Path

`/api/v1/users`

**Query Parameters**

| Param                  | Type     | Description                                                                                             |
|------------------------|----------|------------------------------------------------- |
| filter[name]           | String   | Optional parameter that can be any string        |

### Headers

| Name          | Value                    |
| ------------  | ------------------------ |
| Authorization | Bearer #{token}          |

## Response

### Statuses

| Status | Name   | Type  | Description                                              |
| ------ | ------ | ----- | -------------------------------------------------------- |
| 200    | data   | Array | A list containing the users after the filtering          |

## Examples

### Good Request

`https://{localhost}/api/v1/users`

#### ...with response

```json
{
    "data": [
        {
            "id": "2",
            "type": "users",
            "attributes": {
                "name": "Client Name"
            }
        }
    ]
}
```

# Create notification

An admin can create a notification for a list of users or for all users

## Request

### Method

`POST`

### Path

`/api/v1/notifications`

### Headers

| Name          | Value                    |
| ------------  | ------------------------ |
| Authorization | Bearer #{token}          |

### Body Parameters

| Name                      | Type               | Description               |
| -------------------       | ------------------ | ------------------------- |
| notification[title]       | String             | Mandatory; The title of the notification |
| notification[description] | Text               | Mandatory; The description of the notification |
| notification[date]        | Timestamp          | Mandatory; The date the notification will be visible to the senders |
| notification[user_ids]    | Array of integers  | Optional; Contains the ids of the users to which the notification is intended| 
|                           |                    | If left blank, the notification will be sent to all users|


## Response

### Statuses

| Status | Name   | Type   | Description                                                          |
| ------ | ------ | ------ | -------------------------------------------------------------------- |
| 201    | data   | Object | The created notification                                                 |
| 422    | errors | Array  | Array of errors based on the validations
## Examples

### Good Request

`https://{localhost}/api/v1/notifications`

```json
{ "notification": {
    "title": "Titlu",
    "description": "Descriere",
    "date": "2021-01-5",
    "user_ids": [ 2 ]
    }
}
```

#### ...with response

```json
{
    "data": {
        "id": "10",
        "type": "notifications",
        "attributes": {
            "title": "Titlu",
            "description": "Descriere",
            "date": "01/05/2021",
            "created_by": 1
        }
    }
}
```

# Update user notification

A client can update only its own user notification.
This is used to mark the notification as seen

## Request

### Method

`PATCH`

### Path

`/api/v1/user_notifications/:id`

**Query Parameters**

| Param                  | Type     | Description                                                                                             |
|------------------------|----------|------------------------------------------------- |
| include                | String   | Optional parameter that can be "notification"    |

### Headers

| Name          | Value                    |
| ------------  | ------------------------ |
| Authorization | Bearer #{token}          |

### Body Parameters

| Name                          | Type               | Description                                          |
| -----------------------       | ------------------ | ---------------------------------------------------- |
| user_notification[seen]       | Boolean            | Optional; Marks the notification as seen by the user |
|                               |                    | If present, it can only be true                      |

## Response

### Statuses

| Status | Name   | Type   | Description                                                          |
| ------ | ------ | ------ | -------------------------------------------------------------------- |
| 200    | data   | Object | The updated user notification                                                 |
| 422    | errors | Array  | Array of errors based on the validations
## Examples

### Good Request

`https://{localhost}/api/v1/user_notifications/:id`

```json
{ "user_notification": { "seen": "true" }}
```

#### ...with response

```json
{
    "data": {
        "id": "1",
        "type": "user_notifications",
        "attributes": {
            "seen": true
        },
        "relationships": {
            "notification": {
                "data": {
                    "id": "1",
                    "type": "notifications"
                }
            }
        }
    }
}
```


# Login

Users can login in order to access the API(simplified version)

## Request

### Method

`POST`

### Path

`/api/v1/sessions`

### Body Parameters

| Name        | Type               | Description                |
| ---------   | ------------------ | -------------------------- |
| email       | String             | Mandatory; User's email    |
| password    | String             | Mandatory; User's password |


## Response

### Statuses

| Status | Name   | Type   | Description                                             |
| ------ | ------ | ------ | --------------------------------------------------------|
| 200    | data   | Object | The user and the generated token                        |
| 422    | errors | Array  | Invalid username or password                       |

## Examples

### Good Request

`https://{localhost}/api/v1/sessions`

```json
{ "email": "example@gmail.com",
  "password": "lalala"}
```

#### ...with response

```json
{
    "user": {
        "id": 1,
        "name": "Example Name",
        "email": "example@gmail.com",
        "password_digest": "$2a$12$jASRB224PRDSBRc/rpZgZuT05zA5CdkGhc4k/wIZ1/LpgwDcddo2.",
        "role_id": 1,
        "created_at": "2021-01-04T16:07:20.313Z",
        "updated_at": "2021-01-04T16:07:20.313Z"
    },
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2MDk4NzM0NjZ9.7gtmZkpiGbRne4N99za-SkQDYokoHk9_kca3Td99tJM"
}
```