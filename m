Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hZp2w-0006q8-Em
 for kexec@lists.infradead.org; Sun, 09 Jun 2019 04:03:07 +0000
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel e820
 table
References: <20190423013007.17838-1-lijiang@redhat.com>
 <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
 <20190607174211.GN20269@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <843cf2d9-8b52-75de-0e76-7ae216bc8e64@redhat.com>
Date: Sun, 9 Jun 2019 12:02:49 +0800
MIME-Version: 1.0
In-Reply-To: <20190607174211.GN20269@zn.tnic>
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
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, bhe@redhat.com, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

5ZyoIDIwMTnlubQwNuaciDA45pelIDAxOjQyLCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IFR1ZSwgTWF5IDI4LCAyMDE5IGF0IDAzOjMwOjIxUE0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
IEhpLCBCb3JpcyBhbmQgVGhvbWFzCj4+Cj4+IENvdWxkIHlvdSBnaXZlIG1lIGFueSBzdWdnZXN0
aW9ucyBhYm91dCB0aGlzIHBhdGNoIHNlcmllcz8gT3RoZXIgcmV2aWV3ZXJzPwo+IAo+IFNvIEkn
bSB0ZXN0aW5nIHRoaXMgb24gYSBib3ggd2l0aCBTTUUgZW5hYmxlZCBidXQgYWZ0ZXIgbG9hZGlu
ZyB0aGUKPiBjcmFzaCBrZXJuZWwsIGl0IGZyZWV6ZXMgaW5zdGVhZCBvZiByZWJvb3RpbmcuIE15
IGNtZGxpbmUgaXM6Cj4gCj4gIGtleGVjIC1zIC1wIC9ib290L3ZtbGludXotNS4yLjAtcmMzKyAt
LWluaXRyZD0vYm9vdC9pbml0cmQuaW1nLTUuMi4wLXJjMysgLS1jb21tYW5kLWxpbmU9Im1heGNw
dXM9MSByb290PS9kZXYvc2RhNSBybyBkZWJ1ZyBpZ25vcmVfbG9nbGV2ZWwgbG9nX2J1Zl9sZW49
MTZNIG5vX2NvbnNvbGVfc3VzcGVuZCBuZXQuaWZuYW1lcz0wIHN5c3RlbWQubG9nX3RhcmdldD1u
dWxsIG1lbV9lbmNyeXB0PW9uIGt2bV9hbWQuc2V2PTEgbnJfY3B1cz0xIGlycXBvbGwgcmVzZXRf
ZGV2aWNlcyB2Z2E9bm9ybWFsIExBTkc9ZW5fVVMuVVRGLTggZWFybHlwcmludGs9c2VyaWFsIGNn
cm91cF9kaXNhYmxlPW1lbW9yeSBtY2U9b2ZmIG51bWE9b2ZmIHVkZXYuY2hpbGRyZW4tbWF4PTIg
cGFuaWM9MTAgcm9vdGZsYWdzPW5vZmFpbCBhY3BpX25vX21lbWhvdHBsdWcgdHJhbnNwYXJlbnRf
aHVnZXBhZ2U9bmV2ZXIgZGlzYWJsZV9jcHVfYXBpY2lkPTAiCj4gCj4gYW5kIHRoZSByZXNlcnZl
ZCByYW5nZSBpczoKPiAKPiBbICAgIDAuMDAwMDAwXSBSZXNlcnZpbmcgMjU2TUIgb2YgbWVtb3J5
IGF0IDMzOTJNQiBmb3IgY3Jhc2hrZXJuZWwgKFN5c3RlbSBSQU06IDE2MjcxTUIpCj4gCj4gSSdt
IHdvbmRlcmluZyBpZiBpdCBpcyByZWxhdGVkIHRvCj4gCj4gaHR0cHM6Ly9sa21sLmtlcm5lbC5v
cmcvci8yMDE5MDYwNDEzNDk1Mi5HQzI2ODkxQE1pV2lGaS1SM0wtc3J2Cj4gClllcy4gSXQgc2hv
dWxkIGJlIGEgU01FIGlzc3VlLgoKVGhhbmtzLgpMaWFuYm8KCj4gVGh4Lgo+IAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0
CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9rZXhlYwo=
