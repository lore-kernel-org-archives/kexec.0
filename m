Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yfu6H-0007y9-23
 for kexec@lists.infradead.org; Wed, 08 Apr 2015 17:49:18 +0000
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
Subject: [PATCH] configure.ac: Fix failure caused by x32 ABI test
Date: Wed,  8 Apr 2015 12:48:58 -0500
Message-Id: <1428515338-4374-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>

V2hlbiB0cnkgdG8gY29tcGlsZSB3aXRoIHpsaWIgZmFpbHMgZHVlIHRvIGNvbmZpZ3VyZS5hYwpi
YWQgZXhwYW5zaW9uIGNhdXNlZCBieSB4MzIgQUJJIHRlc3QgdGhhdCBuZWVkcyBBQ19QUk9HX0ND
CmZvciB1c2UgQUNfRUdSRVBfQ1BQLgoKU2lnbmVkLW9mZi1ieTogQW7DrWJhbCBMaW3Ds24gPGFu
aWJhbC5saW1vbkBsaW51eC5pbnRlbC5jb20+Ci0tLQogY29uZmlndXJlLmFjIHwgNCArLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvY29uZmlndXJlLmFjIGIvY29uZmlndXJlLmFjCmluZGV4IDFlY2FkZDUuLmUwYjVmNzggMTAw
NjQ0Ci0tLSBhL2NvbmZpZ3VyZS5hYworKysgYi9jb25maWd1cmUuYWMKQEAgLTgsNiArOCw3IEBA
IEFDX0lOSVQoa2V4ZWMtdG9vbHMsIDIuMC4xMC5naXQpCiBBQ19DT05GSUdfQVVYX0RJUiguL2Nv
bmZpZykKIEFDX0NPTkZJR19IRUFERVJTKFtpbmNsdWRlL2NvbmZpZy5oXSkKIEFDX0xBTkcoQykK
K0FDX1BST0dfQ0MKIAogQUNfREVGSU5FX1VOUVVPVEVEKFBBQ0tBR0VfREFURSwgImBkYXRlICcr
JWQgJUIgJVknYCIsCiAJCVtEZWZpbmUgdG8gdGhlIHJlbGVhc2UgZGF0ZSBvZiB0aGlzIHBhY2th
Z2VdKQpAQCAtMTA2LDkgKzEwNyw2IEBAIEFDX0FSR19XSVRIKFtib29rZV0sCiAKIGRubCAtLS1Q
cm9ncmFtcwogZG5sIFRvIHNwZWNpZnkgYSBkaWZmZXJlbnQgY29tcGlsZXIsIGp1c3QgJ2V4cG9y
dCBDQz0vcGF0aC90by9jb21waWxlcicKLQotQUNfUFJPR19DQwotCiBpZiB0ZXN0ICIke2J1aWxk
fSIgIT0gIiR7aG9zdH0iIDsgdGhlbgogCUFDX0NIRUNLX1BST0dTKEJVSUxEX0NDLCBbJHtidWls
ZF9hbGlhc30tZ2NjICR7YnVpbGR9LWdjYyBnY2NdKQogZWxzZQotLSAKMS45LjEKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxp
c3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
