Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gOxKi-0004yZ-FH
 for kexec@lists.infradead.org; Tue, 20 Nov 2018 04:08:18 +0000
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com> <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
 <c3347d48-aa32-e8e4-c99b-baf2e6a21dc2@redhat.com>
 <20181118115251.GB19380@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <e7237f99-67cf-f3b5-e078-81208d68baf2@redhat.com>
Date: Tue, 20 Nov 2018 12:07:18 +0800
MIME-Version: 1.0
In-Reply-To: <20181118115251.GB19380@zn.tnic>
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
Cc: bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, Bjorn Helgaas <helgaas@kernel.org>, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

5ZyoIDIwMTjlubQxMeaciDE45pelIDE5OjUyLCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IEZyaSwgTm92IDE2LCAyMDE4IGF0IDExOjI1OjU1QU0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
IEZvciB0aGUgcGNpIG1tY29uZmlnIGlzc3VlLCBpdCBzaG91bGQgYmUgZ29vZCBlbm91Z2ggdGhh
dCB0aGUgZTgyMCByZXNlcnZlZCByZWdpb24KPj4gW21lbSAweDAwMDAwMDAwNzgwMDAwMDAtMHgw
MDAwMDAwMDhmZmZmZmZmXSBpcyBvbmx5IHBhc3NlZCB0byB0aGUgc2Vjb25kIGtlcm5lbCwgYnV0
Cj4+IHRoZSBwY2kgbW1jb25maWcgcmVnaW9uIGlzIG5vdCB0aGUgc2FtZSBpbiBhbm90aGVyIG1h
Y2hpbmUuCj4gCj4gWWVzLiBBbmQgbm93IHRoZSBxdWVzdGlvbiBpcywgKndoaWNoKiByZXNlcnZl
ZCByZWdpb25zIG5lZWQgdG8gYmUgbWFwcGVkCj4gZm9yIHRoZSBzZWNvbmQga2VybmVsIHRvIGZ1
bmN0aW9uIHByb3Blcmx5PyBIb3cgZG8gd2UgZmlndXJlIHRoYXQgb3V0Pwo+IAo+PiBBIHNpbXBs
ZSBjYXNlLCBob3RwbHVnIGEgcGNpIG5ldHdvcmsgY2FyZCBhbmQgdXNlIHRoZSBzc2gvbmZzIHRv
IGR1bXAgdGhlIHZtY29yZS4KPj4gSWYgdGhlIHBjaSBtbWNvbmZpZyByZWdpb24gaXMgbm90IHJl
c2VydmVkIGluIGtkdW1wIGtlcm5lbCwgdGhlIHBjaSBob3RwbHVnIGRldmljZQo+PiBjb3VsZCBu
b3QgYmUgcmVjb2duaXplZC4gU28gdGhlIHBjaSBuZXR3b3JrIGNhcmQgd29uJ3Qgd29yay4KPiAK
PiBZZXMgdGhhdCdzIGEgZ29vZCBleGFtcGxlOyBwdXQgKnRoYXQqIGV4YW1wbGUgaW4geW91ciBj
b21taXQgbWVzc2FnZS4KPiAKPj4gSGVyZSwgdGhlcmUgaXMgYW4gZXhhbXBsZSBhYm91dCBTTUUg
a2R1bXAuIE1heWJlIGl0IGNhbiBoZWxwIHRvIGJldHRlciB1bmRlcnN0YW5kLgo+IAo+IFlvdSBr
ZWVwIHBhc3RpbmcgdGhhdCBhbmQgSSd2ZSByZWFkIGl0IGFscmVhZHkuIEFuZCB5b3Uga2VlcCBy
ZXBlYXRpbmcKPiB0aGF0IHRoZSByZXNlcnZlZCByZWdpb25zIG5lZWQgdG8gYmUgbWFwcGVkIGlu
IHRoZSBzZWNvbmQga2VybmVsIGFuZCBJJ20KPiBhc2tpbmcsIGhvdyBkbyB3ZSBkZXRlcm1pbmUg
KndoaWNoKiByZWdpb25zIHNob3VsZCB3ZSBwYXNzIHRvIHRoZSBzZWNvbmQKPiBrZXJuZWw/Cj4g
Cj4gSWYgd2Ugc2hvdWxkIHBhc3MgKmFsbCogcmVzZXJ2ZWQgcmVnaW9ucywgd2h5Pwo+IAo+IElP
VywgSSdtIGxvb2tpbmcgZm9yIHRoZSAqd2h5KiBmaXJzdC4KPiAKPiBUaHguCj4gCgpJIGd1ZXNz
IHlvdSBoYXZlIGdvdHRlbiB0aGUgYW5zd2VyIHdoYXQgeW91IHdhbnQgZnJvbSBEYXZlJ3MgcmVw
bHkuCgpUaGFuayB5b3UsIEJvcmlzLiBBbHNvIHRoYW5rcyBmb3IgRGF2ZSdzIGV4cGxhbmF0aW9u
IGluIGRldGFpbC4KClJlZ2FyZHMsCkxpYW5ibwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
