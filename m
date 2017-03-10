Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cmGbD-00051J-8M
 for kexec@lists.infradead.org; Fri, 10 Mar 2017 09:12:37 +0000
Date: Fri, 10 Mar 2017 10:12:10 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] vmcore-dmesg: Define _GNU_SOURCE
Message-ID: <20170310091210.GB21820@verge.net.au>
References: <1452388882-11712-1-git-send-email-raj.khem@gmail.com>
 <1489002280.4347.149.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1489002280.4347.149.camel@infradead.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Khem Raj <raj.khem@gmail.com>

T24gV2VkLCBNYXIgMDgsIDIwMTcgYXQgMDg6NDQ6NDBQTSArMDEwMCwgRGF2aWQgV29vZGhvdXNl
IHdyb3RlOgo+IE9uIFNhdCwgMjAxNi0wMS0wOSBhdCAxNzoyMSAtMDgwMCwgS2hlbSBSYWogd3Jv
dGU6Cj4gPiBsb2ZmX3QgaXMgZ3VhcmRlZCB3aXRoIF9HTlVfU09VUkNFIG9uIHNvbWUgQyBsaWJy
YXJ5IGltcGxlbWVudGF0aW9ucwo+ID4gZS5nLiBtdXNsIHNpbmNlIHRoaXMgdHlwZSBpcyBub3Qg
ZGVmaW5lZCBieSBQT1NJWC4gRGVmaW5lIF9HTlVfU09VUkNFIHRvCj4gPiBpbmNsdWRlIHRoaXMg
ZGVmaW5lLCBpdCBzaG91bGQgaGVscCBjb21waWxpbmcgb24gbXVzbCB3aGlsZSBub3RoaW5nCj4g
PiBjaGFuZ2VzIGZvciBnbGliYyBiYXNlZCBzeXN0ZW1zIHNpbmNlIHRoZXJlIF9HTlVfU09VUkNF
IGlzIGFscmVhZHkKPiA+IGRlZmluZWQKPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogS2hlbSBSYWog
PHJhai5raGVtQGdtYWlsLmNvbT4KPiAKPiBUaGlzIGFwcGVhcnMgdG8gc3RpbGwgYmUgbmVlZGVk
Li4uCgpGb3Igc29tZSByZWFzb24gaXQgZGlkIG5vdCBoaXQgbXkgaW5ib3ggOigKClNoYWxsIEkg
cGljayB1cCB0aGUgdmVyc2lvbiB5b3UgcmVwb3N0ZWQgYXMgUEFUQ0ggNy83ID8KCj4gPiAtLS0K
PiA+IMKgdm1jb3JlLWRtZXNnL3ZtY29yZS1kbWVzZy5jIHwgMSArCj4gPiDCoDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvdm1jb3JlLWRtZXNnL3Zt
Y29yZS1kbWVzZy5jIGIvdm1jb3JlLWRtZXNnL3ZtY29yZS1kbWVzZy5jCj4gPiBpbmRleCAwMzY0
NjM2Li5hOGY1NmRmIDEwMDY0NAo+ID4gLS0tIGEvdm1jb3JlLWRtZXNnL3ZtY29yZS1kbWVzZy5j
Cj4gPiArKysgYi92bWNvcmUtZG1lc2cvdm1jb3JlLWRtZXNnLmMKPiA+IEBAIC0xLDQgKzEsNSBA
QAo+ID4gwqAjZGVmaW5lIF9YT1BFTl9TT1VSQ0UgNjAwCj4gPiArI2RlZmluZSBfR05VX1NPVVJD
RQo+ID4gwqAjZGVmaW5lIF9MQVJHRUZJTEVfU09VUkNFIDEKPiA+IMKgI2RlZmluZSBfRklMRV9P
RkZTRVRfQklUUyA2NAo+ID4gwqAjaW5jbHVkZSAKCgoKPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+IGtleGVjIG1haWxpbmcgbGlzdAo+IGtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
