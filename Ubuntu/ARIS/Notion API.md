---
created: 2026-06-09
tags:
  - ARIS
  - Notion
source:
aliases:
---

## Connect python to Notion API
### Create a Personal Access Token (PAT)
Follow the [official Notion documentation](https://developers.notion.com/guides/get-started/personal-access-tokens#create-a-pat) to create a PAT.
Should be something like `ntn_238637256376YodMWs1XBVsRzUovvxLOdaLNlZFy33`
### Fetch Database ID

From the [official Notion documentation](https://developers.notion.com/reference/retrieve-database):
To find a database ID, navigate to the database URL in your Notion workspace. The ID is the string of characters in the URL that is between the slash following the workspace name (if applicable) and the question mark. The ID is a 32 characters alphanumeric string.
![[Pasted image 20260709104350.png]]
### Add Notion token to Database connections

In order for the notion API to be able to make changes to a database the API must be authorized to make changes to the database. This is done by adding the token as a connection for the database page. Follow [official Notion documentation (Add connections to pages )]([https://developers.notion.com/reference/retrieve-database](https://www.notion.com/help/add-and-manage-connections-with-the-api#add-connections-to-pages))
### Test API Connection

Paste in your Notion API token and Database ID, and run this code to test the connection to the notion database.
```python
import requests


NOTION_TOKEN = "<YOUR_NOTION_INTEGRATION_TOKEN>"
NOTION_DATABASE_ID = "<YOUR_NOTION_DATABASE_ID>"
NOTION_VERSION = "2022-06-28" # Use the appropriate Notion API version

HEADERS = {
"Authorization": f"Bearer {NOTION_TOKEN}",
"Content-Type": "application/json",
"Notion-Version": NOTION_VERSION,
}

url = f"https://api.notion.com/v1/databases/{NOTION_DATABASE_ID}"
  
response = requests.get(url, headers=HEADERS, timeout=30)

print("Response status code:", response.status_code)
print("Response content:", response.text)


if response.status_code == 200:
# Connection successful, you can process the response data here
print("=============================================")
print("Connection to Notion API successful.")
print("==============================================")
```

