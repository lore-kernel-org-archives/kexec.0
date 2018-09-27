Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5WBD-0000Su-M0
 for kexec@lists.infradead.org; Thu, 27 Sep 2018 13:18:25 +0000
Date: Thu, 27 Sep 2018 15:17:37 +0200
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v7 RESEND 1/4] x86/ioremap: add a function
 ioremap_encrypted() to remap kdump old memory
Message-ID: <20180927131737.GA19779@zn.tnic>
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180927071954.29615-2-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: thomas.lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

T24gVGh1LCBTZXAgMjcsIDIwMTggYXQgMDM6MTk6NTFQTSArMDgwMCwgTGlhbmJvIEppYW5nIHdy
b3RlOgo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pby5oIGIvYXJjaC94ODYv
aW5jbHVkZS9hc20vaW8uaAo+IGluZGV4IDZkZTY0ODQwZGQyMi4uZjg3OTVmOTU4MWM3IDEwMDY0
NAo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2lvLmgKPiArKysgYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9pby5oCj4gQEAgLTE5Miw2ICsxOTIsOSBAQCBleHRlcm4gdm9pZCBfX2lvbWVtICpp
b3JlbWFwX2NhY2hlKHJlc291cmNlX3NpemVfdCBvZmZzZXQsIHVuc2lnbmVkIGxvbmcgc2l6ZSk7
Cj4gICNkZWZpbmUgaW9yZW1hcF9jYWNoZSBpb3JlbWFwX2NhY2hlCj4gIGV4dGVybiB2b2lkIF9f
aW9tZW0gKmlvcmVtYXBfcHJvdChyZXNvdXJjZV9zaXplX3Qgb2Zmc2V0LCB1bnNpZ25lZCBsb25n
IHNpemUsIHVuc2lnbmVkIGxvbmcgcHJvdF92YWwpOwo+ICAjZGVmaW5lIGlvcmVtYXBfcHJvdCBp
b3JlbWFwX3Byb3QKPiArZXh0ZXJuIHZvaWQgX19pb21lbSAqaW9yZW1hcF9lbmNyeXB0ZWQocmVz
b3VyY2Vfc2l6ZV90IHBoeXNfYWRkciwKPiArCQkJCQl1bnNpZ25lZCBsb25nIHNpemUpOwoKTm8g
bmVlZCB0byBicmVhayB0aGlzIGxpbmUgLSBzZWUgaG93IHRoZSBvdGhlciBleHRlcm5zIGRvbid0
LgoKPiArI2RlZmluZSBpb3JlbWFwX2VuY3J5cHRlZCBpb3JlbWFwX2VuY3J5cHRlZAo+ICAKPiAg
LyoqCj4gICAqIGlvcmVtYXAgICAgIC0gICBtYXAgYnVzIG1lbW9yeSBpbnRvIENQVSBzcGFjZQo+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9pb3JlbWFwLmMgYi9hcmNoL3g4Ni9tbS9pb3JlbWFw
LmMKPiBpbmRleCBjNjNhNTQ1ZWMxOTkuLmUwMWU2YzY5NWFkZCAxMDA2NDQKPiAtLS0gYS9hcmNo
L3g4Ni9tbS9pb3JlbWFwLmMKPiArKysgYi9hcmNoL3g4Ni9tbS9pb3JlbWFwLmMKPiBAQCAtMjQs
NiArMjQsNyBAQAo+ICAjaW5jbHVkZSA8YXNtL3BnYWxsb2MuaD4KPiAgI2luY2x1ZGUgPGFzbS9w
YXQuaD4KPiAgI2luY2x1ZGUgPGFzbS9zZXR1cC5oPgo+ICsjaW5jbHVkZSA8bGludXgvY3Jhc2hf
ZHVtcC5oPgoKV2hhdCBpcyB0aGF0IGluY2x1ZGUgZm9yIGFuZCB3aHkgaXMgaXQgbm90IHVwIHRo
ZXJlIHdpdGggdGhlIDxsaW51eC8uLi4KaW5jbHVkZXMgaW5zdGVhZCBoZXJlIHdpdGggdGhlIDxh
c20vLi4+IG9uZXM/CgotLSAKUmVnYXJkcy9HcnVzcywKICAgIEJvcmlzLgoKU1VTRSBMaW51eCBH
bWJILCBHRjogRmVsaXggSW1lbmTDtnJmZmVyLCBKYW5lIFNtaXRoYXJkLCBHcmFoYW0gTm9ydG9u
LCBIUkIgMjEyODQgKEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
