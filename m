Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jOHKg-0006MU-IO
 for kexec@lists.infradead.org; Tue, 14 Apr 2020 08:54:16 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200414085411euoutp024fb16012e86ecb6608e60235f126d346~Fo7doy5nB0931509315euoutp02O
 for <kexec@lists.infradead.org>; Tue, 14 Apr 2020 08:54:11 +0000 (GMT)
From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] arm: redefine OPT_APPEND and OPT_RAMDISK
Date: Tue, 14 Apr 2020 10:52:24 +0200
Message-Id: <20200414085224.7069-1-l.stelmach@samsung.com>
MIME-Version: 1.0
References: <CGME20200414085411eucas1p240d872905d55681ab4a3d9bb9f584563@eucas1p2.samsung.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org
Cc: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>

UmVkZWZpbmUgT1BUX0FQUEVORCB0byBhdm9pZCBjbGFzaCB3aXRoIE9QVF9LRVhFQ19TWVNDQUxM
X0FVVE8uClJlZGVmaW5lIE9QVF9SQU1ESVNLIHRvIGF2b2lkIHN1Y2ggcHJvYmxlbXMgaW4gdGhl
IGZ1dHVyZQoKU2lnbmVkLW9mZi1ieTogxYF1a2FzeiBTdGVsbWFjaCA8bC5zdGVsbWFjaEBzYW1z
dW5nLmNvbT4KLS0tCiBrZXhlYy9hcmNoL2FybS9pbmNsdWRlL2FyY2gvb3B0aW9ucy5oIHwgNCAr
Ky0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2tleGVjL2FyY2gvYXJtL2luY2x1ZGUvYXJjaC9vcHRpb25zLmggYi9rZXhlYy9h
cmNoL2FybS9pbmNsdWRlL2FyY2gvb3B0aW9ucy5oCmluZGV4IGFiYmYzNDkuLjkyNzIzNzggMTAw
NjQ0Ci0tLSBhL2tleGVjL2FyY2gvYXJtL2luY2x1ZGUvYXJjaC9vcHRpb25zLmgKKysrIGIva2V4
ZWMvYXJjaC9hcm0vaW5jbHVkZS9hcmNoL29wdGlvbnMuaApAQCAtNCwxMiArNCwxMiBAQAogI2Rl
ZmluZSBPUFRfRFRfTk9fT0xEX1JPT1QJKE9QVF9NQVgrMCkKICNkZWZpbmUgT1BUX0FSQ0hfTUFY
CQkoT1BUX01BWCsxKQogCi0jZGVmaW5lIE9QVF9BUFBFTkQJJ2EnCi0jZGVmaW5lIE9QVF9SQU1E
SVNLCSdyJwogI2RlZmluZSBPUFRfRFRCCQkoT1BUX0FSQ0hfTUFYKzApCiAjZGVmaW5lIE9QVF9B
VEFHUwkoT1BUX0FSQ0hfTUFYKzEpCiAjZGVmaW5lIE9QVF9JTUFHRV9TSVpFCShPUFRfQVJDSF9N
QVgrMikKICNkZWZpbmUgT1BUX1BBR0VfT0ZGU0VUCShPUFRfQVJDSF9NQVgrMykKKyNkZWZpbmUg
T1BUX0FQUEVORAkoT1BUX0FSQ0hfTUFYKzQpCisjZGVmaW5lIE9QVF9SQU1ESVNLCShPUFRfQVJD
SF9NQVgrNSkKIAogLyogT3B0aW9ucyByZWxldmFudCB0byB0aGUgYXJjaGl0ZWN0dXJlIChleGNs
dWRpbmcgbG9hZGVyLXNwZWNpZmljIG9uZXMpLAogICogaW4gdGhpcyBjYXNlIG5vbmU6Ci0tIAoy
LjI1LjAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
ZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
