Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ejBdf-0003hi-H0
 for kexec@lists.infradead.org; Tue, 06 Feb 2018 22:22:57 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20180201231116.28077-1-jschoenh@amazon.de>
 <87h8r0jhf4.fsf@xmission.com>
 <4d45f270-7659-4d64-69a2-a9c448875c02@amazon.de>
Date: Tue, 06 Feb 2018 16:22:10 -0600
In-Reply-To: <4d45f270-7659-4d64-69a2-a9c448875c02@amazon.de> ("Jan
 H. \=\?utf-8\?Q\?Sch\=C3\=B6nherr\=22's\?\= message of "Fri,
 2 Feb 2018 22:54:22 +0100")
Message-ID: <87y3k5hi7h.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: Allow to skip digest calculation for speed
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
To: =?utf-8?Q?Jan_H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, kexec@lists.infradead.org

IkphbiBILiBTY2jDtm5oZXJyIiA8anNjaG9lbmhAYW1hem9uLmRlPiB3cml0ZXM6Cgo+IE9uIDAy
LzAyLzIwMTggMDI6NDIgQU0sIEVyaWMgVy4gQmllZGVybWFuIHdyb3RlOgo+PiBKYW4gSC4gU2No
w7ZuaGVyciA8anNjaG9lbmhAYW1hem9uLmRlPiB3cml0ZXM6Cj4+IAo+Pj4gR2l2ZSB0aGUgYWRt
aW5pc3RyYXRvciB0aGUgYWJpbGl0eSB0byB0cmFkZSBrZXhlYyBzYWZldHkgZm9yIGtleGVjIHNw
ZWVkCj4+PiBieSBkaXNhYmxpbmcgdGhlIGRpZ2VzdCBjYWxjdWxhdGlvbi92ZXJpZmljYXRpb24g
Zm9yIHJlZ3VsYXIga2V4ZWNzLgo+Pj4KPj4+IFRoZSBiZWhhdmlvciBvZiBrZXhlYy1vbi1jcmFz
aCBpcyBub3QgdG91Y2hlZC4KPj4gCj4+IFRoZSBwZXJmb3JtYW5jZSBvZiB0aGUgZGlnZXN0IGNh
Y3VsYXRpb24gaXMgYWNjZXB0YWJsZSBvbiAzODZzLiAgT3IgaXQKPj4gd2FzIHllYXJzIGFnbyB3
aGVuIEkgdGVzdGVkIGl0IG9uIGEgMzg2LiAgV2hhdCBpcyB0aGUgcHJvYmxlbSB5b3UgYXJlCj4+
IGhhdmluZy4KPj4gCj4+IElzIHRoZXJlIHNvbWV0aGluZyBzaWxseSBsaWtlIGEgY2FjaGUgZGlz
YWJsZSBpbiB5b3VyIGNvbmZpZ3VyYXRpb24/Cj4KPiBMYXN0IHRpbWUgSSBtZWFzdXJlZCwgdGhp
cyBwYXRjaCByZWR1Y2VkIHRoZSB0aW1lIHVudGlsIHRoZSBzeXN0ZW0gaXMgcmVzcG9uc2l2ZQo+
IGFnYWluIGFmdGVyIGEga2V4ZWMgYnkgYWJvdXQgNTAgbXMgdG8gMTAwIG1zIGluIG15IHNldHVw
cy4gVGhhdCBzZWVtcyB0byBiZSBhYm91dAo+IHRoZSByaWdodCB0aW1lIGZvciBlbmFibGVkIGNh
Y2hlcywganVkZ2luZyBmcm9tIGEgcXVpY2sgc2hhMjU2c3VtIG9uIHRoZSBjb21tYW5kCj4gbGlu
ZSBhbmQgdGhlIGtlcm5lbCBzaXplcyBJJ20gd29ya2luZyB3aXRoLgo+Cj4gVGhlc2UgNTAgbXMg
dG8gMTAwIG1zIGFyZSBhIG5vdGljZWFibGUgZnJhY3Rpb24gb2YgdGhlIHRvdGFsIGtleGVjIHRp
bWUgYW5kIHRoZXkKPiBhcmUgZWFzeSB0byBhdm9pZCAtLSBjb21wYXJlZCB0byBzb21lIG90aGVy
IHRpbWUgc2lua3MgaW4gdGhlIExpbnV4Cj4gYm9vdCBwcm9jZXNzLgoKU28ganVzdCBvcHRpbWl6
YXRpb24gZm9yIG9wdGltaXphdGlvbiBzYWtlLiAgSXQgZml4ZXMgbm8gcHJvYmxlbXMgYW5kCnNv
bHZlcyBubyBjaGFsbGVuZ2VzLgoKT24gYSBodW1hbiB0aW1lIHNjYWxlIEkgZG9uJ3QgYmVsaWV2
ZSA1MG1zIHRvIDEwMG1zIGlzIGF0IGFsbCBub3RpY2FibGUuCgpUaGUgb3B0aW9uIGlzIGFscmVh
ZHkgdGhlcmUgaWYgeW91IGRvbid0IHVzZSB0aGUga2V4ZWNfZmlsZSBzeXNjYWxsLgoKVGhlIGtl
eGVjX2ZpbGUgc3lzY2FsbCBleGlzdHMgYmVjYXVzZSBwZW9wbGUgaGF2ZSBzZXR1cHMgd2hlcmUK
c2lnbmF0dXJlcyBhcmUgbmVlZGVkIG9uIGtlcm5lbHMgYW5kIHNvIGNhbiBub3QgYWZmb3JkIHRo
ZSBmdWxsCmdlbmVyYWxpdHkgb2YgdGhlIG9yaWdpbmFsIGtleGVjIHN5c3RlbSBjYWxsLiAgVGhl
IHVzZSBvZiBrZXhlY19maWxlCmFscmVhZHkgdGVsbHMgdXMgcGVvcGxlIG9mIGdpdmVuIHVwIGZ1
bGwgZ2VuZXJhbGl0eSBmb3Igc2FmZXR5LgoKSWYgdGhlcmUgaXMgYSBjb21wZWxsaW5nIHVzZSBj
YXNlIHdlIGNhbiB0YWxrIGFib3V0IHRoaXMsIGJ1dCByaWdodCBub3cKSSBkb24ndCBzZWUgd2hh
dCBjb3VsZCBwb3NzaWJseSBiZSBjb21wZWxsaW5nIGFib3V0IHNhdmluZyBhIHRlbnRoIG9mIGEK
c2Vjb25kLCBvbiBhIGNvbXBhcmF0aXZlbHkgcmFyZSBvcGVyYXRpb24uCgpFcmljCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBs
aXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
