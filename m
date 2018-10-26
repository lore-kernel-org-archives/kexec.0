Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gGB1U-0002Ha-T4
 for kexec@lists.infradead.org; Fri, 26 Oct 2018 22:56:10 +0000
Received: by mail-lj1-f193.google.com with SMTP id z21-v6so2606945ljz.0
 for <kexec@lists.infradead.org>; Fri, 26 Oct 2018 15:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAAMcf8BU+ifd5JEC11maz=uxR+iU4myP_J3Oyy6MfWUo2AqTwA@mail.gmail.com>
In-Reply-To: <CAAMcf8BU+ifd5JEC11maz=uxR+iU4myP_J3Oyy6MfWUo2AqTwA@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Sat, 27 Oct 2018 04:25:43 +0530
Message-ID: <CACi5LpNWhdfh4sLgv_7p9rrmJYfr-3tkBrLZj6AOt2Yp4EcVhQ@mail.gmail.com>
Subject: Re: [BUG] Set device tree bootargs failed when DTB does not contain a
 chosen node.
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
To: vicencb@gmail.com
Cc: Simon Horman <horms@verge.net.au>, kexec mailing list <kexec@lists.infradead.org>

SGkgVmljZW7DpywKCk9uIEZyaSwgT2N0IDI2LCAyMDE4IGF0IDY6NDIgUE0gVmljZW50ZSBCZXJn
YXMgPHZpY2VuY2JAZ21haWwuY29tPiB3cm90ZToKPgo+IEhlbGxvLAo+IHdoZW4gZXhlY3V0aW5n
Cj4gICBrZXhlYyAtZCAtLWR0YiBkdGJfd2l0aG91dF9jaG9zZW5fbm9kZS5kdGIgLS1hcHBlbmQg
J2NtZGxpbmUnIC0tbG9hZCBJbWFnZQo+IGl0IHJlcG9ydHMKPiAgIGR0Yl9zZXRfcHJvcGVydHk6
IGZkdF9hZGRfc3Vibm9kZSBmYWlsZWQ6IDx2YWxpZCBvZmZzZXQvbGVuZ3RoPgo+ICAga2V4ZWM6
IFNldCBkZXZpY2UgdHJlZSBib290YXJncyBmYWlsZWQuCj4KPiBJdCBoYXMgYmVlbiB0ZXN0ZWQg
b24gdGhlIGFybTY0IGFyY2hpdGVjdHVyZSB3aXRoIHZlcnNpb24gdjIuMC4xNyBhbmQKPiB2Mi4w
LjE4LXJjMQoKQ2FuIHlvdSBzaGFyZSBzb21lIGRldGFpbHMgb24gdGhlIHVuZGVybHlpbmcgcGxh
dGZvcm0gYW5kIGtlcm5lbAp2ZXJzaW9uIHlvdSBhcmUgdXNpbmc/CgpMb29raW5nIGF0IHRoZSBs
b2dzLCBJIGFtIGFzc3VtaW5nIHlvdSBhcmUgcnVubmluZyAna2V4ZWMnIG9uIGEgYXJtNjQKcGxh
dGZvcm0gKGFzIGl0IGRlcGVuZHMgb24gY3JlYXRpbmcgYSBkdGIgdG8gYmUgcGFzc2VkIHRvIHRo
ZSAybmQKa2VybmVsKS4KCk15IGdlbmVyYWwgYWR2aWNlIGlzIHRvIGF2b2lkIHRoZSAtLWR0YiBv
cHRpb24gYXMgaXQgaXMga25vd24gdG8gY2F1c2UKaXNzdWVzIHdpdGgga2V4ZWMgaW4gdGhlIHBh
c3QgKHNlZSBbMF0gZm9yIGRldGFpbHMpCklkZWFsbHksIGlmIHlvdSBkb24ndCB1c2UgdGhlIC0t
ZHRiIG9wdGlvbiwgdGhlbiBrZXhlYyB3aWxsIHJlYWQgdGhlIGV4aXN0aW5nCmtlcm5lbCdzIGR0
YiBmcm9tIC9wcm9jL2RldmljZS10cmVlLCBhbmQgdGhhdCBkZXZpY2UgdHJlZSB3aWxsIGluY2x1
ZGUKYWxsIHRoZSBjaGFuZ2VzIHRoYXQgdGhlIGJvb3QgbG9hZGVyIGhhcyBkb25lLCBpbmNsdWRp
bmcgYWRkaW5nIGRldGFpbHMKb2YgdGhlIGF2YWlsYWJsZSBtZW1vcnkgaW4gdGhlIHN5c3RlbS4K
ClswXS4gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvYXJtLWtlcm5lbC9tc2c2MTgyMzYu
aHRtbAoKSG9wZSB0aGlzIGhlbHBzLgoKUmVnYXJkcywKQmh1cGVzaAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
