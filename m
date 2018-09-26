Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5A1X-0004Ir-QA
 for kexec@lists.infradead.org; Wed, 26 Sep 2018 13:39:13 +0000
Subject: Re: [PATCH 0/3] find_next_iomem_res() fixes
From: lijiang <lijiang@redhat.com>
References: <20180921073211.20097-2-lijiang@redhat.com>
 <153782698067.130337.12079523922130875402.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <1894f2ba-42ab-c044-ea0c-63eab98d9815@redhat.com>
Message-ID: <4295243b-20b4-9d21-5863-bab102a6a6d9@redhat.com>
Date: Wed, 26 Sep 2018 21:36:48 +0800
MIME-Version: 1.0
In-Reply-To: <1894f2ba-42ab-c044-ea0c-63eab98d9815@redhat.com>
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
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, akpm@linux-foundation.org, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, dan.j.williams@intel.com, bp@suse.de, dyoung@redhat.com, tglx@linutronix.de, Vivek Goyal <vgoyal@redhat.com>

5ZyoIDIwMTjlubQwOeaciDI25pelIDE3OjIyLCBsaWppYW5nIOWGmemBkzoKPiAKPiAKPiDlnKgg
MjAxOOW5tDA55pyIMjXml6UgMDY6MTQsIEJqb3JuIEhlbGdhYXMg5YaZ6YGTOgo+PiBIaSBMaWFu
Ym8sCj4+Cj4+IFRoZXNlIHRocmVlIHBhdGNoZXMgYXJlIGEgcG9zc2libGUgcmVwbGFjZW1lbnQg
Zm9yIHlvdXIgZmlyc3QgcGF0Y2gKPj4gKCJbUEFUQ0ggMS8zIHYzXSByZXNvdXJjZTogZml4IGFu
IGVycm9yIHdoaWNoIHdhbGtzIHRocm91Z2ggaW9tZW0KPj4gcmVzb3VyY2VzIikuCj4+Cj4+IEkg
dGhpbmsgdGhlIGludGVyZmFjZSBvZiBmaW5kX25leHRfaW9tZW1fcmVzKCkgY2FuIGJlIGltcHJv
dmVkIHRvIG1ha2UKPj4gdGhlIGNvZGUgZWFzaWVyIHRvIHJlYWQgYW5kIGFsc28gYXZvaWQgdGhl
IGVycm9ycyB5b3UncmUgZml4aW5nLgo+Pgo+PiBJIGNhbid0IHRlc3QgdGhlc2UsIHNvIHRoZXkn
dmUgb25seSBiZWVuIGNvbXBpbGVkLiAgSWYgeW91IGNhbiB0ZXN0Cj4+IHRoZW0gYW5kIGlmIHlv
dSBsaWtlIHRoZW0sIGZlZWwgZnJlZSB0byBpbmNvcnBvcmF0ZSB0aGVtIGludG8geW91cgo+PiBz
ZXJpZXMuICBJZiBub3QsIGp1c3QgZHJvcCB0aGVtIChidXQgcGxlYXNlIGF0IGxlYXN0IGZpeCB0
aGUgc2FtZQo+PiBlcnJvciBpbiB3YWxrX3N5c3RlbV9yYW1fcmFuZ2UoKSkuCj4+Cj4gSGksIEJq
b3JuCj4gU29ycnkgZm9yIG15IGxhdGUgcmVwbHkgYWJvdXQgdGhpcy4gTm8gbmVlZCB0byBpbmNv
cnBvcmF0ZSB0aGVtIGludG8KPiBteSBwYXRjaCBzZXJpZXMsIHlvdSBtaWdodCBmcmVlbHkgc3Vi
bWl0IHRoZW0gdG8gdXBzdHJlYW0uCj4gCj4gSSB3aWxsIHRlc3QgeW91ciBwYXRjaGVzIHdoZXRo
ZXIgaXQgY2FuIGFsc28gd29yayB3ZWxsIGZvciBteSBjYXNlLCBhbmQKPiB5b3Ugd2lsbCBnZXQg
ZmVlZGJhY2sgYWJvdXQgbXkgdGVzdCBsYXRlci4KPiAKRm9yIG15IGNhc2UsIHlvdXIgcGF0Y2hl
cyBjYW4gYWxzbyB3b3JrIHdlbGwuCgo+IFRoYW5rcy4KPiBMaWFuYm8KPiAKPj4gLS0tCj4+Cj4+
IEJqb3JuIEhlbGdhYXMgKDMpOgo+PiAgICAgICB4ODYva2V4ZWM6IENvcnJlY3QgS0VYRUNfQkFD
S1VQX1NSQ19FTkQgb2ZmLWJ5LW9uZSBlcnJvcgo+PiAgICAgICByZXNvdXJjZTogSW5jbHVkZSBy
ZXNvdXJjZSBlbmQgaW4gd2Fsa18qKCkgaW50ZXJmYWNlcwo+PiAgICAgICByZXNvdXJjZTogRml4
IGZpbmRfbmV4dF9pb21lbV9yZXMoKSBpdGVyYXRpb24gaXNzdWUKPj4KPj4KPj4gIGFyY2gveDg2
L2luY2x1ZGUvYXNtL2tleGVjLmggfCAgICAyIC0KPj4gIGtlcm5lbC9yZXNvdXJjZS5jICAgICAg
ICAgICAgfCAgIDk2ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+
PiAgMiBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCA1NSBkZWxldGlvbnMoLSkKPj4K
Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4ga2V4
ZWMgbWFpbGluZyBsaXN0Cj4+IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKPj4gaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo+PgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=
