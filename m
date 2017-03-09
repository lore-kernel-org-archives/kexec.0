Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.redfish-solutions.com ([66.232.79.143])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1clpSf-0008Kq-Sf
 for kexec@lists.infradead.org; Thu, 09 Mar 2017 04:13:59 +0000
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v3] Only print debug message when failed to serach for
 kernel symbol from /proc/kallsyms
From: Philip Prindeville <philipp_subx@redfish-solutions.com>
In-Reply-To: <20170306014645.GA3111@dhcp-128-65.nay.redhat.com>
Date: Wed, 8 Mar 2017 21:13:35 -0700
Message-Id: <8DEC88E0-ED27-46FE-A992-DD24283E402C@redfish-solutions.com>
References: <1488513135-29611-1-git-send-email-bhe@redhat.com>
 <20170306014645.GA3111@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: panand@redhat.com, horms@verge.net.au, kexec@lists.infradead.org, thgarnie@google.com, Baoquan He <bhe@redhat.com>

SW5saW5l4oCmCgoKPiBPbiBNYXIgNSwgMjAxNywgYXQgNjo0NiBQTSwgRGF2ZSBZb3VuZyA8ZHlv
dW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+IAo+IE9uIDAzLzAzLzE3IGF0IDExOjUyYW0sIEJhb3F1
YW4gSGUgd3JvdGU6Cj4+IEtlcm5lbCBzeW1ib2wgcGFnZV9vZmZzZXRfYmFzZSBjb3VsZCBiZSB1
bmF2YWlsYWJsZSB3aGVuIG1tIEtBU0xSIGNvZGUgaXMKPj4gbm90IGNvbXBpbGVkIGluIGtlcm5l
bC4gSXQncyB1bmFwcHJvcHJpYXRlIHRvIHByaW50IG91dCBlcnJvciBtZXNzYWdlCgpJIHN1YnNj
cmliZWQgdG8gdGhlIGxpc3QgdGhlIGRheSBhZnRlciB0aGlzIHBhdGNoIHdlbnQgb3V04oCmICBB
bnl3YXksIGNoYW5nZSB0byDigJxpbmFwcHJvcHJpYXRl4oCdLgoKLVBoaWxpcAoKCj4+IHdoZW4g
ZmFpbGVkIHRvIHNlYXJjaCBmb3IgcGFnZV9vZmZzZXRfYmFzZSBmcm9tIC9wcm9jL2thbGxzeW1z
LiBTZWVtcyBub3cKPj4gdGhlcmUgaXMgbm90IGEgd2F5IHRvIGZpbmQgb3V0IGlmIG1tIEtBU0xS
IGlzIGNvbXBpbGVkIGluIG9yIG5vdC4gQW4KPj4gYWx0ZXJuYXRpdmUgYXBwcm9hY2ggaXMgb25s
eSBwcmludGluZyBvdXQgZGVidWcgbWVzc2FnZSBpbiBnZXRfa2VybmVsX3N5bQo+PiBpZiBmYWls
ZWQgdG8gc2VhcmNoIGEgZXhwZWN0ZWQga2VybmVsIHN5bWJvbC4KPj4gCj4+IERvIGl0IGluIHRo
aXMgcGF0Y2gsIGEgc2ltcGxlIGZpeC4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IEJhb3F1YW4gSGUg
PGJoZUByZWRoYXQuY29tPgo+PiAtLS0KPj4ga2V4ZWMvYXJjaC9pMzg2L2NyYXNoZHVtcC14ODYu
YyB8IDIgKy0KPj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
Cj4+IAo+PiBkaWZmIC0tZ2l0IGEva2V4ZWMvYXJjaC9pMzg2L2NyYXNoZHVtcC14ODYuYyBiL2tl
eGVjL2FyY2gvaTM4Ni9jcmFzaGR1bXAteDg2LmMKPj4gaW5kZXggODhhZWVlMy4uYzRjZjIwMSAx
MDA2NDQKPj4gLS0tIGEva2V4ZWMvYXJjaC9pMzg2L2NyYXNoZHVtcC14ODYuYwo+PiArKysgYi9r
ZXhlYy9hcmNoL2kzODYvY3Jhc2hkdW1wLXg4Ni5jCj4+IEBAIC0xMjcsNyArMTI3LDcgQEAgc3Rh
dGljIHVuc2lnbmVkIGxvbmcgbG9uZyBnZXRfa2VybmVsX3N5bShjb25zdCBjaGFyICpzeW1ib2wp
Cj4+IAkJfQo+PiAJfQo+PiAKPj4gLQlmcHJpbnRmKHN0ZGVyciwgIkNhbm5vdCBnZXQga2VybmVs
ICVzIHN5bWJvbCBhZGRyZXNzXG4iLCBzeW1ib2wpOwo+PiArCWRiZ3ByaW50ZigiQ2Fubm90IGdl
dCBrZXJuZWwgJXMgc3ltYm9sIGFkZHJlc3NcbiIsIHN5bWJvbCk7Cj4+IAlyZXR1cm4gMDsKPj4g
fQo+PiAKPj4gLS0gCj4+IDIuNS41Cj4+IAo+IAo+IEl0IGxvb2tzIHJlYXNvbmFibGUgdG8gbWU6
Cj4gCj4gQWNrZWQtYnk6IERhdmUgWW91bmcgPGR5b3VuZ0ByZWRoYXQuY29tPgo+IAo+IFRoYW5r
cwo+IERhdmUKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
