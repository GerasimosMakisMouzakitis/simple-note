# 📚 API Documentation Template

## **[API_NAME] Documentation**

### **Project:** [PROJECT_NAME]
### **Version:** [API_VERSION]
### **Author:** [DEVELOPER_NAME]
### **Date:** [CURRENT_DATE]

---

## 🎯 **API Overview**

### **Description:**
[BRIEF_DESCRIPTION_OF_API_PURPOSE]

### **Base URL:**
```
[API_BASE_URL]
# Example: https://api.example.com/v1
```

### **Authentication:**
- **Type:** [AUTH_TYPE] (Bearer Token, API Key, OAuth2, etc.)
- **Header:** `Authorization: Bearer [TOKEN]`
- **Scope:** [REQUIRED_PERMISSIONS]

### **Rate Limiting:**
- **Limit:** [REQUESTS] requests per [TIME_WINDOW]
- **Headers:** `X-RateLimit-Limit`, `X-RateLimit-Remaining`

---

## 🔐 **Authentication**

### **Bearer Token Authentication:**
```http
GET /api/v1/endpoint
Host: api.example.com
Authorization: Bearer YOUR_ACCESS_TOKEN
Content-Type: application/json
```

### **API Key Authentication:**
```http
GET /api/v1/endpoint
Host: api.example.com
X-API-Key: YOUR_API_KEY
Content-Type: application/json
```

### **Getting Access Tokens:**
```bash
# OAuth2 Flow
curl -X POST https://api.example.com/oauth/token \
  -H "Content-Type: application/json" \
  -d '{
    "grant_type": "client_credentials",
    "client_id": "YOUR_CLIENT_ID",
    "client_secret": "YOUR_CLIENT_SECRET"
  }'
```

---

## 📊 **API Endpoints**

### **[RESOURCE_NAME] Endpoints**

#### **📋 List [RESOURCES]**
```http
GET /api/v1/[resources]
```

**Description:** Retrieve a list of all [resources] with pagination support.

**Query Parameters:**
| Parameter | Type | Required | Description | Example |
|-----------|------|----------|-------------|----------|
| `page` | integer | No | Page number (default: 1) | `?page=2` |
| `limit` | integer | No | Items per page (default: 20, max: 100) | `?limit=50` |
| `sort` | string | No | Sort field | `?sort=created_at` |
| `order` | string | No | Sort order (asc, desc) | `?order=desc` |
| `filter` | string | No | Filter criteria | `?filter=status:active` |
| `search` | string | No | Search query | `?search=keyword` |

**Request Example:**
```bash
curl -X GET "https://api.example.com/v1/users?page=1&limit=20&sort=created_at&order=desc" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json"
```

**Response Example:**
```json
{
  "success": true,
  "data": [
    {
      "id": "[RESOURCE_ID]",
      "name": "[RESOURCE_NAME]",
      "status": "[STATUS]",
      "created_at": "2024-12-28T10:30:00Z",
      "updated_at": "2024-12-28T15:45:00Z"
    }
  ],
  "pagination": {
    "current_page": 1,
    "per_page": 20,
    "total": 150,
    "total_pages": 8
  },
  "meta": {
    "request_id": "req_123456789",
    "response_time": "45ms"
  }
}
```

#### **🔍 Get [RESOURCE] by ID**
```http
GET /api/v1/[resources]/{id}
```

**Description:** Retrieve a specific [resource] by its unique identifier.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|--------------|
| `id` | string/integer | Yes | Unique resource identifier |

**Request Example:**
```bash
curl -X GET "https://api.example.com/v1/users/12345" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json"
```

**Response Example:**
```json
{
  "success": true,
  "data": {
    "id": "12345",
    "name": "John Doe",
    "email": "john.doe@example.com",
    "status": "active",
    "profile": {
      "bio": "Software Developer",
      "location": "San Francisco, CA",
      "avatar_url": "https://cdn.example.com/avatars/12345.jpg"
    },
    "created_at": "2024-01-15T08:30:00Z",
    "updated_at": "2024-12-28T14:22:00Z"
  },
  "meta": {
    "request_id": "req_987654321",
    "response_time": "23ms"
  }
}
```

#### **✨ Create New [RESOURCE]**
```http
POST /api/v1/[resources]
```

**Description:** Create a new [resource] with the provided data.

**Request Body:**
```json
{
  "name": "[REQUIRED_FIELD]",
  "email": "[REQUIRED_EMAIL]",
  "status": "[OPTIONAL_STATUS]",
  "profile": {
    "bio": "[OPTIONAL_BIO]",
    "location": "[OPTIONAL_LOCATION]"
  }
}
```

