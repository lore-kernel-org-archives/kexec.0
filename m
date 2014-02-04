Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WAbPZ-00082d-1T
 for kexec@lists.infradead.org; Tue, 04 Feb 2014 08:31:17 +0000
Date: Tue, 4 Feb 2014 17:30:53 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Avoid buffer overflow on strncat usage
Message-ID: <20140204083053.GC30621@verge.net.au>
References: <CAL5wTH6B-QYbY9bcC+HuBJkk=rEEZhQsggi921YtbGNS4xUfxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL5wTH6B-QYbY9bcC+HuBJkk=rEEZhQsggi921YtbGNS4xUfxQ@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dirk =?utf-8?Q?M=C3=BCller?= <dirk@dmllr.de>
Cc: kexec@lists.infradead.org

T24gTW9uLCBGZWIgMDMsIDIwMTQgYXQgMDY6NTQ6NTJQTSArMDEwMCwgRGlyayBNw7xsbGVyIHdy
b3RlOgo+IHN0cm5jYXQoKSBkb2VzIG5vdCB3YW50IHRoZSB0b3RhbCBzaXplIGJ1dCB0aGUgbWF4
aW11bSBsZW5ndGguCj4gCj4gU2lnbmVkLW9mZi1ieTogRGlyayBNdWVsbGVyIDxkbXVlbGxlckBz
dXNlLmNvbT4KPiAtLS0KPiAga2V4ZWMvZnMyZHQuYyB8IDQgKystLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9rZXhl
Yy9mczJkdC5jIGIva2V4ZWMvZnMyZHQuYwo+IGluZGV4IDczYzFmYjkuLjY1YThiNjYgMTAwNjQ0
Cj4gLS0tIGEva2V4ZWMvZnMyZHQuYwo+ICsrKyBiL2tleGVjL2ZzMmR0LmMKPiBAQCAtNjQ5LDgg
KzY0OSw4IEBAIHN0YXRpYyB2b2lkIHB1dG5vZGUodm9pZCkKPiAgICAgICAgICAgICAgICAgICAg
ICAgICBnb3RvIG5vX2RlYnVnOwo+ICAgICAgICAgICAgICAgICB9Cj4gICAgICAgICAgICAgICAg
IHN0cm5jcHkoZmlsZW5hbWUsICIvcHJvYy9kZXZpY2UtdHJlZS8iLCBNQVhQQVRIKTsKPiAtICAg
ICAgICAgICAgICAgc3RybmNhdChmaWxlbmFtZSwgYnVmZiwgTUFYUEFUSCk7Cj4gLSAgICAgICAg
ICAgICAgIHN0cm5jYXQoZmlsZW5hbWUsICIvY29tcGF0aWJsZSIsIE1BWFBBVEgpOwo+ICsgICAg
ICAgICAgICAgICBzdHJuY2F0KGZpbGVuYW1lLCBidWZmLCBNQVhQQVRILXN0cmxlbihmaWxlbmFt
ZSktMSk7Cj4gKyAgICAgICAgICAgICAgIHN0cm5jYXQoZmlsZW5hbWUsICIvY29tcGF0aWJsZSIs
IE1BWFBBVEgtc3RybGVuKGZpbGVuYW1lKS0xKTsKCkkgZG9uJ3QgdGhpbmsgeW91IG5lZWQgdGhl
IC0xIGFzIGZpbGVuYW1lIHdpbGwgaGF2ZSBhIHRyYWlsaW5nICdcMCcKd2hpY2ggaXMgbm90IGNv
dW50ZWQgaW4gdGhlIHJldHVybiB2YWx1ZSBvZiBzdHJsZW4oKQoKQWxzbywgY291bGQgeW91IHBs
ZWFzZSBwdXQgYSBzcGFjZSBvbiBlYWNoIHNpZGUgb2YgZWFjaCAnLSc/CgpUaGFua3MKCj4gICAg
ICAgICAgICAgICAgIGZkID0gb3BlbihmaWxlbmFtZSwgT19SRE9OTFkpOwo+ICAgICAgICAgICAg
ICAgICBpZiAoZmQgPT0gLTEpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICBwcmludGYoIlVu
YWJsZSB0byBmaW5kICVzIHByaW50aW5nIGZyb20KPiBwdXJnYXRvcnkgaXMgZGlhYmxlZFxuIiwK
PiAtLSAKPiAxLjguNC4xCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiBrZXhlYyBtYWlsaW5nIGxpc3QKPiBrZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo+
IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
