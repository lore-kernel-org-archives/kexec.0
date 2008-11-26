Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L5GGV-0005iI-5l
	for kexec@lists.infradead.org; Wed, 26 Nov 2008 09:00:55 +0000
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 75D524645C
	for <kexec@lists.infradead.org>; Wed, 26 Nov 2008 10:00:52 +0100 (CET)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Fix compile warnings in get_memory_ranges()
Date: Wed, 26 Nov 2008 10:00:52 +0100
Message-Id: <1227690052-16219-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Bernhard Walle <bwalle@suse.de>

VGhpcyBwYXRjaCBmaXhlczoKCiAgICAgICAga2V4ZWMvYXJjaC9pMzg2L2tleGVjLXg4Ni1jb21t
b24uYzogSW4gZnVuY3Rpb24g4oCYZ2V0X21lbW9yeV9yYW5nZXPigJk6CiAgICAgICAga2V4ZWMv
YXJjaC9pMzg2L2tleGVjLXg4Ni1jb21tb24uYzoxODk6IFwKICAgICAgICAgICAgICAgIHdhcm5p
bmc6IHBhc3NpbmcgYXJndW1lbnQgMiBvZiDigJhwYXJzZV9pb21lbV9zaW5nbGXigJkgZnJvbSBp
bmNvbXBhdGlibGUgcG9pbnRlciB0eXBlCiAgICAgICAga2V4ZWMvYXJjaC9pMzg2L2tleGVjLXg4
Ni1jb21tb24uYzoxODk6IFwKICAgICAgICAgICAgICAgIHdhcm5pbmc6IHBhc3NpbmcgYXJndW1l
bnQgMyBvZiDigJhwYXJzZV9pb21lbV9zaW5nbGXigJkgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRl
ciB0eXBlCgpZZXMsIHRoYXQgd2FzIG15IG93biBjb2RlLiA6LSgKCgpTaWduZWQtb2ZmLWJ5OiBC
ZXJuaGFyZCBXYWxsZSA8YndhbGxlQHN1c2UuZGU+Ci0tLQoga2V4ZWMvYXJjaC9pMzg2L2tleGVj
LXg4Ni1jb21tb24uYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tleGVjL2FyY2gvaTM4Ni9rZXhlYy14ODYt
Y29tbW9uLmMgYi9rZXhlYy9hcmNoL2kzODYva2V4ZWMteDg2LWNvbW1vbi5jCmluZGV4IDE0NTM3
ODAuLmE0NjgyNzIgMTAwNjQ0Ci0tLSBhL2tleGVjL2FyY2gvaTM4Ni9rZXhlYy14ODYtY29tbW9u
LmMKKysrIGIva2V4ZWMvYXJjaC9pMzg2L2tleGVjLXg4Ni1jb21tb24uYwpAQCAtMTg0LDcgKzE4
NCw3IEBAIGludCBnZXRfbWVtb3J5X3JhbmdlcyhzdHJ1Y3QgbWVtb3J5X3JhbmdlICoqcmFuZ2Us
IGludCAqcmFuZ2VzLAogCSAqLwogCWlmICgoa2V4ZWNfZmxhZ3MgJiBLRVhFQ19PTl9DUkFTSCkg
JiYKIAkgICAgIShrZXhlY19mbGFncyAmIEtFWEVDX1BSRVNFUlZFX0NPTlRFWFQpKSB7Ci0JCXVu
c2lnbmVkIGxvbmcgbG9uZyBzdGFydCwgZW5kOworCQl1aW50NjRfdCBzdGFydCwgZW5kOwogCiAJ
CXJldCA9IHBhcnNlX2lvbWVtX3NpbmdsZSgiQ3Jhc2gga2VybmVsXG4iLCAmc3RhcnQsICZlbmQp
OwogCQlpZiAocmV0ICE9IDApIHsKLS0gCjEuNi4wLjIKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
