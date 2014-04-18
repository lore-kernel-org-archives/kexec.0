Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wb9UM-0004B9-2v
 for kexec@lists.infradead.org; Fri, 18 Apr 2014 14:09:58 +0000
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <clg@fr.ibm.com>;
 Fri, 18 Apr 2014 15:09:34 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id D92951B0806B
 for <kexec@lists.infradead.org>; Fri, 18 Apr 2014 15:09:35 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3IE9WJH60686422
 for <kexec@lists.infradead.org>; Fri, 18 Apr 2014 14:09:32 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3IE9Wp4023381
 for <kexec@lists.infradead.org>; Fri, 18 Apr 2014 08:09:32 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
Subject: [PATCH 7/7] ppc64, cleanup: fix unused variable compile warning
Date: Fri, 18 Apr 2014 16:08:40 +0200
Message-Id: <1397830120-13323-8-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1397830120-13323-1-git-send-email-clg@fr.ibm.com>
References: <1397830120-13323-1-git-send-email-clg@fr.ibm.com>
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
Cc: horms@verge.net.au, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>

Li4va2V4ZWMvYXJjaC9wcGM2NC9jcmFzaGR1bXAtcHBjNjQuYzogSW4gZnVuY3Rpb24g4oCYZ2V0
X2NyYXNoX21lbW9yeV9yYW5nZXPigJk6Ci4uL2tleGVjL2FyY2gvcHBjNjQvY3Jhc2hkdW1wLXBw
YzY0LmM6MTg2OjY6IHdhcm5pbmc6IHVudXNlZCB2YXJpYWJsZSDigJhp4oCZIFstV3VudXNlZC12
YXJpYWJsZV0KICBpbnQgaSwgbiwgY3Jhc2hfcm5nX2xlbiA9IDA7CgpTaWduZWQtb2ZmLWJ5OiBD
w6lkcmljIExlIEdvYXRlciA8Y2xnQGZyLmlibS5jb20+Ci0tLQoga2V4ZWMvYXJjaC9wcGM2NC9j
cmFzaGR1bXAtcHBjNjQuYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2tleGVjL2FyY2gvcHBjNjQvY3Jhc2hkdW1w
LXBwYzY0LmMgYi9rZXhlYy9hcmNoL3BwYzY0L2NyYXNoZHVtcC1wcGM2NC5jCmluZGV4IDcxYTA5
ZGJmZjE3Zi4uYTNiNTY2OTdjOGRiIDEwMDY0NAotLS0gYS9rZXhlYy9hcmNoL3BwYzY0L2NyYXNo
ZHVtcC1wcGM2NC5jCisrKyBiL2tleGVjL2FyY2gvcHBjNjQvY3Jhc2hkdW1wLXBwYzY0LmMKQEAg
LTE4NCw3ICsxODQsNyBAQCBzdGF0aWMgaW50IGdldF9jcmFzaF9tZW1vcnlfcmFuZ2VzKHN0cnVj
dCBtZW1vcnlfcmFuZ2UgKipyYW5nZSwgaW50ICpyYW5nZXMpCiAJRElSICpkaXIsICpkbWVtOwog
CUZJTEUgKmZpbGU7CiAJc3RydWN0IGRpcmVudCAqZGVudHJ5LCAqbWVudHJ5OwotCWludCBpLCBu
LCBjcmFzaF9ybmdfbGVuID0gMDsKKwlpbnQgbiwgY3Jhc2hfcm5nX2xlbiA9IDA7CiAJdW5zaWdu
ZWQgbG9uZyBsb25nIHN0YXJ0LCBlbmQ7CiAJaW50IHBhZ2Vfc2l6ZTsKIAotLSAKMS43LjEwLjQK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBt
YWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
