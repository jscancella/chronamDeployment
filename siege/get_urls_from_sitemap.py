import multiprocessing
import os
import requests
import xml.etree.ElementTree as ET

def getUrlsFromSitemap(root):
    urls = []
    for sitemap in root:
        urls.append(sitemap[0].text)
    return urls

def getSubSitemapUrls(url):
    filename = "url-downloads/" + url.split("/")[-1].replace("?p=", ".").replace("xml", "txt")
    if os.path.exists(filename):
        print("already downloaded %s" % filename)
        return

    print("getting sitemap %s" % url)
    r = requests.get(url)

    if r.text is None:
        print("no text from request. Trying directly from server")
        r = requests.get(url.replace("chronam-public-572020635.us-east-1.elb.amazonaws.com", "ec2-52-90-137-133.compute-1.amazonaws.com"))
        subsitemap = ET.fromstring(r.text)
        urls = getUrlsFromSitemap(subsitemap)
    else:
        subsitemap = ET.fromstring(r.text)
        urls = getUrlsFromSitemap(subsitemap)

    with open(filename, "w") as f:
        f.write("\n".join(urls))

#r = requests.get("http://ec2-52-90-137-133.compute-1.amazonaws.com/sitemap.xml")
#r = requests.get("http://localhost/sitemap.xml")
r = requests.get("http://chronam-public-572020635.us-east-1.elb.amazonaws.com/sitemap.xml")

root = ET.fromstring(r.text)

pool = multiprocessing.Pool(processes=multiprocessing.cpu_count())
pool.map(getSubSitemapUrls, getUrlsFromSitemap(root))
