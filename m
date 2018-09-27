Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5Ysf-0000g1-Ti
 for kexec@lists.infradead.org; Thu, 27 Sep 2018 16:11:12 +0000
Date: Thu, 27 Sep 2018 18:10:38 +0200
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v7 RESEND 1/4] x86/ioremap: add a function
 ioremap_encrypted() to remap kdump old memory
Message-ID: <20180927161038.GB19779@zn.tnic>
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-2-lijiang@redhat.com>
 <20180927131737.GA19779@zn.tnic>
 <6306eaa9-d81e-2fa4-8978-63503a7ecce4@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6306eaa9-d81e-2fa4-8978-63503a7ecce4@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: thomas.lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

T24gVGh1LCBTZXAgMjcsIDIwMTggYXQgMTA6NTM6NDdQTSArMDgwMCwgbGlqaWFuZyB3cm90ZToK
PiBJZiBubyBuZWVkIHRvIGJyZWFrIHRoaXMgbGluZSwgaXQgd2lsbCBjYXVzZSBhIHdhcm5pbmcg
b2YgZXhjZWVkaW5nIDgwIGNoYXJhY3RlcnMgcGVyIGxpbmUuCgpUaGF0J3MgZmluZSAtIHdlIGRv
bid0IHRha2UgdGhlIDgwIGNvbHMgcnVsZSBibGluZGx5IGJ1dCBhcHBseSBjb21tb24Kc2Vuc2Uu
IEluIHRoaXMgcGFydGljdWxhciBjYXNlIHRoZSBsaW5lcyBjYW4gc3RpY2sgb3V0IGJlY2F1c2Ug
dGhleSdyZQpzaW1wbHkgZXh0ZXJucyBhbmQgYXJlIG1lYW50IHRvIGJlIHNraW1tZWQgb3ZlciBh
bmQgbm90IHJlYWxseSByZWFkLiA6KQoKPiBUaGFuayB5b3UgZm9yIHBvaW50aW5nIG91dCB0aGlz
IGlzc3VlLCBpIGZvcmdvdCB0byByZW1vdmUgdGhpcyBoZWFkZXIgZmlsZS4gCj4gCj4gSSB3aWxs
IGdldCByaWQgb2YgdGhpcyBoZWFkZXIgZmlsZSBhbmQgcG9zdCB0aGlzIHBhdGNoIGFnYWluLgoK
Tm8gbmVlZCAtIGFscmVhZHkgZml4ZWQgdGhhdCB1cC4KClRoeC4KCi0tIApSZWdhcmRzL0dydXNz
LAogICAgQm9yaXMuCgpTVVNFIExpbnV4IEdtYkgsIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIsIEph
bmUgU21pdGhhcmQsIEdyYWhhbSBOb3J0b24sIEhSQiAyMTI4NCAoQUcgTsO8cm5iZXJnKQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
