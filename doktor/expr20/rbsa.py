import argparse
import json

aggre = {}
is_debug = False


def count_up_aggre(depth: int):
    aggre[depth] = aggre.get(depth, 0) + 1


def element_counts(response_body, depth: int):
    # print("response_body=", response_body)
    if is_debug:
        print("aggre:", aggre)
    for k, v in response_body.items():
        if is_debug:
            print(k)
        count_up_aggre(depth=depth)

        if type(v) is dict:
            if is_debug:
                print("v is dict")
            element_counts(v, depth + 1)
        elif type(v) is list:
            if is_debug:
                print("v is list")
            for l in v:
                count_up_aggre(depth=depth + 1)
                if type(l) is dict:
                    element_counts(l, depth + 2)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("filename")
    args = parser.parse_args()
    print("Open:", args.filename)
    with open(args.filename) as f:
        body = json.load(f)

    element_counts(body, 1)

    print("aggre:", aggre)
    sort_aggre = dict(sorted(aggre.items(), key=lambda x: x[0]))
    print("sort_aggre:", sort_aggre)
    rbsi = ", ".join(map(str, sort_aggre.values()))
    print(rbsi)

    basename = args.filename.split("/")[-1]
    write_filename = "rbsi." + basename.replace(".txt", "") + ".result"
    result_filename = args.filename.replace(basename, write_filename)
    with open(result_filename, mode="w") as f:
        f.write(rbsi + "\n")


if __name__ == "__main__":
    main()
