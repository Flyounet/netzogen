<a name="netzogen" />
## NETZOGEN

  Simple bash CLI to genererate your `dhcpd` and `dns` (Unbound) configuration from a single file.

## Install

```
$ make install
$ make uninstall
```

## Usage

```
Usage: ./netzogen [-h] [-v] [-f filename] [-d filename] [-D filename] [-X filename] [-o]

        -h/-H           Print this help
        -v/-V           Print the version/And the short commit name
        -f 'input File' Parse this file (default: ./netzo.lst)
        -d 'dhcp file'  Generate Dhcp output in this file (default: ./dhcpFile)
        -D 'DNS file'   Generate DNS output in this file (default: ./dnsFile)
        -X 'HTML file'  Generate HTML output in this file (default: ./htmlFile.html)
        -o              Overwrite generated file

The input file is parsed to find the followlling lines :
# Blabla blahblah
It's a comment, and it will be passed (as for empty lines)

domain: (sub.)dom
The domain (or sub-domain) will be apped to all following lines.
Could be used more than once in the input file.

mac_address,ip_adress,name1|name2|...
A line will be added for the Dhcp conf with the mac_address and the host name1 (+domain if it exists) 
A line will be added for the DNS conf with the ip_address and the host name1 (+domain if it exists) and a reverse.
A line will be added for the DNS conf with the ip_address and the host name2 (+domain if it exists) as a pointer.
If the mac_adress is not given, then the Dhcp conf is not generated for this line. The DNS one will be.

; This is something important
It will create it as a comment (starting with a #) in each config file.

#exit-netzo
It forces to exit from the parsed file. Useful when you have informations netzogen should not parse.

```

## Examples

Take the following input file :

```
; Working on .home domain
domain: home
# web server
ab:00:36:15:ba:ba,127.0.0.1,web|test1
,10.1.1.2,dns|ntp|dhcp

; Working on .test domain
domain: in.test
# web server
36:15:BA:BA:be:be,127.0.0.2,web|test1
,10.1.1.3,dns|ntp|dhcp

```

It will create a Dhcp file :

```
# Working on .home domain
host web {
        hardware ethernet ab:00:36:15:ba:ba;
        fixed-address web.home;
}

# Working on .test domain
host web {
        hardware ethernet 36:15:ba:ba:be:be;
        fixed-address web.in.test;
}
```

And a DNS file :

```
# Working on .home domain
local-data: "web.home.  IN A 127.0.0.1"
local-data-ptr: "127.0.0.1              web.home"
local-data: "test1.home.        IN A 127.0.0.1"

local-data: "dns.home.  IN A 10.1.1.2"
local-data-ptr: "10.1.1.2               dns.home"
local-data: "ntp.home.  IN A 10.1.1.2"
local-data: "dhcp.home. IN A 10.1.1.2"

# Working on .test domain
local-data: "web.in.test.       IN A 127.0.0.2"
local-data-ptr: "127.0.0.2              web.in.test"
local-data: "test1.in.test.     IN A 127.0.0.2"

local-data: "dns.in.test.       IN A 10.1.1.3"
local-data-ptr: "10.1.1.3               dns.in.test"
local-data: "ntp.in.test.       IN A 10.1.1.3"
local-data: "dhcp.in.test.      IN A 10.1.1.3"

```

## Licenses

  * WTFPL : do What The Fuck you Want to Public License
  * DSSL  : Demerden Sie Sich License

## Method

  * Coding method : @LA R.A.C.H.E
  * Coding style  : [J.C.A.L.C](https://www.youtube.com/watch?v=p8oi6M4z_e0 "Je Code Avec Le Cul") (ex: SCRotUM)
