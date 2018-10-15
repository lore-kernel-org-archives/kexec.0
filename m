Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gC0ts-0007Ds-Nx
 for kexec@lists.infradead.org; Mon, 15 Oct 2018 11:19:12 +0000
Date: Mon, 15 Oct 2018 13:18:43 +0200
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/3] x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one
 error
Message-ID: <20181015111843.GB10240@zn.tnic>
References: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153805811578.1157.6948388946904655969.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180930092110.GB6950@dhcp-128-65.nay.redhat.com>
 <20180930092741.GC6950@dhcp-128-65.nay.redhat.com>
 <20181015045138.GA9719@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181015045138.GA9719@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: tglx@linutronix.de, thomas.lendacky@amd.com, brijesh.singh@amd.com, Lianbo Jiang <lijiang@redhat.com>, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, Bjorn Helgaas <helgaas@kernel.org>, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, akpm@linux-foundation.org, dan.j.williams@intel.com, Vivek Goyal <vgoyal@redhat.com>

T24gTW9uLCBPY3QgMTUsIDIwMTggYXQgMTI6NTE6MzhQTSArMDgwMCwgRGF2ZSBZb3VuZyB3cm90
ZToKPiA+IFNpbmNlIHRoZSBmaXggb2YgY2hlY2tpbmcgdGhlIGVuZCBpcyBpbiBhbm90aGVyIHBh
dGNoLCBwcm9iYWJseSBtZXJnZQo+ID4gdGhlc2UgdHdvIHBhdGNoZXMgc28gdGhhdCB0aGV5IGFy
ZSBpbiBvbmUgcGF0Y2ggdG8gYXZvaWQgYnJlYWsgYmlzZWN0LiAKPiAKPiBOb3Qgc3VyZSBpZiBh
Ym92ZSBjb21tZW50IHdhcyBtaXNzZWQsIEJvcmlzLCB3b3VsZCB5b3UgbWluZCB0byBmb2xkIHRo
ZQo+IHBhdGNoIDEgYW5kIDI/CgpXaXRob3V0IGFueSBmdXJ0aGVyIGV4cGxhbmF0aW9uIGFib3V0
IGEgcG90ZW50aWFsIGJpc2VjdGlvbiBicmVha2luZywKdGhlcmUncyBub3RoaW5nIEkgY2FuIGRv
LgoKLS0gClJlZ2FyZHMvR3J1c3MsCiAgICBCb3Jpcy4KClNVU0UgTGludXggR21iSCwgR0Y6IEZl
bGl4IEltZW5kw7ZyZmZlciwgSmFuZSBTbWl0aGFyZCwgR3JhaGFtIE5vcnRvbiwgSFJCIDIxMjg0
IChBRyBOw7xybmJlcmcpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
