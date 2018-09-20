Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g2swO-0007a0-M6
 for kexec@lists.infradead.org; Thu, 20 Sep 2018 06:59:57 +0000
Date: Thu, 20 Sep 2018 14:59:35 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/3 v2] resource: fix an error which walks through iomem
 resources
Message-ID: <20180920065935.GA11980@dhcp-128-65.nay.redhat.com>
References: <20180919125251.8181-1-lijiang@redhat.com>
 <20180919125251.8181-2-lijiang@redhat.com>
 <20180919132949.GB9122@nazgul.tnic>
 <32409e2a-533b-c317-5519-26e0993cd30e@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <32409e2a-533b-c317-5519-26e0993cd30e@redhat.com>
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, Baoquan He <bhe@redhat.com>, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, Borislav Petkov <bp@suse.de>, akpm@linux-foundation.org, dan.j.williams@intel.com

T24gMDkvMjAvMTggYXQgMDI6MzlwbSwgbGlqaWFuZyB3cm90ZToKPiDlnKggMjAxOOW5tDA55pyI
MTnml6UgMjE6MjksIEJvcmlzbGF2IFBldGtvdiDlhpnpgZM6Cj4gPiBPbiBXZWQsIFNlcCAxOSwg
MjAxOCBhdCAwODo1Mjo0OVBNICswODAwLCBMaWFuYm8gSmlhbmcgd3JvdGU6Cj4gPiAKPiA+IC4u
Lgo+ID4gCj4gPj4gSW4gZmFjdCwgd2Ugc2hvdWxkIGdldCB0aGUgcmVzb3VyY2UgQSBhbmQgQiB3
aGVuIHdlIHdhbGsgdGhyb3VnaCB0aGUKPiA+PiB3aG9sZSB0cmVlLCBidXQgaXQgb25seSBnZXRz
IHRoZSByZXNvdXJjZSBBLCB0aGUgcmVzb3VyY2UgQiBpcyBtaXNzZWQuCj4gPj4KPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBEYXZlIFlvdW5nIDxkeW91bmdAcmVkaGF0LmNvbT4KPiA+PiBTaWduZWQtb2Zm
LWJ5OiBMaWFuYm8gSmlhbmcgPGxpamlhbmdAcmVkaGF0LmNvbT4KPiA+IAo+ID4gQmVmb3JlIGxv
b2tpbmcgYXQgdGhpczogdGhlIFNPQiBjaGFpbiBvZiBhbGwgdGhyZWUgcGF0Y2hlcyBpcyB3cm9u
Zy4KPiA+IEhpbnQ6IHNlZSBzZWN0aW9uIDEyKSBpbiBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3Vi
bWl0dGluZy1wYXRjaGVzLnJzdAo+ID4gCj4gVGhhbmtzIGZvciB5b3VyIGFkdmljZSwgQm9yaXNs
YXYuCj4gCj4gSSBoYXZlIGRpc2N1c3NlZCB3aXRoIERhdmUgWW91bmcsIGFuZCBoZSBzdWdnZXN0
ZWQgdGhhdCBpIG1pZ2h0IGFkZCBhIFN1Z2dlc3RlZC1ieQoKcGF0Y2ggMiBhbmQgcGF0Y2ggMyBh
cmUgYmFzZWQgb24gbXkgZHJhZnQgcGF0Y2gsIGJ1dCBzaW5jZSB5b3UgZGlkIGRlYnVnZ2luZwph
bmQgY2hhbmdlcyB5b3UgY2FuIG1vdmUgbXkgU09CIHRvIFN1Z2dlc3RlZC1ieSBmb3IgcGF0Y2gg
MiBhbmQgcGF0Y2ggMywKZm9yIHBhdGNoIDEgcGxlYXNlIGp1c3QgZHJvcCBteSBTT0IgYW5kIGxl
YXZlIHlvdXJzIG9ubHkuIAoKCj4gdGFnIGluc3RlYWQgb2YgU2lnbmVkLW9mZi1ieSB0YWcgZm9y
IGhpbS4gV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQ/Cj4gCj4gSSB3aWxsIG1vZGlmeSB0aGUgaW52
YWxpZCBTT0IgY2hhaW4gYW5kIHBvc3QgaXQgYWdhaW4uCj4gCgpUaGFua3MKRGF2ZQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBs
aXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
