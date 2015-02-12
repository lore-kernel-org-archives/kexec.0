Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x236.google.com ([2607:f8b0:400e:c03::236])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YLpKR-0006dI-Oy
 for kexec@lists.infradead.org; Thu, 12 Feb 2015 08:40:56 +0000
Received: by mail-pa0-f54.google.com with SMTP id kx10so9924838pab.13
 for <kexec@lists.infradead.org>; Thu, 12 Feb 2015 00:40:33 -0800 (PST)
From: Ameya Palande <2ameya@gmail.com>
Subject: [PATCH] i386: bzImage: Fix -Wunused-but-set-variable compilation
 warning
Date: Thu, 12 Feb 2015 00:40:18 -0800
Message-Id: <1423730418-5173-1-git-send-email-2ameya@gmail.com>
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
Cc: Simon Horman <horms@verge.net.au>, Ameya Palande <2ameya@gmail.com>

a2V4ZWMvYXJjaC9pMzg2L2tleGVjLWJ6SW1hZ2UuYzoxMTE6ODogd2FybmluZzogdmFyaWFibGUK
4oCYa2VybmVsX3ZlcnNpb27igJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12
YXJpYWJsZV0KClNpZ25lZC1vZmYtYnk6IEFtZXlhIFBhbGFuZGUgPDJhbWV5YUBnbWFpbC5jb20+
Ci0tLQoga2V4ZWMvYXJjaC9pMzg2L2tleGVjLWJ6SW1hZ2UuYyB8IDIgLS0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tleGVjL2FyY2gvaTM4Ni9rZXhlYy1i
ekltYWdlLmMgYi9rZXhlYy9hcmNoL2kzODYva2V4ZWMtYnpJbWFnZS5jCmluZGV4IGU3YmMxZDYu
LmRmODk4NWQgMTAwNjQ0Ci0tLSBhL2tleGVjL2FyY2gvaTM4Ni9rZXhlYy1iekltYWdlLmMKKysr
IGIva2V4ZWMvYXJjaC9pMzg2L2tleGVjLWJ6SW1hZ2UuYwpAQCAtMTA4LDcgKzEwOCw2IEBAIGlu
dCBkb19iekltYWdlX2xvYWQoc3RydWN0IGtleGVjX2luZm8gKmluZm8sCiAJc3RydWN0IHg4Nl9s
aW51eF9oZWFkZXIgc2V0dXBfaGVhZGVyOwogCXN0cnVjdCB4ODZfbGludXhfcGFyYW1faGVhZGVy
ICpyZWFsX21vZGU7CiAJaW50IHNldHVwX3NlY3RzOwotCWNoYXIgKmtlcm5lbF92ZXJzaW9uOwog
CXNpemVfdCBzaXplOwogCWludCBrZXJuMTZfc2l6ZTsKIAl1bnNpZ25lZCBsb25nIHNldHVwX2Jh
c2UsIHNldHVwX3NpemU7CkBAIC0xMzQsNyArMTMzLDYgQEAgaW50IGRvX2J6SW1hZ2VfbG9hZChz
dHJ1Y3Qga2V4ZWNfaW5mbyAqaW5mbywKIAl9CiAKIAlrZXJuMTZfc2l6ZSA9IChzZXR1cF9zZWN0
cyArMSkgKjUxMjsKLQlrZXJuZWxfdmVyc2lvbiA9ICgoY2hhciAqKSZzZXR1cF9oZWFkZXIpICsg
NTEyICsgc2V0dXBfaGVhZGVyLmt2ZXJfYWRkcjsKIAlpZiAoa2VybmVsX2xlbiA8IGtlcm4xNl9z
aXplKSB7CiAJCWZwcmludGYoc3RkZXJyLCAiQnpJbWFnZSB0cnVuY2F0ZWQ/XG4iKTsKIAkJcmV0
dXJuIC0xOwotLSAKMS44LjMuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
