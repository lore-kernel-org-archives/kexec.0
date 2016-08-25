Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bcpkn-00034n-TX
 for kexec@lists.infradead.org; Thu, 25 Aug 2016 08:11:14 +0000
Received: by mail-wm0-f41.google.com with SMTP id i5so58947767wmg.0
 for <kexec@lists.infradead.org>; Thu, 25 Aug 2016 01:10:52 -0700 (PDT)
Date: Thu, 25 Aug 2016 10:10:49 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: Capturing crash with 4.6.0 and above kernel does not work
Message-ID: <20160825081049.GA4235@dhcp22.suse.cz>
References: <0140312F-1DD9-4CC7-9484-32F8570B5089@qlogic.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0140312F-1DD9-4CC7-9484-32F8570B5089@qlogic.com>
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
To: Himanshu Madhani <himanshu.madhani@qlogic.com>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

W0xldCdzIGFkZCBrZHVtcCBwZW9wbGVdCgpPbiBXZWQgMjQtMDgtMTYgMTY6Mzg6NTYsIEhpbWFu
c2h1IE1hZGhhbmkgd3JvdGU6Cj4gSGVsbG8gbGlzdCwKPiAKPiBJIGFtIHdvbmRlcmluZyBpZiBh
bnlib2R5IGhhcyBpc3N1ZSBjYXB0dXJpbmcgY3Jhc2ggZHVtcCB3aXRoIHRoZSA0LjYuMCBhbmQg
YWJvdmUga2VucmVsLgo+IAo+IEkgaGF2ZSBhIHN5c3RlbSwgd2hlbiBib290ZWQgaW4gNC41Ljcg
a2VybmVsIGlzIGFibGUgdG8gY2FwdHVyZSBjcmFzaCBkdW1wLgo+IEhvd2V2ZXIsIHdoZW4gSSBi
b290IHRoaXMgc3lzdGVtIGluIDQuNi40IGFuZCA0LjcuMiBrZXJuZWwsIGNyYXNoIGR1bXAgaXMg
bm90IAo+IGFibGUgdG8gY2FwdHVyZSBhbnkgY3Jhc2guIAo+IAo+IEkgYW0gc3RpbGwgZmFjaW5n
IHNhbWUgaXNzdWUgd2l0aCA0LjguMC1yYzIrIGtlcm5lbCBhbmQgZnJvbSB0aGUgZXJyb3IgYXQg
dGhlIGNvbW1hbmQgcHJvbXB0LCAKPiBpdCBzZWVtcyBsaWtlIGtleGVjIGlzIGlnbm9yaW5nIOKA
nGNyYXNoa2VucmVs4oCdIHBhcmFtZXRlci4gCj4gCj4gSSBhZGRlZCBiZWxvdyBpbmZvcm1hdGlv
biBpbiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTExOTI5MS4g
Cj4gCj4gIyB1bmFtZSAtcgo+IDQuOC4wLXJjMisKPiAKPiAjIGNhdCAvcHJvYy9jbWRsaW5lIAo+
IHJvIHJvb3Q9L2Rldi9tYXBwZXIvdmdfZHV0NDExMC1sdl9yb290IHJkX05PX0xVS1MgIEtFWUJP
QVJEVFlQRT1wYyBLRVlUQUJMRT11cyBMQU5HPWVuX1VTLlVURi04IHJkX05PX01EIFNZU0ZPTlQ9
bGF0YXJjeXJoZWItc3VuMTYgY3Jhc2hrZXJuZWw9NTEyTSByZF9MVk1fTFY9dmdfZHV0NDExMC9s
dl9zd2FwIHJkX0xWTV9MVj12Z19kdXQ0MTEwL2x2X3Jvb3QgcmRfTk9fRE0gcmhnYiBxdWlldAo+
IAo+ICMgc2VydmljZSBrZHVtcCBzdGF0dXMKPiBLZHVtcCBpcyBub3Qgb3BlcmF0aW9uYWwKPiAK
PiAjIHNlcnZpY2Uga2R1bXAgc3RhcnQKPiBNZW1vcnkgZm9yIGNyYXNoa2VybmVsIGlzIG5vdCBy
ZXNlcnZlZAo+IFBsZWFzZSByZXNlcnZlIG1lbW9yeSBieSBwYXNzaW5nICJjcmFzaGtlcm5lbD1Y
QFkiIHBhcmFtZXRlciB0byB0aGUga2VybmVsCj4gU3RhcnRpbmcga2R1bXA6ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbRkFJTEVEXQoKSXQgc21lbGxzIGxpa2Ug
dGhlIGNyYXNoIGtlcm5lbCByZXNlcnZhdGlvbiBoYXMgZmFpbGVkLiBDb3VsZCB5b3UKcHJvdmlk
ZSB0aGUgZnVsbCBrZXJuZWwgbG9nPwoKPiBtZXNzYWdlIGZpbGUgY29uZmlybXMgdGhhdCBrZXhl
YyB3YXMgbm90IGFibGUgdG8gc3RhcnQgdGhlIHNlcnZpY2UgCj4gCj4gQXVnIDE1IDEwOjQxOjE3
IGR1dDQxMTAga2R1bXA6IGtleGVjOiBmYWlsZWQgdG8gbG9hZCBrZHVtcCBrZXJuZWwKPiBBdWcg
MTUgMTA6NDE6MTcgZHV0NDExMCBrZHVtcDogZmFpbGVkIHRvIHN0YXJ0IHVwCj4gCj4gTm90ZSwg
dGhhdCBzYW1lIG9wdGlvbiBpcyBhYmxlIHRvIGxvYWQga2R1bXAgc2VydmljZSBmb3IgNC41Ljcg
a2VybmVsLiAgCj4gCj4gSSBjYW4gcHJvdmlkZSBhbnkgZGV0YWlscyBuZWVkZWQgdG8gaGVscCBy
ZXNvbHZlIHRoaXMgaXNzdWUuIAo+IAo+IFRoYW5rcywKPiAtIEhpbWFuc2h1Cj4gCgotLSAKTWlj
aGFsIEhvY2tvClNVU0UgTGFicwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
