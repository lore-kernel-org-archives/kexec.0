Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7dHf-0007Hj-NH
 for kexec@lists.infradead.org; Tue, 10 Sep 2019 10:22:05 +0000
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6FCA53B3C0
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2019 10:22:03 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id x1so3386685pfn.19
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2019 03:22:03 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 2/2] i386/kexec-mb2-x86.c: Fix compilation warning
Date: Tue, 10 Sep 2019 15:51:50 +0530
Message-Id: <20190910102150.7229-3-bhsharma@redhat.com>
In-Reply-To: <20190910102150.7229-1-bhsharma@redhat.com>
References: <20190910102150.7229-1-bhsharma@redhat.com>
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
Cc: bhsharma@redhat.com, bhupesh.linux@gmail.com, horms@verge.net.au

VGhpcyBwYXRjaCBmaXhlcyB0aGUgZm9sbG93aW5nIGNvbXBpbGF0aW9uIHdhcm5pbmcgaW4KJ2kz
ODYva2V4ZWMtbWIyLXg4Ni5jJyByZWdhcmRpbmcgdGhlIHZhcmlhYmxlICdyZXN1bHQnCndoaWNo
IGlzIHNldCBidXQgbm90IHVzZWQ6CgprZXhlYy9hcmNoL2kzODYva2V4ZWMtbWIyLXg4Ni5jOjQw
Mjo2Ogogd2FybmluZzogdmFyaWFibGUg4oCYcmVzdWx04oCZIHNldCBidXQgbm90IHVzZWQgWy1X
dW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCiAgaW50IHJlc3VsdDsKICAgICAgXn5+fn5+CgpDYzog
U2ltb24gSG9ybWFuIDxob3Jtc0B2ZXJnZS5uZXQuYXU+ClNpZ25lZC1vZmYtYnk6IEJodXBlc2gg
U2hhcm1hIDxiaHNoYXJtYUByZWRoYXQuY29tPgotLS0KIGtleGVjL2FyY2gvaTM4Ni9rZXhlYy1t
YjIteDg2LmMgfCAyIC0tCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9rZXhlYy9hcmNoL2kzODYva2V4ZWMtbWIyLXg4Ni5jIGIva2V4ZWMvYXJjaC9pMzg2L2tl
eGVjLW1iMi14ODYuYwppbmRleCA3ZWFhYjBjLi5iODM5ZDU5IDEwMDY0NAotLS0gYS9rZXhlYy9h
cmNoL2kzODYva2V4ZWMtbWIyLXg4Ni5jCisrKyBiL2tleGVjL2FyY2gvaTM4Ni9rZXhlYy1tYjIt
eDg2LmMKQEAgLTM5OSw3ICszOTksNiBAQCBpbnQgbXVsdGlib290Ml94ODZfbG9hZChpbnQgYXJn
YywgY2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKmJ1Ziwgb2ZmX3QgbGVuLAogCWNoYXIgKmNvbW1h
bmRfbGluZSA9IE5VTEwsICp0bXBfY21kbGluZSA9IE5VTEw7CiAJaW50IGNvbW1hbmRfbGluZV9s
ZW47CiAJY2hhciAqaW1hZ2VuYW1lLCAqY3AsICphcHBlbmQgPSBOVUxMOzsKLQlpbnQgcmVzdWx0
OwogCWludCBvcHQ7CiAJaW50IG1vZHVsZXMsIG1vZF9jb21tYW5kX2xpbmVfc3BhY2U7CiAJdWlu
dDY0X3QgbWJpX3B0cjsKQEAgLTQyOSw3ICs0MjgsNiBAQCBpbnQgbXVsdGlib290Ml94ODZfbG9h
ZChpbnQgYXJnYywgY2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKmJ1Ziwgb2ZmX3QgbGVuLAogCWNv
bW1hbmRfbGluZV9sZW4gPSAwOwogCW1vZHVsZXMgPSAwOwogCW1vZF9jb21tYW5kX2xpbmVfc3Bh
Y2UgPSAwOwotCXJlc3VsdCA9IDA7CiAJd2hpbGUoKG9wdCA9IGdldG9wdF9sb25nKGFyZ2MsIGFy
Z3YsIHNob3J0X29wdGlvbnMsIG9wdGlvbnMsIDApKSAhPSAtMSkKIAl7CiAJCXN3aXRjaChvcHQp
IHsKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
