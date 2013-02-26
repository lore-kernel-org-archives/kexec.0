Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1UAGFS-00005L-AV
 for kexec@lists.infradead.org; Tue, 26 Feb 2013 08:50:55 +0000
Message-ID: <512C76FE.4070109@cn.fujitsu.com>
Date: Tue, 26 Feb 2013 16:49:02 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] kexec: Use min_t to simplify logic
References: <512C44E4.70907@cn.fujitsu.com> <512C4881.90409@cn.fujitsu.com>
 <1361867881.2023.16.camel@joe-AO722>
In-Reply-To: <1361867881.2023.16.camel@joe-AO722>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

5LqOIDIwMTPlubQwMuaciDI25pelIDE2OjM4LCBKb2UgUGVyY2hlcyDlhpnpgZM6Cj4gT24gVHVl
LCAyMDEzLTAyLTI2IGF0IDEzOjMwICswODAwLCBaaGFuZyBZYW5mZWkgd3JvdGU6Cj4+IFRoaXMg
aXMganVzdCBhIHR3ZWFrOiB1c2luZyBtaW5fdCB0byBzaW1wbGlmeSBsb2dpYyBvZiB2YXJpYWJs
ZQo+PiBhc3NpZ25tZW50cy4KPj4KPj4gdjM6Cj4+IC0gY2FzdCB0eXBlIG9mIChQQUdFX1NJWkUg
LSAobWFkZHIgJiB+UEFHRV9NQVNLKSkgaW50byBzaXplX3QuCj4gCj4gV2h5PyAgSXNuJ3QgdGhp
cyBqdXN0IGEgcmVkdW5kYW50IGNhc3Q/Cj4gCj4+IGRpZmYgLS1naXQgYS9rZXJuZWwva2V4ZWMu
YyBiL2tlcm5lbC9rZXhlYy5jCj4gW10KPj4gQEAgLTgyMiwxMyArODIyLDkgQEAgc3RhdGljIGlu
dCBraW1hZ2VfbG9hZF9ub3JtYWxfc2VnbWVudChzdHJ1Y3Qga2ltYWdlICppbWFnZSwKPiBbXQo+
PiArCQltY2h1bmsgPSBtaW5fdChzaXplX3QsIG1ieXRlcywKPj4gKwkJCSAgICAgICAoc2l6ZV90
KShQQUdFX1NJWkUgLSAobWFkZHIgJiB+UEFHRV9NQVNLKSkpOwo+IAo+ICNkZWZpbmUgbWluX3Qo
dHlwZSwgeCwgeSkgKHsJCQlcCj4gCXR5cGUgX19taW4xID0gKHgpOwkJCVwKPiAJdHlwZSBfX21p
bjIgPSAoeSk7CQkJXAo+IAlfX21pbjEgPCBfX21pbjIgPyBfX21pbjE6IF9fbWluMjsgfSkKPiAK
PiAKPiAKCkhtbSwgZnJvbSB0aGUgZGVmaW5pdGlvbiwgdGhlIGNhc3QgaXMgcmVkdW5kYW50LgoK
TWF5YmUgSSBtaXN1bmRlcnN0b29kIHdoYXQgQW5kcmV3IG1lYW50IGluIHRoZSBtYWlsIHJlbGF0
ZWQgdG8gdjI6CgoiVGhlIHR5cGVzIG9mIFBBR0VfU0laRSBhbmQgUEFHRV9NQVNLIGFyZSB2YWd1
ZSAtIGlpcmMgdGhleSBvbmNlIGhhZApkaWZmZXJlbnQgdHlwZXMgb24gZGlmZmVyZW50IGFyY2hp
dGVjdHVyZXMsIHNvIHNvbWUgZm9ybSBvZiBjYXN0aW5nIGlzCnVuYXZvaWRhYmxlIGhlcmUuIgoK
QW5kcmV3LCBjb3VsZCB5b3UgcGxlYXNlIGV4cGxhaW4gdGhlIGNhc3RpbmcgeW91IG1lYW50IGFi
b3ZlPwoKVGhhbmtzClpoYW5nCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
