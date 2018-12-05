Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUY42-0004Q3-7T
 for kexec@lists.infradead.org; Wed, 05 Dec 2018 14:22:11 +0000
Subject: Re: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-2-lijiang@redhat.com> <20181203150809.GA4794@zn.tnic>
 <779dbae7-f6e2-e9e4-bdd0-0a9e6ec62487@redhat.com>
 <20181205101653.GA6940@dhcp-128-65.nay.redhat.com>
From: lijiang <lijiang@redhat.com>
Message-ID: <72c311b4-1946-0bcf-54d9-9fcd7f6e630c@redhat.com>
Date: Wed, 5 Dec 2018 22:21:46 +0800
MIME-Version: 1.0
In-Reply-To: <20181205101653.GA6940@dhcp-128-65.nay.redhat.com>
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
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, linux-doc@vger.kernel.org, bhe@redhat.com, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, Borislav Petkov <bp@alien8.de>, tglx@linutronix.de, akpm@linux-foundation.org

5ZyoIDIwMTjlubQxMuaciDA15pelIDE4OjE2LCBEYXZlIFlvdW5nIOWGmemBkzoKPj4+PiAraW5p
dF91dHNfbnMKPj4+PiArPT09PT09PT09PT0KPj4+PiArVGhpcyBpcyB0aGUgVVRTIG5hbWVzcGFj
ZSwgd2hpY2ggaXMgdXNlZCB0byBpc29sYXRlIHR3byBzcGVjaWZpYyBlbGVtZW50cwo+Pj4+ICtv
ZiB0aGUgc3lzdGVtIHRoYXQgcmVsYXRlIHRvIHRoZSB1bmFtZSBzeXN0ZW0gY2FsbC4gVGhlIFVU
UyBuYW1lc3BhY2UgaXMKPj4+PiArbmFtZWQgYWZ0ZXIgdGhlIGRhdGEgc3RydWN0dXJlIHVzZWQg
dG8gc3RvcmUgaW5mb3JtYXRpb24gcmV0dXJuZWQgYnkgdGhlCj4+Pj4gK3VuYW1lIHN5c3RlbSBj
YWxsLgo+Pj4KPj4+IFRob3NlIG5vbi1vYnZpb3VzIGV4cG9ydHMgc2hvdWxkIGFsc28gaGF2ZSBh
IHNob3J0IGV4cGxhbmF0aW9uIHdoeQo+Pj4gdGhleSdyZSBwYXJ0IG9mIFZNQ09SRUlORk8uCj4+
Pgo+Pj4+ICsKPj4+PiArbm9kZV9vbmxpbmVfbWFwCj4+Pj4gKz09PT09PT09PT09PT09PQo+Pj4+
ICtJdCBpcyBhIG1hY3JvIGRlZmluaXRpb24sIGFjdHVhbGx5IGl0IGlzIGFuIGFycmFyeSBub2Rl
X3N0YXRlc1tOX09OTElORV0sCj4+Pj4gK2FuZCBpdCByZXByZXNlbnRzIHRoZSBzZXQgb2Ygb25s
aW5lIG5vZGUgaW4gYSBzeXN0ZW0sIG9uZSBiaXQgcG9zaXRpb24KPj4+PiArcGVyIG5vZGUgbnVt
YmVyLgo+Pj4KPj4+IERpdHRvLgo+Pj4KPj4+IFNvIHllYWgsIHBlb3BsZSBjYW4gZmluZCBvdXQg
d2hhdCB0aG9zZSB0aGluZ3MgYXJlIGJ1dCBJIHRoaW5rIGl0IGlzCj4+PiBtb3JlIGltcG9ydGFu
dCB0byBzdGF0ZSBoZXJlICp3aHkqIHRoZXkncmUgcGFydCBvZiBWTUNPUkVJTkZPIGFuZCBob3cK
Pj4+IHRoZXkncmUgdXNlZCBhbmQgd2h5IHRoZXkncmUgZXhwb3J0ZWQuCj4+Pgo+Pgo+PiBUaGlz
IGlzIGEgZ29vZCBxdWVzdGlvbi4KPj4KPj4gRm9yIHRoZXNlIHR3byAqd2h5KiwgaXQgc2hvdWxk
IGJlIGVhc3kgdG8gdW5kZXJzdGFuZC4gQmVjYXVzZSB1c2VyLXNwYWNlIHRvb2xzCj4+IG5lZWQg
dG8ga25vdyBiYXNpYyBpbmZvcm1hdGlvbiwgc3VjaCBhcyB0aGUgc3ltYm9sIHZhbHVlcywgZmll
bGQgb2Zmc2V0LCBzdHJ1Y3R1cmUKPj4gc2l6ZSwgZXRjLiBPdGhlcndpc2UsIHRoZXNlIHRvb2xz
IHdvbid0IGtub3cgaG93IHRvIGFuYWx5emUgdGhlIG1lbW9yeSBvZiB0aGUgY3Jhc2gKPj4ga2Vy
bmVsLgo+Pgo+PiBGb3IgdGhlIHNlY29uZCBxdWVzdGlvbiAnaG93IHRoZXkgYXJlIHVzZWQnLCB3
ZSBjYW4gZ2V0IHRoZSBhbnN3ZXIgZnJvbSB1c2VyLXNwYWNlCj4+IHRvb2xzLCBzdWNoIGFzIG1h
a2VkdW1wZmlsZSwgY3Jhc2ggdG9vbHMuIFRoZXJlZm9yZSwgaXQgbWF5IG5vdCBuZWVkIHRvIGV4
cGxhaW4gYW55Cj4+IG1vcmUgaW4ga2VybmVsIGRvY3VtZW50LiBPbiB0aGUgb3RoZXIgaGFuZCwg
aWYgd2UgbXVzdCBwdXQgdGhlc2UgY29udGVudHMgaW50byBrZXJuZWwKPj4gZG9jdW1lbnQsIGkg
aGF2ZSB0byBzYXksIHRoYXQgd291bGQgYmUgYSBoYXJkIHRhc2suCj4gCj4gSXQgc2hvdWxkIGJl
IGEgZ29vZCBjaGFuY2UgdG8gbGVhcm4gaG93IG1ha2VkdW1wZmlsZSB3b3JrcyA6KSwgIE1heWJl
IGl0IGlzCj4gaGFyZCB0byBnZXQgKmFsbCogb2YgdGhlbSwgYnV0IGl0IHdvdWxkIGJlIGdvb2Qg
dG8gZGlnIGFuZCBmaW5kIHRoZQo+IHRoaW5nIHlvdSBjYW4gZmluZCB0aGVuIGV4cGxhaW4gaXQu
ICBBbmQgbGVhdmUgdGhvc2UgKnVua25vd24qIHBhcnQgYXMKPiBGSVhNRSBvciBUT0RPLCBwZW9w
bGUgY2FuIGFkZCBkZXNjcmlwdGlvbiBsYXRlci4gCj4gCgpUaGFuayB5b3UsIERhdmUuCgpJdCBs
b29rcyBsaWtlIGEgZ29vZCBpZGVhLgoKClJlZ2FyZHMsCkxpYW5ibwoKPiBBZGRlZCBLYXp1IGlu
IGNjIGFzIHdlbGwuLgo+ID4gVGhhbmtzCj4gRGF2ZQo+IAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
