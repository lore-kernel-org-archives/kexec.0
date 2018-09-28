Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5sch-0005fZ-UU
 for kexec@lists.infradead.org; Fri, 28 Sep 2018 13:16:01 +0000
Date: Fri, 28 Sep 2018 15:15:54 +0200
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/3] x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one
 error
Message-ID: <20180928131554.GC21895@zn.tnic>
References: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153805811578.1157.6948388946904655969.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <153805811578.1157.6948388946904655969.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
Cc: dan.j.williams@intel.com, brijesh.singh@amd.com, Lianbo Jiang <lijiang@redhat.com>, bhe@redhat.com, thomas.lendacky@amd.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

T24gVGh1LCBTZXAgMjcsIDIwMTggYXQgMDk6MjE6NTVBTSAtMDUwMCwgQmpvcm4gSGVsZ2FhcyB3
cm90ZToKPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPgo+IAo+IFRo
ZSBvbmx5IHVzZSBvZiBLRVhFQ19CQUNLVVBfU1JDX0VORCBpcyBhcyBhbiBhcmd1bWVudCB0bwo+
IHdhbGtfc3lzdGVtX3JhbV9yZXMoKToKPiAKPiAgIGludCBjcmFzaF9sb2FkX3NlZ21lbnRzKHN0
cnVjdCBraW1hZ2UgKmltYWdlKQo+ICAgewo+ICAgICAuLi4KPiAgICAgd2Fsa19zeXN0ZW1fcmFt
X3JlcyhLRVhFQ19CQUNLVVBfU1JDX1NUQVJULCBLRVhFQ19CQUNLVVBfU1JDX0VORCwKPiAgICAg
ICAgICAgICAgICAgICAgICAgICBpbWFnZSwgZGV0ZXJtaW5lX2JhY2t1cF9yZWdpb24pOwo+IAo+
IHdhbGtfc3lzdGVtX3JhbV9yZXMoKSBleHBlY3RzICJzdGFydCwgZW5kIiBhcmd1bWVudHMgdGhh
dCBhcmUgaW5jbHVzaXZlLAo+IGkuZS4sIHRoZSByYW5nZSB0byBiZSB3YWxrZWQgaW5jbHVkZXMg
Ym90aCB0aGUgc3RhcnQgYW5kIGVuZCBhZGRyZXNzZXMuCj4gCj4gS0VYRUNfQkFDS1VQX1NSQ19F
TkQgd2FzIHByZXZpb3VzbHkgZGVmaW5lZCBhcyAoNjQwICogMTAyNFVMKSwgd2hpY2ggaXMgdGhl
Cj4gZmlyc3QgYWRkcmVzcyAqcGFzdCogdGhlIGRlc2lyZWQgMC02NDBLQiByYW5nZS4KPiAKPiBE
ZWZpbmUgS0VYRUNfQkFDS1VQX1NSQ19FTkQgYXMgKDY0MCAqIDEwMjRVTCAtIDEpIHNvIHRoZSBL
RVhFQ19CQUNLVVBfU1JDCj4gcmVnaW9uIGlzIFswLTB4OWZmZmZdLCBub3QgWzAtMHhhMDAwMF0u
Cj4gCj4gRml4ZXM6IGRkNWY3MjYwNzZjYyAoImtleGVjOiBzdXBwb3J0IGZvciBrZXhlYyBvbiBw
YW5pYyB1c2luZyBuZXcgc3lzdGVtIGNhbGwiKQo+IFNpZ25lZC1vZmYtYnk6IEJqb3JuIEhlbGdh
YXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+Cj4gLS0tCj4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL2tl
eGVjLmggfCAgICAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rZXhlYy5oIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20va2V4ZWMuaAo+IGluZGV4IGYzMjcyMzZmMGZhNy4uNTEyNWZj
YTQ3MmJiIDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2tleGVjLmgKPiArKysg
Yi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rZXhlYy5oCj4gQEAgLTY3LDcgKzY3LDcgQEAgc3RydWN0
IGtpbWFnZTsKPiAgCj4gIC8qIE1lbW9yeSB0byBiYWNrdXAgZHVyaW5nIGNyYXNoIGtkdW1wICov
Cj4gICNkZWZpbmUgS0VYRUNfQkFDS1VQX1NSQ19TVEFSVAkoMFVMKQo+IC0jZGVmaW5lIEtFWEVD
X0JBQ0tVUF9TUkNfRU5ECSg2NDAgKiAxMDI0VUwpCS8qIDY0MEsgKi8KPiArI2RlZmluZSBLRVhF
Q19CQUNLVVBfU1JDX0VORAkoNjQwICogMTAyNFVMIC0gMSkJLyogNjQwSyAqLwo+ICAKPiAgLyoK
PiAgICogQ1BVIGRvZXMgbm90IHNhdmUgc3MgYW5kIHNwIG9uIHN0YWNrIGlmIGV4ZWN1dGlvbiBp
cyBhbHJlYWR5CgpSZXZpZXdlZC1ieTogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPgoKLS0g
ClJlZ2FyZHMvR3J1c3MsCiAgICBCb3Jpcy4KClNVU0UgTGludXggR21iSCwgR0Y6IEZlbGl4IElt
ZW5kw7ZyZmZlciwgSmFuZSBTbWl0aGFyZCwgR3JhaGFtIE5vcnRvbiwgSFJCIDIxMjg0IChBRyBO
w7xybmJlcmcpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