**Validation Rules:**
| Field | Type | Required | Validation | Example |
|-------|------|----------|------------|----------|
| `name` | string | Yes | 2-100 characters | "John Doe" |
| `email` | string | Yes | Valid email format | "john@example.com" |
| `status` | string | No | active, inactive, pending | "active" |
| `profile.bio` | string | No | Max 500 characters | "Software Developer" |

**Request Example:**
```bash
curl -X POST "https://api.example.com/v1/users" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Jane Smith",
    "email": "jane.smith@example.com",
    "status": "active",
    "profile": {
      "bio": "Product Manager",
      "location": "New York, NY"
    }
  }'
```

**Response Example:**
```json
{
  "success": true,
  "message": "Resource created successfully",
  "data": {
    "id": "67890",
    "name": "Jane Smith",
    "email": "jane.smith@example.com",
    "status": "active",
    "profile": {
      "bio": "Product Manager",
      "location": "New York, NY",
      "avatar_url": null
    },
    "created_at": "2024-12-28T16:45:00Z",
    "updated_at": "2024-12-28T16:45:00Z"
  },
  "meta": {
    "request_id": "req_555666777",
    "response_time": "67ms"
  }
}
```

#### **🔄 Update [RESOURCE]**
```http
PUT /api/v1/[resources]/{id}
PATCH /api/v1/[resources]/{id}
```

**Description:** Update an existing [resource]. Use PUT for full updates, PATCH for partial updates.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|--------------|
| `id` | string/integer | Yes | Unique resource identifier |

**Request Body (PATCH example):**
```json
{
  "status": "inactive",
  "profile": {
    "bio": "Updated bio text"
  }
}
```

**Request Example:**
```bash
curl -X PATCH "https://api.example.com/v1/users/12345" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "status": "inactive",
    "profile": {
      "bio": "Senior Software Developer"
    }
  }'
```

**Response Example:**
```json
{
  "success": true,
  "message": "Resource updated successfully",
  "data": {
    "id": "12345",
    "name": "John Doe",
    "email": "john.doe@example.com",
    "status": "inactive",
    "profile": {
      "bio": "Senior Software Developer",
      "location": "San Francisco, CA",
      "avatar_url": "https://cdn.example.com/avatars/12345.jpg"
    },
    "created_at": "2024-01-15T08:30:00Z",
    "updated_at": "2024-12-28T17:12:00Z"
  },
  "meta": {
    "request_id": "req_111222333",
    "response_time": "34ms"
  }
}
```

#### **🗑️ Delete [RESOURCE]**
```http
DELETE /api/v1/[resources]/{id}
```

**Description:** Permanently delete a [resource]. This action cannot be undone.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|--------------|
| `id` | string/integer | Yes | Unique resource identifier |

**Request Example:**
```bash
curl -X DELETE "https://api.example.com/v1/users/12345" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json"
```

**Response Example:**
```json
{
  "success": true,
  "message": "Resource deleted successfully",
  "data": {
    "id": "12345",
    "deleted_at": "2024-12-28T18:00:00Z"
  },
  "meta": {
    "request_id": "req_444555666",
    "response_time": "18ms"
  }
}
```

---

## 📊 **Response Format**

### **Standard Response Structure:**
```json
{
  "success": boolean,
  "message": "string (optional)",
  "data": object | array | null,
  "errors": array (only on failure),
  "pagination": object (only for paginated results),
  "meta": {
    "request_id": "string",
    "response_time": "string",
    "api_version": "string",
    "timestamp": "string (ISO 8601)"
  }
}
```

### **Success Response (200-299):**
```json
{
  "success": true,
  "message": "Operation completed successfully",
  "data": { /* response data */ },
  "meta": {
    "request_id": "req_123456789",
    "response_time": "45ms",
    "api_version": "v1.0.0",
    "timestamp": "2024-12-28T15:30:00Z"
  }
}
```

### **Error Response (400-599):**
```json
{
  "success": false,
  "message": "Request validation failed",
  "errors": [
    {
      "field": "email",
      "code": "INVALID_FORMAT",
      "message": "Please provide a valid email address"
    },
    {
      "field": "name",
      "code": "REQUIRED_FIELD",
      "message": "Name is required"
    }
  ],
  "meta": {
    "request_id": "req_987654321",
    "response_time": "12ms",
    "api_version": "v1.0.0",
    "timestamp": "2024-12-28T15:35:00Z"
  }
}
```

---

## 🚨 **Error Codes**

