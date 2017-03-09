Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1clsX4-0006xr-4D
 for kexec@lists.infradead.org; Thu, 09 Mar 2017 07:30:42 +0000
Date: Thu, 9 Mar 2017 15:29:45 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3] Only print debug message when failed to serach for
 kernel symbol from /proc/kallsyms
Message-ID: <20170309072945.GI6570@x1>
References: <1488513135-29611-1-git-send-email-bhe@redhat.com>
 <20170306014645.GA3111@dhcp-128-65.nay.redhat.com>
 <8DEC88E0-ED27-46FE-A992-DD24283E402C@redfish-solutions.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8DEC88E0-ED27-46FE-A992-DD24283E402C@redfish-solutions.com>
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
To: Philip Prindeville <philipp_subx@redfish-solutions.com>
Cc: panand@redhat.com, kexec@lists.infradead.org, horms@verge.net.au, Dave Young <dyoung@redhat.com>, thgarnie@google.com

T24gMDMvMDgvMTcgYXQgMDk6MTNwbSwgUGhpbGlwIFByaW5kZXZpbGxlIHdyb3RlOgo+IElubGlu
ZeKApgo+IAo+IAo+ID4gT24gTWFyIDUsIDIwMTcsIGF0IDY6NDYgUE0sIERhdmUgWW91bmcgPGR5
b3VuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+IAo+ID4gT24gMDMvMDMvMTcgYXQgMTE6NTJhbSwg
QmFvcXVhbiBIZSB3cm90ZToKPiA+PiBLZXJuZWwgc3ltYm9sIHBhZ2Vfb2Zmc2V0X2Jhc2UgY291
bGQgYmUgdW5hdmFpbGFibGUgd2hlbiBtbSBLQVNMUiBjb2RlIGlzCj4gPj4gbm90IGNvbXBpbGVk
IGluIGtlcm5lbC4gSXQncyB1bmFwcHJvcHJpYXRlIHRvIHByaW50IG91dCBlcnJvciBtZXNzYWdl
Cj4gCj4gSSBzdWJzY3JpYmVkIHRvIHRoZSBsaXN0IHRoZSBkYXkgYWZ0ZXIgdGhpcyBwYXRjaCB3
ZW50IG91dOKApiAgQW55d2F5LCBjaGFuZ2UgdG8g4oCcaW5hcHByb3ByaWF0ZeKAnS4KCkluZGVl
ZCwgbm90IHN1cmUgaWYgU2ltb24gd2FudCBhIHJlcG9zdC4KClRoYW5rcywgbmljZSBjYXRjaCEK
Cj4gCj4gLVBoaWxpcAo+IAo+IAo+ID4+IHdoZW4gZmFpbGVkIHRvIHNlYXJjaCBmb3IgcGFnZV9v
ZmZzZXRfYmFzZSBmcm9tIC9wcm9jL2thbGxzeW1zLiBTZWVtcyBub3cKPiA+PiB0aGVyZSBpcyBu
b3QgYSB3YXkgdG8gZmluZCBvdXQgaWYgbW0gS0FTTFIgaXMgY29tcGlsZWQgaW4gb3Igbm90LiBB
bgo+ID4+IGFsdGVybmF0aXZlIGFwcHJvYWNoIGlzIG9ubHkgcHJpbnRpbmcgb3V0IGRlYnVnIG1l
c3NhZ2UgaW4gZ2V0X2tlcm5lbF9zeW0KPiA+PiBpZiBmYWlsZWQgdG8gc2VhcmNoIGEgZXhwZWN0
ZWQga2VybmVsIHN5bWJvbC4KPiA+PiAKPiA+PiBEbyBpdCBpbiB0aGlzIHBhdGNoLCBhIHNpbXBs
ZSBmaXguCj4gPj4gCj4gPj4gU2lnbmVkLW9mZi1ieTogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5j
b20+Cj4gPj4gLS0tCj4gPj4ga2V4ZWMvYXJjaC9pMzg2L2NyYXNoZHVtcC14ODYuYyB8IDIgKy0K
PiA+PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+PiAK
PiA+PiBkaWZmIC0tZ2l0IGEva2V4ZWMvYXJjaC9pMzg2L2NyYXNoZHVtcC14ODYuYyBiL2tleGVj
L2FyY2gvaTM4Ni9jcmFzaGR1bXAteDg2LmMKPiA+PiBpbmRleCA4OGFlZWUzLi5jNGNmMjAxIDEw
MDY0NAo+ID4+IC0tLSBhL2tleGVjL2FyY2gvaTM4Ni9jcmFzaGR1bXAteDg2LmMKPiA+PiArKysg
Yi9rZXhlYy9hcmNoL2kzODYvY3Jhc2hkdW1wLXg4Ni5jCj4gPj4gQEAgLTEyNyw3ICsxMjcsNyBA
QCBzdGF0aWMgdW5zaWduZWQgbG9uZyBsb25nIGdldF9rZXJuZWxfc3ltKGNvbnN0IGNoYXIgKnN5
bWJvbCkKPiA+PiAJCX0KPiA+PiAJfQo+ID4+IAo+ID4+IC0JZnByaW50ZihzdGRlcnIsICJDYW5u
b3QgZ2V0IGtlcm5lbCAlcyBzeW1ib2wgYWRkcmVzc1xuIiwgc3ltYm9sKTsKPiA+PiArCWRiZ3By
aW50ZigiQ2Fubm90IGdldCBrZXJuZWwgJXMgc3ltYm9sIGFkZHJlc3NcbiIsIHN5bWJvbCk7Cj4g
Pj4gCXJldHVybiAwOwo+ID4+IH0KPiA+PiAKPiA+PiAtLSAKPiA+PiAyLjUuNQo+ID4+IAo+ID4g
Cj4gPiBJdCBsb29rcyByZWFzb25hYmxlIHRvIG1lOgo+ID4gCj4gPiBBY2tlZC1ieTogRGF2ZSBZ
b3VuZyA8ZHlvdW5nQHJlZGhhdC5jb20+Cj4gPiAKPiA+IFRoYW5rcwo+ID4gRGF2ZQo+IAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
