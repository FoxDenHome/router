def add_ip_offset(ip, offset):
    return ip

def cidr_to_subnet_mask(cidr):
    cidr_num = int(cidr.split('/')[1], 10)
    subnet_num = (0xffffffff << (32 - cidr_num)) & 0xffffffff
    subnet_bytes = subnet_num.to_bytes(4, 'big')
    return "%d.%d.%d.%d" % (subnet_bytes[0], subnet_bytes[1], subnet_bytes[2], subnet_bytes[3])

def cidr_to_ip(cidr, offset=0):
    cidr_ip = cidr.split('/')[0]
    return add_ip_offset(cidr_ip, offset)

def build_classless_routes_bytes(classless_routes):
    routes = []
    for route in classless_routes:
        spl = route["subnet"].split("/")
        cidr_num = int(spl[1], 10)
        ip = [int(x, 10) for x in spl[0].split(".")]

        significant_bytes = cidr_num // 8
        significant_bits = cidr_num % 8
        if significant_bits > 0:
            significant_bytes += 1
        else:
            significant_bits = 8

        if significant_bytes > 0:
            out_ip = ip[:significant_bytes]
            out_ip[-1] = out_ip[-1] & (0xff << (8 - significant_bits))
        else:
            out_ip = []

        routes.append(cidr_num)
        routes += out_ip
        routes += [int(x, 10) for x in route["router"].split(".")]
    return routes
