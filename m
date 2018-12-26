Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc1C7-00072f-8z
 for kexec@lists.infradead.org; Wed, 26 Dec 2018 04:53:27 +0000
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so13047814ljd.0
 for <kexec@lists.infradead.org>; Tue, 25 Dec 2018 20:53:11 -0800 (PST)
MIME-Version: 1.0
References: <1544987815-19527-1-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1544987815-19527-1-git-send-email-bhsharma@redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 26 Dec 2018 10:22:56 +0530
Message-ID: <CACi5LpOsT1UcXjB4NFV9n62nZWy=HJ6Qt_hFWT5UktCjtLToZg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] kexec/arm64: Fix issue with 'kexec load' and
 'kdump' when --dtb option is used
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
To: kexec mailing list <kexec@lists.infradead.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Vicente Bergas <vicencb@gmail.com>, Simon Horman <horms@verge.net.au>

SGVsbG8gVmljZW7DpywKCk9uIE1vbiwgRGVjIDE3LCAyMDE4IGF0IDEyOjQ3IEFNIEJodXBlc2gg
U2hhcm1hIDxiaHNoYXJtYUByZWRoYXQuY29tPiB3cm90ZToKPgo+IENoYW5nZXMgc2luY2UgdjI6
Cj4gLS0tLS0tLS0tLS0tLS0tLS0KPiAgLSBEcm9wcGVkIDQvNCBmcm9tIHYyIGFzIEkgbm90aWNl
ZCB0aGF0IHdlIHBhc3Mgd3Jvbmcgbm9kZSBuYW1lIHRvIGZkdAo+ICAgIGhlbHBlciBmdW5jdGlv
bnMgaW4gJ2tleGVjL2R0LW9wcy5jJwo+Cj4gVGhpcyBwYXRjaHNldCBmaXhlcyBzb21lIGlzc3Vl
cyB3aGVuIHdlIGNhbGwga2V4ZWMgZm9yIGFybTY0IHdpdGggLS1kdGIKPiBvcHRpb24gKGJvdGgg
Zm9yICdrZXhlYyBsb2FkJyBhbmQgJ2tkdW1wJyB1c2UgY2FzZXMpLgo+Cj4gQSBjb3VwbGUgb2Yg
dGhlc2UgaXNzdWVzIHdlcmUgcmVwb3J0ZWQgZm9yICdrZXhlYyBsb2FkJyB1c2UgY2FzZSBieQo+
IFZpY2Vuw6cgYW5kIEkgZm91bmQgdGhlIG90aGVyIHR3byB3aGlsZSBleHBlcmltZW50IHdpdGgg
J2tkdW1wJyB1c2UKPiBjYXNlcy4KPgo+IEkgaGF2ZSB0ZXN0ZWQgdGhlIHBhdGNoc2V0IG9uIG15
IHF1YWxjb21tLWFtYmVyd2luZyBhbmQgaHAtbW9vbnNob3QKPiBhcm02NCBib2FyZHMuCj4KPiBD
YzogU2ltb24gSG9ybWFuIDxob3Jtc0B2ZXJnZS5uZXQuYXU+Cj4gQ2M6IEFLQVNISSBUYWthaGly
byA8dGFrYWhpcm8uYWthc2hpQGxpbmFyby5vcmc+Cj4gQ2M6IFZpY2VudGUgQmVyZ2FzIDx2aWNl
bmNiQGdtYWlsLmNvbT4KPgo+IEJodXBlc2ggU2hhcm1hICg0KToKPiAgIGtleGVjL2R0LW9wcy5j
OiBGaXggY2hlY2sgYWdhaW5zdCAnZmR0X2FkZF9zdWJub2RlJyByZXR1cm4gdmFsdWUKPiAgIGtl
eGVjL2tleGVjLWFybTY0LmM6IEFkZCBlcnJvciBoYW5kbGluZyBjaGVjayBhZ2FpbnN0IHJldHVy
biB2YWx1ZSBvZgo+ICAgICAnc2V0X2Jvb3RhcmdzKCknCj4gICBrZXhlYy9kdC1vcHMuYzogRml4
IGFkZGluZyAnL2Nob3Nlbicgbm9kZSBmb3IgY2FzZXMgd2hlcmUgaXQgaXMgbm90Cj4gICAgIGF2
YWlsYWJsZSBpbiBkdGIgcGFzc2VkIHZpYSAtLWR0YiBvcHRpb24KPiAgIGtleGVjL2R0LW9wcy5j
OiBGaXggJy9jaG9zZW4nIHYvcyAnY2hvc2VuJyBub2RlIGJlaW5nIHBhc3NlZCB0byBmZHQKPiAg
ICAgaGVscGVyIGZ1bmN0aW9ucwo+Cj4gIGtleGVjL2FyY2gvYXJtNjQva2V4ZWMtYXJtNjQuYyB8
ICA1ICsrKysrCj4gIGtleGVjL2R0LW9wcy5jICAgICAgICAgICAgICAgICB8IDM2ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDM1IGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiAtLQo+IDIuNy40Cj4KCkNhbiB5b3UgcGxlYXNl
IGdpdmUgdGhpcyBwYXRjaHNldCBhIHRyeSBhdCB5b3VyIGVuZCBhbmQgc2VlIGlmIGl0CmZpeGVz
IHRoZSBpc3N1ZXMgeW91IGhhZCByZXBvcnRlZCB3aXRoIHRoZSAtLWR0YiBvcHRpb24uCgpUaGFu
a3MsCkJodXBlc2gKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
