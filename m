Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WzUZl-0005Ei-GF
 for kexec@lists.infradead.org; Tue, 24 Jun 2014 17:32:10 +0000
Date: Tue, 24 Jun 2014 13:31:25 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 11/13] kexec-bzImage: Support for loading bzImage using
 64bit entry
Message-ID: <20140624173125.GA18045@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-12-git-send-email-vgoyal@redhat.com>
 <20140615163515.GA17016@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140615163515.GA17016@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, gong.chen@linux.intel.com, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

T24gU3VuLCBKdW4gMTUsIDIwMTQgYXQgMDY6MzU6MTVQTSArMDIwMCwgQm9yaXNsYXYgUGV0a292
IHdyb3RlOgoKWy4uXQo+ID4gK2ludCBrZXhlY19zZXR1cF9pbml0cmQoc3RydWN0IGJvb3RfcGFy
YW1zICpwYXJhbXMsCj4gPiArCQl1bnNpZ25lZCBsb25nIGluaXRyZF9sb2FkX2FkZHIsIHVuc2ln
bmVkIGxvbmcgaW5pdHJkX2xlbikKPiA+ICt7Cj4gPiArCXBhcmFtcy0+aGRyLnJhbWRpc2tfaW1h
Z2UgPSBpbml0cmRfbG9hZF9hZGRyICYgMHhmZmZmZmZmZlVMOwo+ID4gKwlwYXJhbXMtPmhkci5y
YW1kaXNrX3NpemUgPSBpbml0cmRfbGVuICYgMHhmZmZmZmZmZlVMOwo+IAo+IFdlIGhhdmUgbW9y
ZSByZWFkYWJsZSBHRU5NQVNLKiBtYWNyb3MgZm9yIGNvbnRpZ3VvdXMgbWFza3MuIFRoaXMgb25l
Cj4gd2lsbCB0aGVuIGxvb2sgbGlrZToKPiAKPiAJcGFyYW1zLT5oZHIucmFtZGlza19pbWFnZSA9
IGluaXRyZF9sb2FkX2FkZHIgJiBHRU5NQVNLKDMxLCAwKTsKPiAJcGFyYW1zLT5oZHIucmFtZGlz
a19zaXplID0gaW5pdHJkX2xlbiAmIEdFTk1BU0soMzEsIDApOwo+IAo+IGFuZCB0aGlzIHdheSB3
ZSBrbm93IGV4YWN0bHkgYWJvdXQgd2hpY2ggYml0cyBhcmUgd2UgdGFsa2luZyBhYm91dC4gOikK
ClsgQ0MgZ29uZy5jaGVuQGxpbnV4LmludGVsLmNvbSBdCgpHRU5NQVNLKDMxLDApIG91dHB1dHMg
Y29tcGlsYXRpb24gd2FybmluZy4KCmFyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjLmM6IElu
IGZ1bmN0aW9uIOKAmGtleGVjX3NldHVwX2luaXRyZOKAmToKYXJjaC94ODYva2VybmVsL21hY2hp
bmVfa2V4ZWMuYzozMDoyOiB3YXJuaW5nOiBsZWZ0IHNoaWZ0IGNvdW50ID49IHdpZHRoCm9mIHR5
cGUgW2VuYWJsZWQgYnkgZGVmYXVsdF0KICBwYXJhbXMtPmhkci5yYW1kaXNrX2ltYWdlID0gaW5p
dHJkX2xvYWRfYWRkciAmIEdFTk1BU0soMzEsIDApOwogIF4KYXJjaC94ODYva2VybmVsL21hY2hp
bmVfa2V4ZWMuYzozMToyOiB3YXJuaW5nOiBsZWZ0IHNoaWZ0IGNvdW50ID49IHdpZHRoCm9mIHR5
cGUgW2VuYWJsZWQgYnkgZGVmYXVsdF0KICBwYXJhbXMtPmhkci5yYW1kaXNrX3NpemUgPSBpbml0
cmRfbGVuICYgR0VOTUFTSygzMSwgMCk7CiAgXgphcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhl
Yy5jOiBJbiBmdW5jdGlvbiDigJhrZXhlY19zZXR1cF9jbWRsaW5l4oCZOgphcmNoL3g4Ni9rZXJu
ZWwvbWFjaGluZV9rZXhlYy5jOjUyOjI6IHdhcm5pbmc6IGxlZnQgc2hpZnQgY291bnQgPj0gd2lk
dGgKb2YgdHlwZSBbZW5hYmxlZCBieSBkZWZhdWx0XQogIGNtZGxpbmVfbG93XzMyID0gY21kbGlu
ZV9wdHJfcGh5cyAmIEdFTk1BU0soMzEsIDApOwoKSSB0aGluayBwcm9ibGVtIGlzIHRoYXQgd2Ug
c2hpZnQgMSBieSAzMiBiaXRzIGluIHRoaXMgY2FzZSAoMzEgLSAwICsgMSkgYW5kCnRoYXQgb3Zl
cmZsb3dzIHRoZSBzaXplIG9mIHVuc2lnbmVkLiBTbyB0aGVyZSBpcyB0aGlzIGNvcm5lciBjYXNl
IHdoZXJlIAppdCBkb2VzIG5vdCBzZWVtIHRvIHdvcmsgKG9yIGF0bGVhc3Qgb3V0cHV0cyB3YXJu
aW5nKS4KClRoYW5rcwpWaXZlawoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
