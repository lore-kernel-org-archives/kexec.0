Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFc3A-0002oj-F5
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 03:08:21 +0000
Date: Tue, 12 Mar 2013 23:08:17 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1589213774.196580.1363144097993.JavaMail.root@redhat.com>
In-Reply-To: <526259845.192944.1363143172053.JavaMail.root@redhat.com>
Subject: Re: failed to compile kexec from git
MIME-Version: 1.0
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
To: kexec <kexec@lists.infradead.org>
Cc: Simon Horman <horms@verge.net.au>, Cliff Wickman <cpw@sgi.com>

SWYgSSByZXZlcnQgdGhpcyBjb21taXQsCjZkZjE1ZDFjY2E1NWIyY2Q1OWM3OWFlZDY5ZjAwNGUx
YjJhNmJhMzYKa2V4ZWMgeDg2OiBkcm9wIHRydW5jYXRpb24gd2FybmluZyBmb3IgY3Jhc2gga2Vy
bmVsCgpFdmVyeXRoaW5nIGlzIGZpbmUgYWdhaW4uCgpDQUkgUWlhbgoKLS0tLS0gT3JpZ2luYWwg
TWVzc2FnZSAtLS0tLQo+IEZyb206ICJDQUkgUWlhbiIgPGNhaXFpYW5AcmVkaGF0LmNvbT4KPiBU
bzogImtleGVjIiA8a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZz4KPiBTZW50OiBXZWRuZXNkYXks
IE1hcmNoIDEzLCAyMDEzIDEwOjUyOjUyIEFNCj4gU3ViamVjdDogZmFpbGVkIHRvIGNvbXBpbGUg
a2V4ZWMgZnJvbSBnaXQKPiAKPiBMb29rcyBsaWtlIHRoaXMgaXMgYnJva2VuIHJlY2VudGx5LiBJ
IGNsb25lZCB0aGUgdHJlZQo+IGF0IHRoZSB0b3AgY29tbWl0IGJlZW4sCj4gCj4gZTczZDQ4MWM0
YWRkMTdlZTk1M2M4MGJiNGJlNzIzNzJkOTBkOTNkMwo+IHBwYy91SW1hZ2U6IEFkZCBzdXBwb3J0
IGZvciBSQU0gRGlza3MKPiAKPiBUaGVuLCBlcnJvciBvdXQuCj4gCj4ga2V4ZWMvYXJjaC9pMzg2
L3g4Ni1saW51eC1zZXR1cC5jOiBJbiBmdW5jdGlvbgo+IOKAmHNldHVwX2xpbnV4X3N5c3RlbV9w
YXJhbWV0ZXJz4oCZOgo+IGtleGVjL2FyY2gvaTM4Ni94ODYtbGludXgtc2V0dXAuYzo1MTE6OTog
ZXJyb3I6IOKAmGtleGVjX2ZsYWdz4oCZCj4gdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMg
ZnVuY3Rpb24pCj4ga2V4ZWMvYXJjaC9pMzg2L3g4Ni1saW51eC1zZXR1cC5jOjUxMTo5OiBub3Rl
OiBlYWNoIHVuZGVjbGFyZWQKPiBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3Ig
ZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCj4gbWFrZTogKioqIFtrZXhlYy9hcmNoL2kzODYv
eDg2LWxpbnV4LXNldHVwLm9dIEVycm9yIDEKPiAKPiBDQUkgUWlhbgo+IAo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4ga2V4ZWMgbWFpbGluZyBsaXN0
Cj4ga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
