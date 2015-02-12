Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x232.google.com ([2607:f8b0:400e:c03::232])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YLpF5-0003Kj-Lj
 for kexec@lists.infradead.org; Thu, 12 Feb 2015 08:35:24 +0000
Received: by mail-pa0-f50.google.com with SMTP id hz1so9932918pad.9
 for <kexec@lists.infradead.org>; Thu, 12 Feb 2015 00:35:01 -0800 (PST)
From: Ameya Palande <2ameya@gmail.com>
Subject: [PATCH] i386: elf: Fix -Wunused-but-set-variable compilation warning
Date: Thu, 12 Feb 2015 00:34:26 -0800
Message-Id: <1423730066-4587-1-git-send-email-2ameya@gmail.com>
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

a2V4ZWMvYXJjaC9pMzg2L2tleGVjLWVsZi14ODYuYzo5Nzo2OiB3YXJuaW5nOiB2YXJpYWJsZQri
gJhtb2RpZmllZF9jbWRsaW5lX2xlbuKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQt
c2V0LXZhcmlhYmxlXQogIGludCBtb2RpZmllZF9jbWRsaW5lX2xlbjsKClNpZ25lZC1vZmYtYnk6
IEFtZXlhIFBhbGFuZGUgPDJhbWV5YUBnbWFpbC5jb20+Ci0tLQoga2V4ZWMvYXJjaC9pMzg2L2tl
eGVjLWVsZi14ODYuYyB8IDMgLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9rZXhlYy9hcmNoL2kzODYva2V4ZWMtZWxmLXg4Ni5jIGIva2V4ZWMvYXJjaC9p
Mzg2L2tleGVjLWVsZi14ODYuYwppbmRleCBkMGY5ODM4Li5kZTAwZGNiIDEwMDY0NAotLS0gYS9r
ZXhlYy9hcmNoL2kzODYva2V4ZWMtZWxmLXg4Ni5jCisrKyBiL2tleGVjL2FyY2gvaTM4Ni9rZXhl
Yy1lbGYteDg2LmMKQEAgLTk0LDcgKzk0LDYgQEAgaW50IGVsZl94ODZfbG9hZChpbnQgYXJnYywg
Y2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKmJ1Ziwgb2ZmX3QgbGVuLAogCWNoYXIgKmVycm9yX21z
ZyA9IE5VTEw7CiAJaW50IHJlc3VsdDsKIAlpbnQgY29tbWFuZF9saW5lX2xlbjsKLQlpbnQgbW9k
aWZpZWRfY21kbGluZV9sZW47CiAJY29uc3QgY2hhciAqcmFtZGlzazsKIAl1bnNpZ25lZCBsb25n
IGVudHJ5LCBtYXhfYWRkcjsKIAlpbnQgYXJnX3N0eWxlOwpAQCAtMTIzLDcgKzEyMiw2IEBAIGlu
dCBlbGZfeDg2X2xvYWQoaW50IGFyZ2MsIGNoYXIgKiphcmd2LCBjb25zdCBjaGFyICpidWYsIG9m
Zl90IGxlbiwKIAkgKiBQYXJzZSB0aGUgY29tbWFuZCBsaW5lIGFyZ3VtZW50cwogCSAqLwogCWFy
Z19zdHlsZSA9IEFSR19TVFlMRV9FTEY7Ci0JbW9kaWZpZWRfY21kbGluZV9sZW4gPSAwOwogCXJh
bWRpc2sgPSAwOwogCXJlc3VsdCA9IDA7CiAJd2hpbGUoKG9wdCA9IGdldG9wdF9sb25nKGFyZ2Ms
IGFyZ3YsIHNob3J0X29wdGlvbnMsIG9wdGlvbnMsIDApKSAhPSAtMSkgewpAQCAtMTgwLDcgKzE3
OCw2IEBAIGludCBlbGZfeDg2X2xvYWQoaW50IGFyZ2MsIGNoYXIgKiphcmd2LCBjb25zdCBjaGFy
ICpidWYsIG9mZl90IGxlbiwKIAkJCQkJCUNPTU1BTkRfTElORV9TSVpFKTsKIAkJCW1vZGlmaWVk
X2NtZGxpbmVbQ09NTUFORF9MSU5FX1NJWkUgLSAxXSA9ICdcMCc7CiAJCX0KLQkJbW9kaWZpZWRf
Y21kbGluZV9sZW4gPSBzdHJsZW4obW9kaWZpZWRfY21kbGluZSk7CiAJfQogCiAJLyogTG9hZCB0
aGUgRUxGIGV4ZWN1dGFibGUgKi8KLS0gCjEuOC4zLjEKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
