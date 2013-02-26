Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1UAGME-0001OD-4I
 for kexec@lists.infradead.org; Tue, 26 Feb 2013 08:57:54 +0000
Message-ID: <512C789D.1090404@cn.fujitsu.com>
Date: Tue, 26 Feb 2013 16:55:57 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] kexec: Use min_t to simplify logic
References: <512C44E4.70907@cn.fujitsu.com> <512C4881.90409@cn.fujitsu.com>
 <1361867881.2023.16.camel@joe-AO722> <512C76FE.4070109@cn.fujitsu.com>
 <20130226005328.e2d31a97.akpm@linux-foundation.org>
In-Reply-To: <20130226005328.e2d31a97.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Joe Perches <joe@perches.com>, Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

5LqOIDIwMTPlubQwMuaciDI25pelIDE2OjUzLCBBbmRyZXcgTW9ydG9uIOWGmemBkzoKPiBPbiBU
dWUsIDI2IEZlYiAyMDEzIDE2OjQ5OjAyICswODAwIFpoYW5nIFlhbmZlaSA8emhhbmd5YW5mZWlA
Y24uZnVqaXRzdS5jb20+IHdyb3RlOgo+IAo+Pj4+IGRpZmYgLS1naXQgYS9rZXJuZWwva2V4ZWMu
YyBiL2tlcm5lbC9rZXhlYy5jCj4+PiBbXQo+Pj4+IEBAIC04MjIsMTMgKzgyMiw5IEBAIHN0YXRp
YyBpbnQga2ltYWdlX2xvYWRfbm9ybWFsX3NlZ21lbnQoc3RydWN0IGtpbWFnZSAqaW1hZ2UsCj4+
PiBbXQo+Pj4+ICsJCW1jaHVuayA9IG1pbl90KHNpemVfdCwgbWJ5dGVzLAo+Pj4+ICsJCQkgICAg
ICAgKHNpemVfdCkoUEFHRV9TSVpFIC0gKG1hZGRyICYgflBBR0VfTUFTSykpKTsKPj4+Cj4+PiAj
ZGVmaW5lIG1pbl90KHR5cGUsIHgsIHkpICh7CQkJXAo+Pj4gCXR5cGUgX19taW4xID0gKHgpOwkJ
CVwKPj4+IAl0eXBlIF9fbWluMiA9ICh5KTsJCQlcCj4+PiAJX19taW4xIDwgX19taW4yID8gX19t
aW4xOiBfX21pbjI7IH0pCj4+Pgo+Pj4KPj4+Cj4+Cj4+IEhtbSwgZnJvbSB0aGUgZGVmaW5pdGlv
biwgdGhlIGNhc3QgaXMgcmVkdW5kYW50Lgo+Pgo+PiBNYXliZSBJIG1pc3VuZGVyc3Rvb2Qgd2hh
dCBBbmRyZXcgbWVhbnQgaW4gdGhlIG1haWwgcmVsYXRlZCB0byB2MjoKPj4KPj4gIlRoZSB0eXBl
cyBvZiBQQUdFX1NJWkUgYW5kIFBBR0VfTUFTSyBhcmUgdmFndWUgLSBpaXJjIHRoZXkgb25jZSBo
YWQKPj4gZGlmZmVyZW50IHR5cGVzIG9uIGRpZmZlcmVudCBhcmNoaXRlY3R1cmVzLCBzbyBzb21l
IGZvcm0gb2YgY2FzdGluZyBpcwo+PiB1bmF2b2lkYWJsZSBoZXJlLiIKPj4KPj4gQW5kcmV3LCBj
b3VsZCB5b3UgcGxlYXNlIGV4cGxhaW4gdGhlIGNhc3RpbmcgeW91IG1lYW50IGFib3ZlPwo+IAo+
IEkgbWVhbiB0aGF0IGEgY2FzdCAob3IgbWluX3QsIHdoaWNoIGlzIGEgY2FzdCkgd2lsbCBiZSBu
ZWVkZWQuIAo+IFRoZSBjb2RlIHlvdSBoYXZlIGhlcmUgY2FzdHMgdGhlIHNhbWUgdGhpbmcgdHdv
IHRpbWVzLCB3aGljaCBpc24ndAo+IG5lY2Vzc2FyeS4KPiAKPiAKClRoYW5rcy4KClNob3VsZCBJ
IHJlc2VuZCB0aGUgcGF0Y2ggYWdhaW4/IEFmdGVyIHJlbW92aW5nIHRoaXMgcmVkdW5kYW50IGNh
c3QsCml0IGlzIHRoZSBzYW1lIHdpdGggdjIuCgpaaGFuZwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
