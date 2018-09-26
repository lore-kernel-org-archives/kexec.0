Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g59je-0002ua-QK
 for kexec@lists.infradead.org; Wed, 26 Sep 2018 13:23:29 +0000
Date: Wed, 26 Sep 2018 15:18:56 +0200
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot
 support
Message-ID: <20180926131856.GD6920@zn.tnic>
References: <20180925111020.23834-1-kasong@redhat.com>
 <6e15796e-31e9-2dc6-4a31-5c1b01554b45@amd.com>
 <20180925172608.GB15464@zn.tnic>
 <20180926073252.GC2555@MiWiFi-R3L-srv>
 <20180926112208.GE2555@MiWiFi-R3L-srv>
 <3b41fee3-e2f6-2e36-d2ca-1074c5f62bb8@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3b41fee3-e2f6-2e36-d2ca-1074c5f62bb8@amd.com>
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
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>

T24gV2VkLCBTZXAgMjYsIDIwMTggYXQgMDE6MDE6MDBQTSArMDAwMCwgTGVuZGFja3ksIFRob21h
cyB3cm90ZToKPiBObyBjb25jZXJuIGZyb20gbWUuICBUaGUgb3JpZ2luYWwgdmVyc2lvbiBvZiB0
aGUgcGF0Y2ggZGlkIG5vdCBjYWNoZSB0aGUKPiB2YWx1ZSwgdGhhdCB3YXMgYWRkZWQgYmFzZWQg
b24gdGhlIHBhdGNoIHNlcmllcyBmZWVkYmFjay4gIFNvLCBpZiB0aGVyZQo+IGlzIG5vIGNvbmNl
cm4gYWJvdXQgZXhlY3V0aW5nIHNvbWUgZXh0cmEgQ1BVSUQvUkRNU1IgaW5zdHJ1Y3Rpb25zLCB0
aGVuCj4gaXQgd291bGQgY2VydGFpbmx5IHNpbXBsaWZ5IHRoZSBjb2RlIHF1aXRlIGEgYml0LgoK
WWVhaCwgSSB0aGluayBpdCB3YXMgbWUgd2hvIHN1Z2dlc3RlZCB0byBjYWNoZSBpdCBidXQgaGF2
aW5nIHNpbXBsZXIKY29kZSBncmVhdGx5IG91dHdlaWdocyB0aGUgbWludXRlIGNhY2hpbmcgd2lu
LgoKLS0gClJlZ2FyZHMvR3J1c3MsCiAgICBCb3Jpcy4KClNVU0UgTGludXggR21iSCwgR0Y6IEZl
bGl4IEltZW5kw7ZyZmZlciwgSmFuZSBTbWl0aGFyZCwgR3JhaGFtIE5vcnRvbiwgSFJCIDIxMjg0
IChBRyBOw7xybmJlcmcpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
