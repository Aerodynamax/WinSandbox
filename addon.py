from mitmproxy import http
import json

data_list = []

def request(flow: http.HTTPFlow):
    global data_list
    url = flow.request.url
    headers = {}
    for key, var in flow.request.headers.items():
        headers[key] = var

    if url.startswith("https://discord.com/api/webhooks/"):
        data = {"url": url, "headers": headers}
        data_list.append(data)

        with open("urls.json", "w+") as f:
            # f.write(str(data_list))
            json.dump(data_list, f, indent=4)

        # answer from proxy
        flow.kill()
        flow.response = http.Response.make(
            401, b'{"message": "Invalid Webhook Token", "code": 50027}',
        )
