import yaml

# import json

# pip install pyyaml


def main():
    with open("sock-shop/complete-demo-custom.yml") as f:
        body = yaml.safe_load_all(f)
        buffer = []
        for b in body:
            if b is None:
                continue
            if b["kind"] == "Deployment":
                containers = b["spec"]["template"]["spec"]["containers"]
                proxy = list(filter(lambda x: x["name"] == "istio-proxy", containers))
                mounts = proxy[0]["volumeMounts"]
                mounts.append(
                    {
                        "mountPath": "/var/lib/lua",
                        "name": "config-volume-lua",
                    }
                )
                # print(json.dumps(mounts, indent=2))
            buffer.append(b)

        with open("sock-shop/complete-demo-custom2.yml", mode="w") as fo:
            yaml.safe_dump_all(buffer, fo)


if __name__ == "__main__":
    main()
