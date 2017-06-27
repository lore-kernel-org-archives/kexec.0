Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dPgRN-0008Il-SQ
 for kexec@lists.infradead.org; Tue, 27 Jun 2017 02:41:23 +0000
Received: by mail-pf0-x242.google.com with SMTP id e199so2722331pfh.0
 for <kexec@lists.infradead.org>; Mon, 26 Jun 2017 19:41:00 -0700 (PDT)
Message-ID: <1498531003.1734.13.camel@gmail.com>
Subject: Re: [PATCH] kexec:arm: support zImage with appended device tree
From: Hoeun Ryu <hoeun.ryu@gmail.com>
Date: Tue, 27 Jun 2017 11:36:43 +0900
In-Reply-To: <20170626091412.GE837@flint.armlinux.org.uk>
References: <1498208138-19283-1-git-send-email-hoeun.ryu@gmail.com>
 <20170626091412.GE837@flint.armlinux.org.uk>
Mime-Version: 1.0
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
To: Russell King <rmk@armlinux.org.uk>
Cc: Matthew Leach <matthew.leach@arm.com>, Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Wang Nan <wangnan0@huawei.com>

T24gTW9uLCAyMDE3LTA2LTI2IGF0IDEwOjE0ICswMTAwLCBSdXNzZWxsIEtpbmcgd3JvdGU6Cj4g
T24gRnJpLCBKdW4gMjMsIDIwMTcgYXQgMDU6NTU6MzhQTSArMDkwMCwgSG9ldW4gUnl1IHdyb3Rl
Ogo+ID4gCj4gPiBBcm0gbGludXggc3VwcG9ydHMgekltYWdlIHdpdGggYXBwZW5kZWQgZHRiCj4g
PiAoQ09ORklHX0FSTV9BUFBFTkRFRF9EVEIpIGFuZAo+ID4gdGhlIGNvbmNhdGVuYXRlZCBpbWFn
ZSBpcyBnZW5lcmF0ZWQgbGlrZSBgY2F0IHpJbWFnZSBkdGIgPgo+ID4gekltYWdlX3dfZHRiYC4K
PiBXZSBzdXBwb3J0IHRoYXQgb25seSBmb3IgdGhlIHB1cnBvc2Ugb2YgYWxsb3dpbmcgb2xkIGJv
b3QgbG9hZGVycwo+IHRoYXQKPiBhcmUgbm90IERUIGF3YXJlIHRvIGxvYWQga2VybmVscyB0aGF0
IHJlcXVpcmUgRFQuwqDCoElmIGl0IHdlcmVuJ3QgZm9yCj4gdGhhdCwgd2Ugd291bGRuJ3QgaGF2
ZSBpdC4KPiAKPiBJIGRvbid0IHNlZSB3aHkgd2Ugc2hvdWxkIHByb3BhZ2F0ZSB0aGlzIGhhY2sg
dG8gb3RoZXIgc3lzdGVtcyBzdWNoCj4gYXMKPiBrZXhlYywgZXNwZWNpYWxseSB3aGVuIHRoZXkg
aGF2ZSBuYXRpdmUgRFQgc3VwcG9ydC4KPiAKCldlIGhhdmUgc29tZSBjYXNlcyB3aGVuIHdlIHdv
dWxkIGxpa2UgdG8gdXNlIGRpZmZlcmVudCBkdGIgZnJvbSB0aGUKcnVubmluZyBzeXN0ZW0gd2hl
biB1c2luZyBrZXhlYyBhbmQgSSB0aGluayB0aGF0J3Mgd2h5IGtleGVjLXRvb2xzCnN1cHBvcnRz
IC0tZHRiIGNvbW1hbmQgbGluZSBvcHRpb24uCgpGb3IgZXhhbXBsZSwgSSBoYXZlIHRoZSBzZWNv
bmQga2VybmVsIGZvciB0aGUgY3Jhc2ggZHVtcCB3aXRoIGRpZmZlcmVudAprZXJuZWwgY29uZmln
dXJhdGlvbiBhbmQgdGhlIGRpZmZlcmVudCBkdGIgZnJvbSB0aGUgcnVubmluZyBzeXN0ZW0uIEkn
ZApsaWtlIHRvIGV4Y2x1ZGUgc29tZSBub2Rlcy9wcm9wZXJ0aWVzIGZyb20gZHRiIGxpa2UgbWVt
b3J5IHJlc2VydmF0aW9ucwpvciB1bm5lY2Vzc2FyeSBkZXZpY2VzIHRvIGtlZXAgdGhlIHNlY29u
ZCBrZXJuZWwvZHRiIG1pbmltYWwuCgpUaGUgY29uY2F0ZW5hdGVkIHpJbWFnZSBmb3IgYXJtIGhh
cyBhIGJlbmVmaXQgKHdoZXRoZXIgaXQncyBpbnRlbmRlZCBvcgpub3QpIHRvIG1ha2UgaXQgcG9z
c2libGUgZm9yIHVzZXJzIHRvIG1lcmdlIG11bHRpcGxlIGJvb3QgaW1hZ2VzIGludG8gYQpzaW1w
bGUgc2luZ2xlIGZpbGUuCldoYXQgSSdkIGxpa2UgdG8gZG8gaXMganVzdCB0byBzdXBwb3J0IHRo
ZSBjb25jYXRlbmF0ZWQgekltYWdlIHNvIHRoYXQKdXNlcnMgY2FuIHVzZSAtLWxvYWQoLXBhbmlj
KSB6SW1hZ2Vfd2l0aF9kdGJfZnJvbV90aGVfcnVubmluZ19zeXN0ZW0KaW5zdGVhZCBvZiAtLWxv
YWQoLXBhbmljKSB6SW1hZ2UgLS1kdGIKZGlmZmVyZW50X2R0Yl9mcm9tX3RoZV9ydW5uaW5nX3N5
c3RlbS4KClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4KCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
