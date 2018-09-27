Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5XgR-0006yt-68
 for kexec@lists.infradead.org; Thu, 27 Sep 2018 14:54:30 +0000
Subject: Re: [PATCH v7 RESEND 1/4] x86/ioremap: add a function
 ioremap_encrypted() to remap kdump old memory
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-2-lijiang@redhat.com> <20180927131737.GA19779@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <6306eaa9-d81e-2fa4-8978-63503a7ecce4@redhat.com>
Date: Thu, 27 Sep 2018 22:53:47 +0800
MIME-Version: 1.0
In-Reply-To: <20180927131737.GA19779@zn.tnic>
Content-Language: en-US
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
To: Borislav Petkov <bp@suse.de>
Cc: thomas.lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

5ZyoIDIwMTjlubQwOeaciDI35pelIDIxOjE3LCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IFRodSwgU2VwIDI3LCAyMDE4IGF0IDAzOjE5OjUxUE0gKzA4MDAsIExpYW5ibyBKaWFuZyB3cm90
ZToKPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2lvLmggYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9pby5oCj4+IGluZGV4IDZkZTY0ODQwZGQyMi4uZjg3OTVmOTU4MWM3IDEwMDY0
NAo+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pby5oCj4+ICsrKyBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2lvLmgKPj4gQEAgLTE5Miw2ICsxOTIsOSBAQCBleHRlcm4gdm9pZCBfX2lvbWVt
ICppb3JlbWFwX2NhY2hlKHJlc291cmNlX3NpemVfdCBvZmZzZXQsIHVuc2lnbmVkIGxvbmcgc2l6
ZSk7Cj4+ICAjZGVmaW5lIGlvcmVtYXBfY2FjaGUgaW9yZW1hcF9jYWNoZQo+PiAgZXh0ZXJuIHZv
aWQgX19pb21lbSAqaW9yZW1hcF9wcm90KHJlc291cmNlX3NpemVfdCBvZmZzZXQsIHVuc2lnbmVk
IGxvbmcgc2l6ZSwgdW5zaWduZWQgbG9uZyBwcm90X3ZhbCk7Cj4+ICAjZGVmaW5lIGlvcmVtYXBf
cHJvdCBpb3JlbWFwX3Byb3QKPj4gK2V4dGVybiB2b2lkIF9faW9tZW0gKmlvcmVtYXBfZW5jcnlw
dGVkKHJlc291cmNlX3NpemVfdCBwaHlzX2FkZHIsCj4+ICsJCQkJCXVuc2lnbmVkIGxvbmcgc2l6
ZSk7Cj4gCj4gTm8gbmVlZCB0byBicmVhayB0aGlzIGxpbmUgLSBzZWUgaG93IHRoZSBvdGhlciBl
eHRlcm5zIGRvbid0Lgo+IApPaywgaSB3aWxsIGZpeCBpdC4gCgpJZiBubyBuZWVkIHRvIGJyZWFr
IHRoaXMgbGluZSwgaXQgd2lsbCBjYXVzZSBhIHdhcm5pbmcgb2YgZXhjZWVkaW5nIDgwIGNoYXJh
Y3RlcnMgcGVyIGxpbmUuCgo+PiArI2RlZmluZSBpb3JlbWFwX2VuY3J5cHRlZCBpb3JlbWFwX2Vu
Y3J5cHRlZAo+PiAgCj4+ICAvKioKPj4gICAqIGlvcmVtYXAgICAgIC0gICBtYXAgYnVzIG1lbW9y
eSBpbnRvIENQVSBzcGFjZQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vaW9yZW1hcC5jIGIv
YXJjaC94ODYvbW0vaW9yZW1hcC5jCj4+IGluZGV4IGM2M2E1NDVlYzE5OS4uZTAxZTZjNjk1YWRk
IDEwMDY0NAo+PiAtLS0gYS9hcmNoL3g4Ni9tbS9pb3JlbWFwLmMKPj4gKysrIGIvYXJjaC94ODYv
bW0vaW9yZW1hcC5jCj4+IEBAIC0yNCw2ICsyNCw3IEBACj4+ICAjaW5jbHVkZSA8YXNtL3BnYWxs
b2MuaD4KPj4gICNpbmNsdWRlIDxhc20vcGF0Lmg+Cj4+ICAjaW5jbHVkZSA8YXNtL3NldHVwLmg+
Cj4+ICsjaW5jbHVkZSA8bGludXgvY3Jhc2hfZHVtcC5oPgo+IAo+IFdoYXQgaXMgdGhhdCBpbmNs
dWRlIGZvciBhbmQgd2h5IGlzIGl0IG5vdCB1cCB0aGVyZSB3aXRoIHRoZSA8bGludXgvLi4uCj4g
aW5jbHVkZXMgaW5zdGVhZCBoZXJlIHdpdGggdGhlIDxhc20vLi4+IG9uZXM/Cj4gClRoYW5rIHlv
dSBmb3IgcG9pbnRpbmcgb3V0IHRoaXMgaXNzdWUsIGkgZm9yZ290IHRvIHJlbW92ZSB0aGlzIGhl
YWRlciBmaWxlLiAKCkkgd2lsbCBnZXQgcmlkIG9mIHRoaXMgaGVhZGVyIGZpbGUgYW5kIHBvc3Qg
dGhpcyBwYXRjaCBhZ2Fpbi4KClJlZ2FyZHMsCkxpYW5ibwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
