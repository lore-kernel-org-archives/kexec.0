Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UWyXT-0007JO-Hq
 for kexec@lists.infradead.org; Tue, 30 Apr 2013 00:35:24 +0000
Date: Tue, 30 Apr 2013 09:34:48 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Revert "kexec: include reserved e820 sections in crash
 kernel"
Message-ID: <20130430003448.GA14868@verge.net.au>
References: <5157A9B5.1040704@gmail.com>
 <515AB71F.3080307@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <515AB71F.3080307@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Cliff Wickman <cpw@sgi.com>

T24gVHVlLCBBcHIgMDIsIDIwMTMgYXQgMDY6NDY6NTVQTSArMDgwMCwgWmhhbmcgWWFuZmVpIHdy
b3RlOgo+IOS6jiAyMDEz5bm0MDPmnIgzMeaXpSAxMToxMiwgWmhhbmcgWWFuZmVpIOWGmemBkzoK
PiA+IEZyb206IFpoYW5nIFlhbmZlaSA8emhhbmd5YW5mZWlAY24uZnVqaXRzdS5jb20+Cj4gPiAK
PiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgZTM1YWEyOWZiNDBiMzdiZjg2ZDk4MGIyZTE5YWY1ZTAx
YzJkMjU0OS4KPiA+IFRoaXMgcGF0Y2ggaXMgYmFzZWQgb24gdGhlIGNvbW1pdCA0OTMyMDM0MGY3
MDU2OTRlMzg3ZDc5NGY3ZjE5ZDQwN2FkOWJhZWZhCj4gPiAgICAgICJrZXhlYzogbGVuZ3RoZW4g
dGhlIGtlcm5lbCBjb21tYW5kIGxpbmUgaW1hZ2UiCj4gPiBTaW5jZSB0aGUgbGF0dGVyIGNvbW1p
dCBoYXMgYmVlbiByZXZlcnRlZCBkdWUgdG8gaXRzIHVzZWxlc3MsIHRoaXMKPiA+IHBhdGNoIHNo
b3VsZCBiZSByZXZlcnRlZCB0b28uCj4gPiAKPiA+IEJlc2lkZXMsIFRoaXMgcGF0Y2ggYWxzbyBj
aGFuZ2VkIGEga2VybmVsIHJlc3RyaWN0aW9uIG9mIG1heCBzZWdtZW50cwo+ID4gZnJvbSAxNiB0
byA3MC4gVGhvdWdoIGtleGVjLXRvb2xzIGNvdWxkIGhhdmUgbW9yZSBzZWdtZW50cywgbW9yZSB0
aGFuIDE2LAo+ID4gdGhlIGtleGVjX2xvYWQgc3lzY2FsbCB3aWxsIHN0aWxsIGZhaWwgZm9yIHRo
ZSBrZXJuZWwgc2lkZSBoYXMgYSByZXN0cmljdGlvbgo+ID4gb2YgMTYuCj4gPiAKPiA+IENjOiBD
bGlmZiBXaWNrbWFuIDxjcHdAc2dpLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW5nIFlhbmZl
aSA8emhhbmd5YW5mZWlAY24uZnVqaXRzdS5jb20+Cj4gPiAtLS0KPiA+ICBrZXhlYy9hcmNoL2kz
ODYvY3Jhc2hkdW1wLXg4Ni5jIHwgICAzMSArKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4gPiAga2V4ZWMva2V4ZWMtc3lzY2FsbC5oICAgICAgICAgICB8ICAgIDIgKy0KPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pCj4KPiBwaW5nLi4u
CgpTb3JyeSBmb3IgdGhlIGV4dGVuZGVkIGRlbGF5LCBhcHBsaWVkLgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
