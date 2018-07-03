Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1faJRG-0002dP-Gy
 for kexec@lists.infradead.org; Tue, 03 Jul 2018 11:25:44 +0000
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com> <20180702101451.GB28730@zn.tnic>
 <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <20180703093924.GA5748@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <55b86851-4978-9289-8a1f-012c6114ec9e@redhat.com>
Date: Tue, 3 Jul 2018 19:25:21 +0800
MIME-Version: 1.0
In-Reply-To: <20180703093924.GA5748@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: thomas.lendacky@amd.com, bhe@redhat.com, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com

5ZyoIDIwMTjlubQwN+aciDAz5pelIDE3OjM5LCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IFR1ZSwgSnVsIDAzLCAyMDE4IGF0IDEwOjE3OjE5QU0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
IGZvciBleGFtcGxlLCB0aGUgZWxmY29yZWhkci4gSW4gZmFjdCwgdGhlIGVsZmNvcmVoZHIgYW5k
IG5vdGVzCj4gCj4gWW91IG1lYW4gdGhpcz8KPiAKPiAgc3NpemVfdCBfX3dlYWsgZWxmY29yZWhk
cl9yZWFkX25vdGVzKGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50LCB1NjQgKnBwb3MpCj4gIHsKPiAt
ICAgICAgIHJldHVybiByZWFkX2Zyb21fb2xkbWVtKGJ1ZiwgY291bnQsIHBwb3MsIDApOwo+ICsg
ICAgICAgcmV0dXJuIHJlYWRfZnJvbV9vbGRtZW0oYnVmLCBjb3VudCwgcHBvcywgMCwgc21lX2Fj
dGl2ZSgpKTsKPiAKPiBUaGF0IGxvb2tzIGVuY3J5cHRlZCB0byBtZS4KPiAKVGhlIGVsZiBub3Rl
cyBpcyBhbiBvbGQgbWVtb3J5LCBpdCBpcyBlbmNyeXB0ZWQuCgpCdXQgdGhlIGVsZiBoZWFkZXIg
aXMgYSBjcmFzaCBrZXJuZWwgcmVzZXJ2ZWQgbWVtb3J5LCB3aGljaCBpcyB1bmVuY3J5cHRlZC4K
IHNzaXplX3QgX193ZWFrIGVsZmNvcmVoZHJfcmVhZChjaGFyICpidWYsIHNpemVfdCBjb3VudCwg
dTY0ICpwcG9zKQogewotCXJldHVybiByZWFkX2Zyb21fb2xkbWVtKGJ1ZiwgY291bnQsIHBwb3Ms
IDApOworCXJldHVybiByZWFkX2Zyb21fb2xkbWVtKGJ1ZiwgY291bnQsIHBwb3MsIDAsIGZhbHNl
KTsKIH0KClRoZXkgY2FsbCB0aGUgc2FtZSBmdW5jdGlvbihyZWFkX2Zyb21fb2xkbWVtLT5pb3Jl
bWFwX2NhY2hlKSwgc28gaXQgaXMgaGFyZCB0bwpwcm9wZXJseSByZW1hcCB0aGUgbWVtb3J5IGlm
IHdlIGRvbid0IHVzZSB0aGUgcGFyYW1ldGVyIHRvIGRpc3Rpbmd1aXNoLiAKClJlZ2FyZHMsCkxp
YW5ibwo+PiBjYWxsIHRoZSBzYW1lIGZ1bmN0aW9uKHJlYWRfZnJvbV9vbGRtZW0tPmlvcmVtYXBf
Y2FjaGUpLCBpbiB0aGlzIGNhc2UsCj4+IGl0IGlzIHZlcnkgZGlmZmljdWx0IHRvIHByb3Blcmx5
IHJlbWFwIHRoZSBtZW1vcnkgaWYgdGhlIGNhbGxlciBkb24ndAo+PiBjYXJlIHdoZXRoZXIgdGhl
IG1lbW9yeSBpcyBlbmNyeXB0ZWQuCj4gCj4gU28gYmVlZiB1cCB0aGUgbG9naWMgaW4gX19pb3Jl
bWFwX2NhbGxlcigpIHRvIGZpZ3VyZSBvdXQgYmFzZWQgb24gdGhlCj4gYWRkcmVzcyB3aGV0aGVy
IHRvIGFjY2VzcyB0aGUgbWVtb3J5IGVuY3J5cHRlZCBvciBub3QuIFlvdSBjYW4gZmluZCBvdXQK
PiB0aGUgZWxmY29yZWhkciBhZGRyZXNzIGluIHRoZSBjYXB0dXJlIGtlcm5lbC4KPiAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK
