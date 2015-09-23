Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZegAQ-0003tZ-91
 for kexec@lists.infradead.org; Wed, 23 Sep 2015 09:16:46 +0000
Date: Wed, 23 Sep 2015 17:16:21 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [Patch v3] Add persistent memory support
Message-ID: <20150923091621.GA6217@dhcp-128-28.nay.redhat.com>
References: <1439975029-25611-1-git-send-email-bhe@redhat.com>
 <20150819092815.GB6130@localhost.localdomain>
 <20150819104509.GG19950@dhcp-128-28.nay.redhat.com>
 <20150820023812.GA20780@localhost.localdomain>
 <20150820025222.GH19950@dhcp-128-28.nay.redhat.com>
 <20150820074234.GA23537@localhost.localdomain>
 <1440446072.14237.8.camel@hp.com>
 <20150825073719.GB20225@dhcp-129-120.nay.redhat.com>
 <20150902010410.GD30886@verge.net.au>
 <20150923103327.37c2f1ec@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150923103327.37c2f1ec@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.com>
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, Toshi Kani <toshi.kani@hp.com>

T24gMDkvMjMvMTUgYXQgMTA6MzNhbSwgUGV0ciBUZXNhcmlrIHdyb3RlOgoKPiBBcmdoLiBBZnRl
ciBhZGRpbmcgdGhpcyBwYXRjaCwga2V4ZWMtdG9vbHMgbm8gbG9uZ2VyIGJ1aWxkcyAtLXdpdGgt
eGVuOgo+IAo+IGdjYyAtZyAtTzIgLWZuby1zdHJpY3QtYWxpYXNpbmcgLVdhbGwgLVdzdHJpY3Qt
cHJvdG90eXBlcyAtSS4vaW5jbHVkZSAtSS4vdXRpbF9saWIvaW5jbHVkZSAtSWluY2x1ZGUvICAt
SS4va2V4ZWMvYXJjaC94ODZfNjQvaW5jbHVkZSAgLWMgLU1EIC1vIGtleGVjL2FyY2gvaTM4Ni9r
ZXhlYy14ODYtY29tbW9uLm8ga2V4ZWMvYXJjaC9pMzg2L2tleGVjLXg4Ni1jb21tb24uYwo+IGtl
eGVjL2FyY2gvaTM4Ni9rZXhlYy14ODYtY29tbW9uLmM6IEluIGZ1bmN0aW9uIOKAmHhlbl9lODIw
X3RvX2tleGVjX3R5cGXigJk6Cj4ga2V4ZWMvYXJjaC9pMzg2L2tleGVjLXg4Ni1jb21tb24uYzox
NTg6ODogZXJyb3I6IOKAmEU4MjBfUE1FTeKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhp
cyBmdW5jdGlvbikKPiAgICBjYXNlIEU4MjBfUE1FTToKPiAgICAgICAgIF4KPiBrZXhlYy9hcmNo
L2kzODYva2V4ZWMteDg2LWNvbW1vbi5jOjE1ODo4OiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRl
bnRpZmllciBpcyByZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFy
cyBpbgo+IGtleGVjL2FyY2gvaTM4Ni9rZXhlYy14ODYtY29tbW9uLmM6MTYwOjg6IGVycm9yOiDi
gJhFODIwX1BSQU3igJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCj4g
ICAgY2FzZSBFODIwX1BSQU06Cj4gICAgICAgICBeCj4gTWFrZWZpbGU6MTEzOiBuw6F2b2QgcHJv
IGPDrWwg4oCea2V4ZWMvYXJjaC9pMzg2L2tleGVjLXg4Ni1jb21tb24ub+KAnCBzZWxoYWwKPiBt
YWtlOiAqKiogW2tleGVjL2FyY2gvaTM4Ni9rZXhlYy14ODYtY29tbW9uLm9dIENoeWJhIDEKPiAK
PiBUaGlzIGhhcHBlbnMsIGJlY2F1c2Ugb3RoZXIgRTgyMF8qIG1hY3JvcyBhcmUgZGVmaW5lZAo+
IGluIC91c3IvaW5jbHVkZS94ZW5jdHJsLmgsIGJ1dCBub3QgRTgyMF9QTUVNIGFuZCBFODIwX1BS
QU0uCgpJIGRlZmluZWQgRTgyMF9QTUVNIGFuZCBFODIwX1BSQU0gYXMga2VybmVsIGRvZXMuIE1h
eWJlIDIgd2F5czoKMSkgQ2hhbmdlIHRoZW0gaW4gL3Vzci9pbmNsdWRlL3hlbmN0cmwuaAoyKSBB
ZGQgMiBhZGFwdGVyIGZ1bmN0aW9uIHRvIGFkanVzdCB0aGVtIHdoZW4gdGhleSBjb21lIGludG8g
YW5kIGdvIG91dApvZiBrZXhlYy4KCj4gCj4gSSdtIHVuc3VyZSBob3cgdG8gZml4IGl0Lgo+IAo+
IFBldHIgVAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
