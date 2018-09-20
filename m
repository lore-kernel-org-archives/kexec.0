Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g2scy-00078T-Mc
 for kexec@lists.infradead.org; Thu, 20 Sep 2018 06:39:57 +0000
Subject: Re: [PATCH 1/3 v2] resource: fix an error which walks through iomem
 resources
References: <20180919125251.8181-1-lijiang@redhat.com>
 <20180919125251.8181-2-lijiang@redhat.com>
 <20180919132949.GB9122@nazgul.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <32409e2a-533b-c317-5519-26e0993cd30e@redhat.com>
Date: Thu, 20 Sep 2018 14:39:22 +0800
MIME-Version: 1.0
In-Reply-To: <20180919132949.GB9122@nazgul.tnic>
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, Baoquan He <bhe@redhat.com>, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

5ZyoIDIwMTjlubQwOeaciDE55pelIDIxOjI5LCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IFdlZCwgU2VwIDE5LCAyMDE4IGF0IDA4OjUyOjQ5UE0gKzA4MDAsIExpYW5ibyBKaWFuZyB3cm90
ZToKPiAKPiAuLi4KPiAKPj4gSW4gZmFjdCwgd2Ugc2hvdWxkIGdldCB0aGUgcmVzb3VyY2UgQSBh
bmQgQiB3aGVuIHdlIHdhbGsgdGhyb3VnaCB0aGUKPj4gd2hvbGUgdHJlZSwgYnV0IGl0IG9ubHkg
Z2V0cyB0aGUgcmVzb3VyY2UgQSwgdGhlIHJlc291cmNlIEIgaXMgbWlzc2VkLgo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBEYXZlIFlvdW5nIDxkeW91bmdAcmVkaGF0LmNvbT4KPj4gU2lnbmVkLW9mZi1i
eTogTGlhbmJvIEppYW5nIDxsaWppYW5nQHJlZGhhdC5jb20+Cj4gCj4gQmVmb3JlIGxvb2tpbmcg
YXQgdGhpczogdGhlIFNPQiBjaGFpbiBvZiBhbGwgdGhyZWUgcGF0Y2hlcyBpcyB3cm9uZy4KPiBI
aW50OiBzZWUgc2VjdGlvbiAxMikgaW4gRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmct
cGF0Y2hlcy5yc3QKPiAKVGhhbmtzIGZvciB5b3VyIGFkdmljZSwgQm9yaXNsYXYuCgpJIGhhdmUg
ZGlzY3Vzc2VkIHdpdGggRGF2ZSBZb3VuZywgYW5kIGhlIHN1Z2dlc3RlZCB0aGF0IGkgbWlnaHQg
YWRkIGEgU3VnZ2VzdGVkLWJ5CnRhZyBpbnN0ZWFkIG9mIFNpZ25lZC1vZmYtYnkgdGFnIGZvciBo
aW0uIFdoYXQgZG8geW91IHRoaW5rIGFib3V0PwoKSSB3aWxsIG1vZGlmeSB0aGUgaW52YWxpZCBT
T0IgY2hhaW4gYW5kIHBvc3QgaXQgYWdhaW4uCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
