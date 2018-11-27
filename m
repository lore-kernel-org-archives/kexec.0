Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gRTaj-0000tU-HT
 for kexec@lists.infradead.org; Tue, 27 Nov 2018 02:59:15 +0000
Subject: Re: [PATCH 0/2 RESEND v7] add reserved e820 ranges to the kdump
 kernel e820 table
References: <20181124051223.19994-1-lijiang@redhat.com>
 <35e8ade5-d5a8-b5e4-180b-44b4ff0a83b1@intel.com>
From: lijiang <lijiang@redhat.com>
Message-ID: <463c284b-115e-0784-ca07-a430127e6176@redhat.com>
Date: Tue, 27 Nov 2018 10:58:38 +0800
MIME-Version: 1.0
In-Reply-To: <35e8ade5-d5a8-b5e4-180b-44b4ff0a83b1@intel.com>
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
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, bhe@redhat.com, ard.biesheuvel@linaro.org, peterz@infradead.org, x86@kernel.org, kexec@lists.infradead.org, tony.luck@intel.com, dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

5ZyoIDIwMTjlubQxMeaciDI35pelIDAyOjU0LCBEYXZlIEhhbnNlbiDlhpnpgZM6Cj4gT24gMTEv
MjMvMTggOToxMiBQTSwgTGlhbmJvIEppYW5nIHdyb3RlOgo+PiBUaGVzZSBwYXRjaGVzIGFkZCB0
aGUgbmV3IEkvTyByZXNvdXJjZSBkZXNjcmlwdG9yICdJT1JFU19ERVNDX1JFU0VSVkVEJwo+PiBm
b3IgdGhlIGlvbWVtIHJlc291cmNlcyBzZWFyY2ggaW50ZXJmYWNlcywgYW5kIGluIG9yZGVyIHRv
IG1ha2UgaXQgc3RpbGwKPj4gd29yayBhZnRlciB0aGUgbmV3IGRlc2NyaXB0b3IgaXMgYWRkZWQs
IHRoZXNlIGNvZGVzIG9yaWdpbmFsbHkgcmVsYXRlZAo+PiB0byAnSU9SRVNfREVTQ19OT05FJyBo
YXZlIGJlZW4gdXBkYXRlZC4KPiAKPiBUaGlzIGlzIHJhdGhlciBhbmVtaWMgIjAvIiB0ZXh0LiAg
Q291bGQgeW91IHBsZWFzZSBpbmNsdWRlIHNvbWUgbW9yZQo+IGJhY2tncm91bmQgaW4gaGVyZT8g
IFRoZSAyLzIgcGF0Y2ggaXMgcHJldHR5IGdvb2QgaW4gdGhpcyByZWdhcmQsIGJ1dCBpdAo+IG5l
ZWRzIHRvIGJlIGhlcmUsIHRvby4KPiAKClRoYW5rcyBmb3IgeW91ciBjb21tZW50LiAKCk9yaWdp
bmFsbHksIHRoaXMgcGF0Y2ggYWRkZWQgdGhlIGU4MjAgcmVzZXJ2ZWQgcmFuZ2VzIGJ5IGFjY3Vy
YXRlbHkgY29tcGFyaW5nCmEgc3RyaW5nLiBJdCBvbmx5IG1vZGlmaWVzIGZld2VyIGNvZGUgcGF0
aHMuIFBsZWFzZSByZWZlciB0byBwYXRjaCB2Ni4KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDE4MTExNDA3MjkyNi4xMzMxMi0yLWxpamlhbmdAcmVkaGF0LmNvbS8KCkJlY2F1c2UgdGhl
IHN0cmluZyBjb21wYXJpc29uIGlzIGZyYWdpbGUgYW5kIGVycm9yLXByb25lLCB0aGlzIHBhdGNo
IHVzZWQgdGhlCnNvbHV0aW9uIHRoYXQgYWRkcyBhIG5ldyBkZXNjcmlwdG9yICdJT1JFU19ERVND
X1JFU0VSVkVEJy4gUGxlYXNlIHJlZmVyIHRvIHRoaXMKbGluazogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8yMDE4MTEyMDE5MjkzNS5HSzI1MjdAem4udG5pYy8KCldoZW4gcGFzc2luZyB0
aGUgZTgyMCByZXNlcnZlZCByYW5nZXMgdG8gdGhlIHNlY29uZCBrZXJuZWwsIHdoeSBkb2VzIGl0
IG5lZWQgdG8KY29tcGFyZSBzdHJpbmdzIGFjY3VyYXRlbHkgb3IgYWRkIGEgbmV3IGRlc2NyaXB0
b3IgJ0lPUkVTX0RFU0NfUkVTRVJWRUQnPwoKLVRoZSByZWFzb24gaXMgdGhhdCBpdCBjYW4gbm90
IGV4YWN0bHkgbWF0Y2ggdGhlIGU4MjAgcmVzZXJ2ZWQgcmVzb3VyY2UgcmFuZ2VzCndoZW4gd2Fs
a2luZyB0aHJvdWdoIGlvbWVtIHJlc291cmNlcyB3aXRoIHRoZSBkZXNjcmlwdG9yICdJT1JFU19E
RVNDX05PTkUnLgoKVGhhbmtzLgpMaWFuYm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