### **HTTP Status Codes:**
| Code | Status | Description | Example |
|------|--------|-------------|----------|
| 200 | OK | Request successful | Resource retrieved |
| 201 | Created | Resource created successfully | User account created |
| 204 | No Content | Request successful, no content | Resource deleted |
| 400 | Bad Request | Invalid request data | Missing required field |
| 401 | Unauthorized | Authentication required | Invalid or missing token |
| 403 | Forbidden | Insufficient permissions | Access denied to resource |
| 404 | Not Found | Resource not found | User ID does not exist |
| 422 | Unprocessable Entity | Validation failed | Email already exists |
| 429 | Too Many Requests | Rate limit exceeded | API quota exceeded |
| 500 | Internal Server Error | Server error | Database connection failed |
| 503 | Service Unavailable | Service temporarily unavailable | Maintenance mode |

### **Custom Error Codes:**
| Code | Description | Resolution |
|------|-------------|------------|
| `INVALID_FORMAT` | Data format is incorrect | Check field format requirements |
| `REQUIRED_FIELD` | Required field is missing | Provide all required fields |
| `DUPLICATE_ENTRY` | Resource already exists | Use different unique values |
| `RESOURCE_NOT_FOUND` | Requested resource doesn't exist | Verify resource ID |
| `PERMISSION_DENIED` | Insufficient permissions | Check user role and permissions |
| `RATE_LIMIT_EXCEEDED` | Too many requests | Wait and retry later |
| `MAINTENANCE_MODE` | Service under maintenance | Retry after maintenance window |

### **Error Response Examples:**

#### **Validation Error (422):**
```json
{
  "success": false,
  "message": "Validation failed",
  "errors": [
    {
      "field": "email",
      "code": "DUPLICATE_ENTRY",
      "message": "Email address already exists"
    }
  ]
}
```

#### **Authentication Error (401):**
```json
{
  "success": false,
  "message": "Authentication required",
  "errors": [
    {
      "code": "INVALID_TOKEN",
      "message": "The provided access token is invalid or expired"
    }
  ]
}
```

#### **Rate Limit Error (429):**
```json
{
  "success": false,
  "message": "Rate limit exceeded",
  "errors": [
    {
      "code": "RATE_LIMIT_EXCEEDED",
      "message": "You have exceeded the rate limit. Please try again later.",
      "retry_after": 300
    }
  ]
}
```

---

## 🔧 **SDK Examples**

### **JavaScript/Node.js:**
```javascript
// Installation: npm install axios
const axios = require('axios');

class APIClient {
  constructor(baseURL, token) {
    this.client = axios.create({
      baseURL,
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      }
    });
  }

  async getUsers(params = {}) {
    try {
      const response = await this.client.get('/users', { params });
      return response.data;
    } catch (error) {
      throw new Error(`API Error: ${error.response?.data?.message || error.message}`);
    }
  }

  async createUser(userData) {
    try {
      const response = await this.client.post('/users', userData);
      return response.data;
    } catch (error) {
      throw new Error(`API Error: ${error.response?.data?.message || error.message}`);
    }
  }
}

// Usage
const api = new APIClient('https://api.example.com/v1', 'your-token');

// Get users with pagination
api.getUsers({ page: 1, limit: 20 })
  .then(users => console.log('Users:', users.data))
  .catch(error => console.error('Error:', error.message));

// Create new user
api.createUser({
  name: 'John Doe',
  email: 'john@example.com',
  status: 'active'
})
  .then(result => console.log('User created:', result.data))
  .catch(error => console.error('Error:', error.message));
```

### **Python:**
```python
# Installation: pip install requests
import requests
from typing import Dict, Any, Optional

class APIClient:
    def __init__(self, base_url: str, token: str):
        self.base_url = base_url
        self.session = requests.Session()
        self.session.headers.update({
            'Authorization': f'Bearer {token}',
            'Content-Type': 'application/json'
        })

    def get_users(self, params: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        """Get list of users with optional parameters"""
        response = self.session.get(f'{self.base_url}/users', params=params)
        response.raise_for_status()
        return response.json()

    def create_user(self, user_data: Dict[str, Any]) -> Dict[str, Any]:
        """Create a new user"""
        response = self.session.post(f'{self.base_url}/users', json=user_data)
        response.raise_for_status()
        return response.json()

    def get_user(self, user_id: str) -> Dict[str, Any]:
        """Get specific user by ID"""
        response = self.session.get(f'{self.base_url}/users/{user_id}')
        response.raise_for_status()
        return response.json()

# Usage
api = APIClient('https://api.example.com/v1', 'your-token')

try:
    # Get users with pagination
    users = api.get_users({'page': 1, 'limit': 20})
    print(f"Found {len(users['data'])} users")

    # Create new user
    new_user = api.create_user({
        'name': 'Jane Doe',
        'email': 'jane@example.com',
        'status': 'active'
    })
    print(f"Created user: {new_user['data']['id']}")

except requests.exceptions.HTTPError as e:
    print(f"API Error: {e.response.json().get('message', str(e))}")
except requests.exceptions.RequestException as e:
    print(f"Request Error: {str(e)}")
```

### **cURL Examples:**
```bash
#!/bin/bash

# Set your API token
API_TOKEN="your-access-token"
BASE_URL="https://api.example.com/v1"

# Get users with pagination
echo "Getting users..."
curl -X GET "${BASE_URL}/users?page=1&limit=10" \
  -H "Authorization: Bearer ${API_TOKEN}" \
  -H "Content-Type: application/json" \
  | jq '.'

# Create new user
echo "Creating user..."
curl -X POST "${BASE_URL}/users" \
  -H "Authorization: Bearer ${API_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "status": "active"
  }' \
  | jq '.'

# Update user
echo "Updating user..."
curl -X PATCH "${BASE_URL}/users/12345" \
  -H "Authorization: Bearer ${API_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "status": "inactive"
  }' \
  | jq '.'

# Delete user
echo "Deleting user..."
curl -X DELETE "${BASE_URL}/users/12345" \
  -H "Authorization: Bearer ${API_TOKEN}" \
  -H "Content-Type: application/json" \
  | jq '.'
```

---

## 📝 **Testing Guide**

### **Postman Collection:**
Import this collection to test all endpoints:

```json
{
  "info": {
    "name": "[API_NAME] Collection",
    "description": "Complete API testing collection"
  },
  "variable": [
    {
      "key": "base_url",
      "value": "https://api.example.com/v1"
    },
    {
      "key": "auth_token",
      "value": "{{ACCESS_TOKEN}}"
    }
  ],
  "auth": {
    "type": "bearer",
    "bearer": [
      {
        "key": "token",
        "value": "{{auth_token}}",
        "type": "string"
      }
    ]
  }
}
```

### **Test Scenarios:**

#### **✅ Happy Path Tests:**
1. **Authentication:** Verify token authentication works
2. **CRUD Operations:** Test create, read, update, delete
3. **Pagination:** Test list endpoints with pagination
4. **Filtering:** Test search and filter functionality

#### **🚨 Error Handling Tests:**
1. **Invalid Authentication:** Test with invalid/expired tokens
2. **Validation Errors:** Test with invalid data formats
3. **Not Found:** Test with non-existent resource IDs
4. **Rate Limiting:** Test API rate limits

#### **🔒 Security Tests:**
1. **Authorization:** Test access control and permissions
2. **Input Validation:** Test SQL injection, XSS prevention
3. **Data Leakage:** Verify sensitive data is not exposed

---

## 📊 **Rate Limiting & Quotas**

### **Rate Limits:**
| Endpoint Type | Limit | Window | Burst |
|---------------|-------|--------|-------|
| Authentication | 5 requests | 15 minutes | 10 |
| Read Operations | 1000 requests | 1 hour | 50 |
| Write Operations | 100 requests | 1 hour | 20 |
| File Upload | 10 requests | 1 hour | 5 |

### **Rate Limit Headers:**
```http
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1609459200
X-RateLimit-Window: 3600
```

### **Quota Management:**
- **Daily Quota:** 50,000 requests per day
- **Monthly Quota:** 1,000,000 requests per month
- **Overage Policy:** Requests blocked when quota exceeded
- **Quota Reset:** Daily at 00:00 UTC, Monthly on 1st day

---

## 📞 **Support & Resources**

### **📧 Contact Information:**
- **Technical Support:** [SUPPORT_EMAIL]
- **API Questions:** [API_TEAM_EMAIL]
- **Documentation Issues:** [DOCS_EMAIL]

### **🔗 Additional Resources:**
- **API Status Page:** [STATUS_URL]
- **Developer Portal:** [DEVELOPER_PORTAL_URL]
- **Community Forum:** [FORUM_URL]
- **GitHub Repository:** [GITHUB_REPO_URL]

### **📚 Related Documentation:**
- **Getting Started Guide:** [GETTING_STARTED_URL]
- **Authentication Guide:** [AUTH_GUIDE_URL]
- **SDKs and Libraries:** [SDK_URL]
- **Changelog:** [CHANGELOG_URL]

---

## 🔄 **Versioning**

### **API Versioning:**
- **Current Version:** v1.0.0
- **Versioning Scheme:** Semantic Versioning (SemVer)
- **Version Header:** `API-Version: v1`
- **Deprecation Policy:** 12 months notice before removal

### **Backwards Compatibility:**
- **Breaking Changes:** Only in major versions
- **New Features:** Added in minor versions
- **Bug Fixes:** Released in patch versions

---

**📋 Professional API documentation ensuring seamless integration and optimal developer experience.**

*This documentation provides comprehensive guidance for integrating with the API, including authentication, endpoints, error handling, and best practices.*