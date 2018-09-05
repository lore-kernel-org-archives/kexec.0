Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fxYQm-0007Wg-TP
 for kexec@lists.infradead.org; Wed, 05 Sep 2018 14:05:18 +0000
Subject: Re: [PATCH 2/5 V6] x86/ioremap: strengthen the logic in
 early_memremap_pgprot_adjust() to adjust encryption mask
References: <20180831081930.31561-1-lijiang@redhat.com>
 <20180831081930.31561-3-lijiang@redhat.com>
 <20180903024512.GA2568@dhcp-128-65.nay.redhat.com>
 <d2229538-51d5-ead7-c7e5-f4afe5b53693@redhat.com>
 <20180904004417.GA9842@dhcp-128-65.nay.redhat.com>
 <20180904012902.GB9842@dhcp-128-65.nay.redhat.com>
 <20180904015131.GA10877@dhcp-128-65.nay.redhat.com>
 <3a9ae246-0c3a-753a-41e2-f2788a882c50@redhat.com>
 <20180905064658.GA10310@dhcp-128-65.nay.redhat.com>
From: lijiang <lijiang@redhat.com>
Message-ID: <a09a3a21-9156-ce96-b7ef-9f7e7cda12b3@redhat.com>
Date: Wed, 5 Sep 2018 22:04:49 +0800
MIME-Version: 1.0
In-Reply-To: <20180905064658.GA10310@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: thomas.lendacky@amd.com, linux-efi <linux-efi@vger.kernel.org>, bhe@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de

5ZyoIDIwMTjlubQwOeaciDA15pelIDE0OjQ2LCBEYXZlIFlvdW5nIOWGmemBkzoKPiBbc25pcF0K
Pj4KPj4gQXMgcHJldmlvdXNseSBtZW50aW9uZWQsIHRoZXJlIGFyZSBhbHNvIG1hbnkgZGlmZmVy
ZW5jZXMgYmV0d2VlbiBrZXhlYyBhbmQga2R1bXAuIEluIGdlbmVyYWwsCj4+IGtleGVjIG5lZWRz
IHRvIGxvb2sgYXQgYWxsIG9mIGF2YWlsYWJsZSBwaHlzaWNhbCBtZW1vcnksIGJ1dCBrZHVtcCBk
b2Vzbid0IG5lZWQuCj4+Cj4+IEZvciBrZXhlYywga2V4ZWMtdG9vbHMgd2lsbCByZWFkIC9zeXMv
ZmlybXdhcmUvbWVtbWFwIGFuZCByZWNyZWF0ZSB0aGUgZTgyMCByYW5nZXMgZm9yIHRoZSAybmQK
Pj4ga2VybmVsLiBJZiBpdCBmYWlscywgd2lsbCB1c2UgL3Byb2MvaW9tZW0uCj4+Cj4+IEZvciBr
ZHVtcCwga2V4ZWMtdG9vbHMgd2lsbCByZWFkIC9wcm9jL2lvbWVtIGFuZCByZWNyZWF0ZSB0aGUg
ZTgyMCByYW5nZXMgZm9yIGtkdW1wIGtlcm5lbC4KPj4gQlRXOiB3ZSBjYW4gbm90IGdldCB0aGUg
cmFuZ2Ugb2YgcGVyc2lzdGVudCBtZW1vcnkgZnJvbSAvcHJvYy9pb21lbS4gU28gZTgyMCByYW5n
ZXMgZG9uJ3QgY29udGFpbgo+PiB0aGUgcGVyc2lzdGVudCBtZW1vcnkgaW4ga2R1bXAga2VybmVs
LCB0aGlzIGlzIHRoZSByZWFsIHJlYXNvbiB3aHkgaSBuZWVkIHRvIHN0cmVuZ3RoZW4gdGhlIGxv
Z2ljCj4+IG9mIGFkanVzdGluZyBtZW1vcnkgZW5jcnlwdGlvbiBtYXNrLgo+IAo+ICJwZXJzaXN0
ZW50IG1lbW9yeSIgaXMgZGlmZmVyZW50LCBJIHRoaW5rIHlvdSBtZWFudCBhYm91dCBzb21lIHJl
c2VydmVkCj4gbWVtb3J5IGluc3RlYWQKPiAKPj4KPj4gSWYga2V4ZWMtdG9vbHMgYWxzbyB1c2Ug
L3N5cy9maXJtd2FyZS9tZW1tYXAgZm9yIGtkdW1wKGxpa2Uga2V4ZWMpLCBrZHVtcCBrZXJuZWwg
Y2FuIGFsc28gd29yawo+PiB3aXRob3V0IGEgZml4LCBidXQgdGhlIGtleGVjLXRvb2xzIHdpbGwg
aGF2ZSB0byBiZSBtb2RpZmllZC4gQXJlIHlvdSBzdXJlIHRoYXQgeW91IHdhbnQgbWUgdG8KPj4g
Zml4IGtleGVjLXRvb2xzIGluc3RlYWQgb2Yga2VybmVsPwo+IAo+IFllcywgcGxlYXNlIGZpeCBr
ZXhlYy10b29scyB0byBwYXNzIHJlc2VydmVkIHJhbmdlcyBpbiBlODIwLCB5b3Ugd2lsbAo+IG5v
dCBuZWVkIHRoaXMgcGF0Y2ggdGhlbi4KPiAKClRoaXMgbWlnaHQgYmUgYSBrZXhlYy10b29scyBi
dWcsIGkgaGF2ZSBwb3N0ZWQgYSBwYXRjaCBmb3Iga2V4ZWMtdG9vbHMocGxlYXNlIGNoZWNrIGtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcpLgpUaGFua3MuCgo+IFRoYW5rcwo+IERhdmUKPiAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxp
bmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
