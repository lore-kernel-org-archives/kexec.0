Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5sXo-0003DW-EC
 for kexec@lists.infradead.org; Fri, 28 Sep 2018 13:11:07 +0000
Date: Fri, 28 Sep 2018 15:10:43 +0200
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 3/3] resource: Fix find_next_iomem_res() iteration issue
Message-ID: <20180928131043.GB21895@zn.tnic>
References: <153782698067.130337.12079523922130875402.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153782730364.130337.17794279728329113665.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <13084ce6-e29a-c244-3f9c-cf0725646d9f@redhat.com>
 <20180927140351.GA257735@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180927140351.GA257735@bhelgaas-glaptop.roam.corp.google.com>
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, lijiang <lijiang@redhat.com>, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, dan.j.williams@intel.com, dyoung@redhat.com, tglx@linutronix.de, Vivek Goyal <vgoyal@redhat.com>

T24gVGh1LCBTZXAgMjcsIDIwMTggYXQgMDk6MDM6NTFBTSAtMDUwMCwgQmpvcm4gSGVsZ2FhcyB3
cm90ZToKPiBTaW5jZSBJIHRoaW5rIHRoZSBjdXJyZW50IGludGVyZmFjZSAodXNpbmcgKnJlcyBh
cyBib3RoIGlucHV0IGFuZAo+IG91dHB1dCBwYXJhbWV0ZXJzIHRoYXQgaGF2ZSB2ZXJ5IGRpZmZl
cmVudCBtZWFuaW5ncykgaXMgY29uZnVzaW5nLAoKRlRSLCBJIHRvbywgdGhpbmsgdGhhdCB0aGlz
IHdob2xlIG1hY2hpbmVyeSBpbiByZXNvdXJjZS5jIHdpdGggcGFzc2luZwppbiBhIGZ1bmN0aW9u
IGFuZCBhIHN0cnVjdCByZXNvdXJjZSBwb2ludGVyIGFuZCBpcyBjbHVtc3kgYW5kIGNvdWxkIHVz
ZQphIHJld3JpdGUuIFdoZW4gdGhlcmUncyB0aW1lLi4uIDstXAoKLS0gClJlZ2FyZHMvR3J1c3Ms
CiAgICBCb3Jpcy4KClNVU0UgTGludXggR21iSCwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlciwgSmFu
ZSBTbWl0aGFyZCwgR3JhaGFtIE5vcnRvbiwgSFJCIDIxMjg0IChBRyBOw7xybmJlcmcpCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
