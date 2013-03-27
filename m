Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKphH-0007pw-Lt
 for kexec@lists.infradead.org; Wed, 27 Mar 2013 12:43:20 +0000
Date: Wed, 27 Mar 2013 21:43:17 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] kexec: Use err() instead of fprintf()
Message-ID: <20130327124316.GA17248@verge.net.au>
References: <5149B68C.1080704@gmail.com> <5149B6FF.70908@gmail.com>
 <20130320132145.GK16436@verge.net.au> <51506B8F.2090106@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51506B8F.2090106@gmail.com>
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
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

T24gTW9uLCBNYXIgMjUsIDIwMTMgYXQgMTE6MjE6NTFQTSArMDgwMCwgWmhhbmcgWWFuZmVpIHdy
b3RlOgo+IOS6jiAyMDEz5bm0MDPmnIgyMOaXpSAyMToyMSwgU2ltb24gSG9ybWFuIOWGmemBkzoK
PiA+IE9uIFdlZCwgTWFyIDIwLCAyMDEzIGF0IDA5OjE3OjUxUE0gKzA4MDAsIFpoYW5nIFlhbmZl
aSB3cm90ZToKPiA+PiBGcm9tOiBaaGFuZyBZYW5mZWkgPHpoYW5neWFuZmVpQGNuLmZ1aml0c3Uu
Y29tPgo+ID4+Cj4gPj4gU2luY2Ugd2UgaGF2ZSB0aGUgZXJyKCkgaW50ZXJmYWNlLCBzbyByZXBs
YWNlIHRoZSBlcnJvciBwcmludGluZwo+ID4+IGZ1bmN0aW9uIHdpdGggZXJyKCkuCj4gPiAKPiA+
IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIGxvdCBvZiBjb2RlIGNoYW5nZXMgYW5kIEknbSBub3Qg
ZW50aXJlbHkKPiA+IHN1cmUgdGhhdCBJIHNlZSB0aGUgYmVuZWZpdC4KPiAKPiBTb3JyeSBmb3Ig
dGhlIGxvbmcgcGF0Y2guCj4gCj4gSSBqdXN0IHdhbnRlZCB0byB1c2UgYSBzaW1wbGVyIGVycm9y
IGRpc3BsYXlpbmcgZnVuY3Rpb24gaW5zdGVhZCBvZgo+IGZwcmludGYoc3RkZXJyLCAuLi4pLiBK
dXN0IGxpa2Ugd2UgdXNlIGRpZSgpIG9yIGRiZ3ByaW50Zi4gSWYgeW91Cj4gdGhpbmsgdGhpcyBp
cyB1bm5lY2Vzc2FyeSwganVzdCBpZ25vcmUgdGhlIHBhdGNoIHBsZWFzZS4KCkkgdGhpbmsgdGhh
dCBJIHdvdWxkIHByZWZlciB0byBub3QgYWNjZXB0IHRoaXMgcGF0Y2ggYXQgdGhpcyB0aW1lLgpU
aGFua3MgYWxsIHRoZSBzYW1lLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
