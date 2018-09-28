Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5gjz-0005DC-5Q
 for kexec@lists.infradead.org; Fri, 28 Sep 2018 00:34:44 +0000
Subject: Re: [PATCH v7 RESEND 1/4] x86/ioremap: add a function
 ioremap_encrypted() to remap kdump old memory
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-2-lijiang@redhat.com> <20180927131737.GA19779@zn.tnic>
 <6306eaa9-d81e-2fa4-8978-63503a7ecce4@redhat.com>
 <20180927161038.GB19779@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <37217cd7-6a41-e882-1b29-cef725eeda53@redhat.com>
Date: Fri, 28 Sep 2018 08:33:50 +0800
MIME-Version: 1.0
In-Reply-To: <20180927161038.GB19779@zn.tnic>
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

5ZyoIDIwMTjlubQwOeaciDI45pelIDAwOjEwLCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IFRodSwgU2VwIDI3LCAyMDE4IGF0IDEwOjUzOjQ3UE0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
IElmIG5vIG5lZWQgdG8gYnJlYWsgdGhpcyBsaW5lLCBpdCB3aWxsIGNhdXNlIGEgd2FybmluZyBv
ZiBleGNlZWRpbmcgODAgY2hhcmFjdGVycyBwZXIgbGluZS4KPiAKPiBUaGF0J3MgZmluZSAtIHdl
IGRvbid0IHRha2UgdGhlIDgwIGNvbHMgcnVsZSBibGluZGx5IGJ1dCBhcHBseSBjb21tb24KPiBz
ZW5zZS4gSW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UgdGhlIGxpbmVzIGNhbiBzdGljayBvdXQgYmVj
YXVzZSB0aGV5J3JlCj4gc2ltcGx5IGV4dGVybnMgYW5kIGFyZSBtZWFudCB0byBiZSBza2ltbWVk
IG92ZXIgYW5kIG5vdCByZWFsbHkgcmVhZC4gOikKPiAKT2ssIGkgc2VlLiBUaGFua3MuCgo+PiBU
aGFuayB5b3UgZm9yIHBvaW50aW5nIG91dCB0aGlzIGlzc3VlLCBpIGZvcmdvdCB0byByZW1vdmUg
dGhpcyBoZWFkZXIgZmlsZS4gCj4+Cj4+IEkgd2lsbCBnZXQgcmlkIG9mIHRoaXMgaGVhZGVyIGZp
bGUgYW5kIHBvc3QgdGhpcyBwYXRjaCBhZ2Fpbi4KPiAKPiBObyBuZWVkIC0gYWxyZWFkeSBmaXhl
ZCB0aGF0IHVwLgo+IApHcmVhdCwgdGhhbmsgeW91IHNvIG11Y2ggZm9yIHlvdXIgaGVscC4KClJl
Z2FyZHMsCkxpYW5ibwo+IFRoeC4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
