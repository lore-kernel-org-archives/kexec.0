Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9vv1-0002SX-39
 for kexec@lists.infradead.org; Tue, 09 Oct 2018 17:35:40 +0000
Date: Tue, 9 Oct 2018 19:35:26 +0200
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 3/3] resource: Fix find_next_iomem_res() iteration issue
Message-ID: <20181009173526.GD17073@zn.tnic>
References: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153805812916.1157.177580438135143788.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180928164108.GE21895@zn.tnic>
 <CAErSpo7fO-bNCzxRXtREfs82OKjd0h3Yu8y+Ova7bhe3NyMd=w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAErSpo7fO-bNCzxRXtREfs82OKjd0h3Yu8y+Ova7bhe3NyMd=w@mail.gmail.com>
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
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, brijesh.singh@amd.com, lijiang@redhat.com, Baoquan He <bhe@redhat.com>, thomas.lendacky@amd.com, Takashi Iwai <tiwai@suse.de>, x86@kernel.org, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>, baiyaowei@cmss.chinamobile.com, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, dyoung@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

T24gVHVlLCBPY3QgMDksIDIwMTggYXQgMTI6MzA6MzNQTSAtMDUwMCwgQmpvcm4gSGVsZ2FhcyB3
cm90ZToKPiBTb3JyeSwgSSBkb24ndCBrbm93IHdoYXQgaGFwcGVuZWQgaGVyZSBiZWNhdXNlIEkg
ZGlkbid0IHNlZSB0aGVzZQo+IGNvbW1lbnRzIHVudGlsIHRvZGF5LiAgSSBzdXNwZWN0IHdoYXQg
aGFwcGVuZWQgd2FzIHRoYXQgbXkgR21haWwKPiBmaWx0ZXIgYXV0by1maWxlZCB0aGVtIGluIG15
IGxpbnV4LWtlcm5lbCBmb2xkZXIsIHdoaWNoIEkgZG9uJ3QgcmVhZC4KPiBPbiBteSBAZ29vZ2xl
LmNvbSBhY2NvdW50LCBJIGhhdmUgYW5vdGhlciBmaWx0ZXIgdGhhdCBwdWxsIG91dCB0aGluZ3MK
PiBhZGRyZXNzZWQgZGlyZWN0bHkgdG8gbWUsIHdoaWNoIEkgKmRvKiByZWFkLiAgQnV0IHRoaXMg
dGhyZWFkIGRpZG4ndAo+IGNjIHRoYXQgYWNjb3VudCB1bnRpbCB0aGUgdGlwLWJvdCBtZXNzYWdl
LCB3aGljaCAqZGlkKiBjYyBteSBAZ29vZ2xlCj4gYWNjb3VudCBiZWNhdXNlIHRoYXQncyBob3cg
SSBzaWduZWQgb2ZmIHRoZSBwYXRjaGVzLiAgU2lnaC4KCk5vIHdvcnJpZXMsIGl0IGFsbCBzaG91
bGQgYmUgdGFrZW4gY2FyZSBvZiBub3chIDotKQoKPiBBbnl3YXksIGl0IGxvb2tzIGxpa2UgdGhp
cyBzdHVmZiBpcyBvbiBpdHMgd2F5OyBsZXQgbWUga25vdwo+IChiaGVsZ2Fhc0Bnb29nbGUuY29t
KSBpZiBJIHNob3VsZCBkbyBhbnl0aGluZyBlbHNlLiAgSSB3b3VsZCBhZGRyZXNzCj4geW91ciBj
b21tZW50cyBhYm92ZSwgYnV0IHNpbmNlIHRoaXMgc2VlbXMgdG8gYmUgYXBwbGllZCBhbmQgSSBz
YXcgYQo+IGNsZWFudXAgcGF0Y2ggZnJvbSB5b3UsIEkgYXNzdW1lIHlvdSBhbHJlYWR5IHRvb2sg
Y2FyZSBvZiB0aGVtLgoKWWVhaCwgSSB0aGluayBJJ3ZlIGNvdmVyZWQgdGhlbSBhbGwgYnV0IGlm
IHlvdSBzZWUgc29tZXRoaW5nIG91dCBvZiB0aGUKb3JkaW5hcnksIGxldCBtZSBrbm93IHNvIHRo
YXQgSSBjYW4gZml4IGl0LgoKVGhhbmtzIQoKLS0gClJlZ2FyZHMvR3J1c3MsCiAgICBCb3Jpcy4K
ClNVU0UgTGludXggR21iSCwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlciwgSmFuZSBTbWl0aGFyZCwg
R3JhaGFtIE5vcnRvbiwgSFJCIDIxMjg0IChBRyBOw7xybmJlcmcpCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
